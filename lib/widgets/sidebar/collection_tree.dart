// Compact collection tree — VS Code style, flat rows.
// Thin orchestrator; rendering / editing / menus / drag are delegated to
// sibling files in this directory.
import 'dart:async';

import 'package:flutter/services.dart' show Clipboard, ClipboardData;
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/collection.dart';
import '../../models/http_request.dart';
import '../../providers/providers.dart';
import '../../services/curl_generator.dart';
import '../context_menu.dart';
import 'tree_context_menu.dart';
import 'tree_drag_handler.dart';
import 'tree_entry.dart';
import 'tree_flattener.dart';
import 'tree_inline_editor.dart';
import 'tree_item_tile.dart';

class CollectionTree extends ConsumerStatefulWidget {
  final List<Collection> collections;
  final List<HttpRequestModel> rootRequests;
  final void Function(HttpRequestModel) onRequestSelected;
  final void Function(String) onCollectionSelected;
  final VoidCallback? onDeselect;
  final String? selectedRequestId;
  final String? selectedCollectionId;
  final String? editingId; // only for rename, set by SidebarPanel
  final String?
  expandCollectionId; // auto-expand on next build, reset after use
  final void Function(String id)? onEditingDone;

  const CollectionTree({
    super.key,
    required this.collections,
    this.rootRequests = const [],
    required this.onRequestSelected,
    required this.onCollectionSelected,
    this.onDeselect,
    this.selectedRequestId,
    this.selectedCollectionId,
    this.editingId,
    this.expandCollectionId,
    this.onEditingDone,
  });

  @override
  ConsumerState<CollectionTree> createState() => _CollectionTreeState();
}

class _CollectionTreeState extends ConsumerState<CollectionTree> {
  List<TreeEntry> _entries = [];
  final Set<String> _expanded = {};
  String? _selectedId;
  String? _hoveredId;
  Timer? _expandTimer;

  // Inline editing
  final _editController = TextEditingController();
  final _editFocusNode = FocusNode();
  String? _editingId;

  @override
  void initState() {
    super.initState();
    _editFocusNode.addListener(_onEditFocusLost);
    _flatten();
  }

  @override
  void didUpdateWidget(CollectionTree old) {
    super.didUpdateWidget(old);

    final editingChanged =
        widget.editingId != null && widget.editingId != _editingId;
    if (editingChanged) {
      _startEditing(widget.editingId!);
      return;
    }

    // Sync tree selection when parent changes (e.g., tab switch)
    if (widget.selectedRequestId != old.selectedRequestId ||
        widget.selectedCollectionId != old.selectedCollectionId) {
      final newSel =
          (widget.selectedRequestId != null &&
              widget.selectedRequestId!.isNotEmpty)
          ? widget.selectedRequestId!
          : (widget.selectedCollectionId != null &&
                widget.selectedCollectionId!.isNotEmpty)
          ? widget.selectedCollectionId!
          : null;
      if (newSel != _selectedId) {
        setState(() => _selectedId = newSel);
      }
    }

    var needFlatten = false;

    if (widget.expandCollectionId != null &&
        widget.expandCollectionId != old.expandCollectionId &&
        !_expanded.contains(widget.expandCollectionId!)) {
      _expanded.add(widget.expandCollectionId!);
      needFlatten = true;
    }

    if (old.collections != widget.collections ||
        old.rootRequests != widget.rootRequests) {
      needFlatten = true;
    }

    if (needFlatten) _flatten();
  }

  @override
  void dispose() {
    _editController.dispose();
    _editFocusNode.dispose();
    _expandTimer?.cancel();
    ContextMenu.dismiss();
    super.dispose();
  }

  // ─── Flatten ──────────────────────────────────────────────────────

  void _flatten() {
    setState(() {
      _entries = flattenTree(
        widget.collections,
        widget.rootRequests,
        _expanded,
      );
    });
  }

  // ─── Selection ────────────────────────────────────────────────────

  void _toggleExpand(String id) {
    setState(() {
      if (_expanded.contains(id)) {
        _expanded.remove(id);
      } else {
        _expanded.add(id);
      }
      _flatten();
    });
  }

  void _select(String id, bool isCollection) {
    setState(() => _selectedId = id);
    if (isCollection) {
      widget.onCollectionSelected(id);
    } else {
      final req = _findRequest(id);
      if (req != null) widget.onRequestSelected(req);
    }
  }

  void _deselectAll() {
    if (_editingId != null) return; // don't disturb inline editing
    setState(() => _selectedId = null);
    widget.onDeselect?.call();
  }

  HttpRequestModel? _findRequest(String id) {
    for (final r in widget.rootRequests) {
      if (r.id == id) return r;
    }
    return ref.read(collectionsProvider.notifier).findRequest(id);
  }

  // ─── Inline editing ───────────────────────────────────────────────

  void _startEditing(String id) {
    _editingId = id;

    // Expand all ancestors
    var current = id;
    while (true) {
      final p =
          ref.read(collectionsProvider.notifier).findRequestParentId(current) ??
          _collectionParentId(current);
      if (p == null) break;
      _expanded.add(p);
      current = p;
    }
    _flatten();

    final entry = _entries.isNotEmpty
        ? _entries.firstWhere((e) => e.id == id, orElse: () => _entries.first)
        : TreeEntry(depth: 0, kind: TreeEntryKind.request, id: id, name: '');
    _editController.text = entry.name;
    _editController.selection = TextSelection(
      baseOffset: 0,
      extentOffset: _editController.text.length,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _editFocusNode.requestFocus();
    });
  }

  void _closeTabsForCollection(Collection col) {
    final tabsNotifier = ref.read(requestTabsProvider.notifier);
    for (final r in col.requests) {
      tabsNotifier.closeRequestTab(r.id);
    }
    for (final c in col.children) {
      _closeTabsForCollection(c);
    }
  }

  String? _collectionParentId(String id) {
    for (final c in widget.collections) {
      final found = _findCollectionParent(c, id);
      if (found != null) return found;
    }
    return null;
  }

  String? _findCollectionParent(Collection col, String id) {
    if (col.children.any((c) => c.id == id)) return col.id;
    if (col.requests.any((r) => r.id == id)) return col.id;
    for (final child in col.children) {
      final p = _findCollectionParent(child, id);
      if (p != null) return p;
    }
    return null;
  }

  void _onEditFocusLost() {
    if (!_editFocusNode.hasFocus && _editingId != null) _commitEdit();
  }

  void _commitEdit() {
    if (_editingId == null) return;
    final text = _editController.text.trim();
    final id = _editingId!;

    if (text.isNotEmpty) {
      ref.read(collectionsProvider.notifier).renameItem(id, text);
    }

    _editingId = null;
    widget.onEditingDone?.call(id);
  }

  // ─── Context menu ─────────────────────────────────────────────────

  void _onRightTap(TreeEntry entry, TapDownDetails details) {
    setState(() => _selectedId = entry.id);
    _select(entry.id, entry.isCollection);
    _showMenu(entry, details.globalPosition);
  }

  void _showMenu(TreeEntry entry, Offset pos) {
    final notifier = ref.read(collectionsProvider.notifier);
    showTreeContextMenu(
      context,
      pos,
      entry,
      onNewRequest: () {
        final blank = HttpRequestModel(
          id: '',
          name: 'New Request',
          method: 'GET',
        );
        final parentId = entry.isCollection
            ? entry.id
            : notifier.findRequestParentId(entry.id);
        notifier.addRequest(parentId, blank);
      },
      onNewCollection: () {
        final parentId = entry.isCollection
            ? entry.id
            : notifier.findRequestParentId(entry.id);
        notifier.addCollection('New Collection', parentId: parentId);
      },
      onExportCurl: entry.isCollection
          ? null
          : () {
              final req = _findRequest(entry.id);
              if (req != null) {
                Clipboard.setData(
                  ClipboardData(text: CurlGenerator.generate(req)),
                );
              }
            },
      onDuplicate: () {
        if (entry.isCollection) {
          final col = notifier.findCollection(entry.id);
          if (col != null) notifier.addCollection('${col.name} (copy)');
        } else {
          notifier.duplicateRequest(entry.id);
        }
      },
      onRename: () => _startEditing(entry.id),
      onDelete: () {
        if (entry.isCollection) {
          final col = notifier.findCollection(entry.id);
          if (col != null) _closeTabsForCollection(col);
          notifier.deleteCollection(entry.id);
        } else {
          notifier.deleteRequest(entry.id);
          ref.read(requestTabsProvider.notifier).closeRequestTab(entry.id);
        }
      },
    );
  }

  // ─── Build ────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: _deselectAll,
      child: DragTarget<TreeEntry>(
        onWillAcceptWithDetails: (d) => d.data.isCollection,
        onAcceptWithDetails: (d) {
          ref
              .read(collectionsProvider.notifier)
              .moveCollection(d.data.id, null);
        },
        builder: (_, _, _) => ListView.builder(
          itemCount: _entries.length,
          itemExtent: 28,
          itemBuilder: (context, index) {
            final entry = _entries[index];
            final isSelected = entry.id == _selectedId;
            final isEditing = entry.id == _editingId;
            final isHovered = entry.id == _hoveredId;
            final isExpanded =
                entry.isCollection && _expanded.contains(entry.id);

            final tile = TreeItemTile(
              entry: entry,
              isSelected: isSelected,
              isHovered: isHovered,
              isEditing: isEditing,
              isExpanded: isExpanded,
              editWidget: isEditing
                  ? InlineEditField(
                      controller: _editController,
                      focusNode: _editFocusNode,
                      onSubmit: _commitEdit,
                    )
                  : null,
              onTap: isEditing
                  ? null // null → GestureDetector won't register tap recognizer,
                  // so EditableText can receive taps to position cursor
                  : () {
                      _select(entry.id, entry.isCollection);
                      if (entry.hasChildren) _toggleExpand(entry.id);
                    },
              onChevronTap: entry.hasChildren
                  ? () => _toggleExpand(entry.id)
                  : null,
              onSecondaryTap: isEditing ? null : (d) => _onRightTap(entry, d),
            );

            return MouseRegion(
              onEnter: (_) {
                if (_hoveredId != entry.id) {
                  setState(() => _hoveredId = entry.id);
                }
              },
              onExit: (_) {
                if (_hoveredId == entry.id) setState(() => _hoveredId = null);
              },
              child: DraggableTreeItem(
                entry: entry,
                expanded: _expanded,
                onExpand: (id) => _toggleExpand(id),
                child: tile,
              ),
            );
          },
        ),
      ),
    );
  }
}
