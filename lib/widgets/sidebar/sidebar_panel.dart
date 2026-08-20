import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import '../../extensions/localization_ext.dart';
import '../../models/collection.dart';
import '../../models/http_request.dart';
import '../../providers/providers.dart';
import '../compact_menu_item.dart';
import '../curl_import_dialog.dart';
import '../global_message.dart';
import 'collection_tree.dart';

/// The left sidebar: title, toolbar, collection tree, settings link.
class SidebarPanel extends ConsumerStatefulWidget {
  final void Function(HttpRequestModel) onRequestSelected;

  const SidebarPanel({super.key, required this.onRequestSelected});

  @override
  ConsumerState<SidebarPanel> createState() => _SidebarPanelState();
}

class _SidebarPanelState extends ConsumerState<SidebarPanel> {
  String _selectedRequestId = '';
  String _selectedCollectionId = '';
  String _prevActiveId =
      ''; // track tab changes to distinguish from tree clicks
  String? _editingId;
  String? _autoExpandId; // collection to expand after next build
  bool _selectionFromUser =
      false; // true when user explicitly clicked a tree item

  // ─── Toolbar actions ─────────────────────────────────────────────

  /// Resolve the target parent id for a new item.  Only uses the tree
  /// selection when it came from an explicit user click — otherwise
  /// (e.g. tab-synced highlight) the new item goes to root level.
  String? _resolveParentId() {
    if (!_selectionFromUser) return null;
    if (_selectedCollectionId.isNotEmpty) return _selectedCollectionId;
    if (_selectedRequestId.isNotEmpty) {
      return ref
          .read(collectionsProvider.notifier)
          .findRequestParentId(_selectedRequestId);
    }
    return null;
  }

  void _newRequest() {
    final targetId = _resolveParentId();
    final blank = HttpRequestModel(
      id: '',
      name: context.l10n.default_request_name,
      method: 'GET',
    );
    final newId = ref
        .read(collectionsProvider.notifier)
        .addRequest(targetId, blank);
    final req = ref.read(collectionsProvider.notifier).findRequest(newId);
    if (req != null) {
      setState(() {
        _selectedRequestId = newId;
        _selectedCollectionId = '';
        _autoExpandId = targetId;
      });
      widget.onRequestSelected(req);
    }
    // reset auto-expand after this frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(() => _autoExpandId = null);
    });
  }

  void _newCollection() {
    final parentId = _resolveParentId();
    ref
        .read(collectionsProvider.notifier)
        .addCollection(
          context.l10n.default_collection_name,
          parentId: parentId,
        );
    setState(() {
      _selectedCollectionId = '';
      _autoExpandId = parentId;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(() => _autoExpandId = null);
    });
  }

  void _delete() {
    final notifier = ref.read(collectionsProvider.notifier);
    final tabsNotifier = ref.read(requestTabsProvider.notifier);
    if (_selectedRequestId.isNotEmpty) {
      notifier.deleteRequest(_selectedRequestId);
      tabsNotifier.closeRequestTab(_selectedRequestId);
      setState(() => _selectedRequestId = '');
    } else if (_selectedCollectionId.isNotEmpty) {
      _closeTabsInCollection(_selectedCollectionId);
      notifier.deleteCollection(_selectedCollectionId);
      setState(() => _selectedCollectionId = '');
    }
  }

  void _duplicate() {
    final notifier = ref.read(collectionsProvider.notifier);
    if (_selectedRequestId.isNotEmpty) {
      final newId = notifier.duplicateRequest(_selectedRequestId);
      if (newId != null) {
        final req = notifier.findRequest(newId);
        final targetId = _resolveParentId();
        if (req != null) {
          setState(() {
            _selectedRequestId = newId;
            _selectedCollectionId = '';
            _autoExpandId = targetId;
          });
          widget.onRequestSelected(req);
        }
      }
    } else if (_selectedCollectionId.isNotEmpty) {
      final col = notifier.findCollection(_selectedCollectionId);
      if (col != null) {
        notifier.addCollection('${col.name} (copy)');
        setState(() => _autoExpandId = _selectedCollectionId);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) setState(() => _autoExpandId = null);
        });
      }
    }
  }

  void _closeTabsInCollection(String collectionId) {
    final col = ref
        .read(collectionsProvider.notifier)
        .findCollection(collectionId);
    if (col == null) return;
    final tabsNotifier = ref.read(requestTabsProvider.notifier);
    void walk(Collection c) {
      for (final r in c.requests) {
        tabsNotifier.closeRequestTab(r.id);
      }
      for (final child in c.children) {
        walk(child);
      }
    }

    walk(col);
  }

  void _rename() {
    if (_selectedRequestId.isNotEmpty) {
      setState(() {
        _editingId = _selectedRequestId;
      });
    } else if (_selectedCollectionId.isNotEmpty) {
      setState(() {
        _editingId = _selectedCollectionId;
      });
    }
  }

  void _editingDone(String id) {
    setState(() {
      _editingId = null;
    });
  }

  Future<void> _importCurl() async {
    final parsed = await showCurlImportDialog(context);
    if (parsed == null) return; // cancelled
    final colNotifier = ref.read(collectionsProvider.notifier);
    final newId = colNotifier.addRequest(null, parsed);
    final persisted = colNotifier.findRequest(newId);
    ref.read(requestTabsProvider.notifier).openTab(persisted ?? parsed);
    if (!mounted) return;
    showGlobalMessage(context, context.l10n.sidebar_curl_success);
  }

  // ─── Build ────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final rootState = ref.watch(collectionsProvider);

    // Sync tree selection from active tab (only on actual tab switch)
    final tabsState = ref.watch(requestTabsProvider);
    final activeId = tabsState.isEmpty ? '' : tabsState.activeTab.request.id;
    if (_prevActiveId != activeId) {
      _prevActiveId = activeId;
      if (_selectedRequestId != activeId) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            setState(() {
              _selectedRequestId = activeId;
              _selectedCollectionId = '';
              _selectionFromUser = false;
            });
          }
        });
      }
    }

    return Container(
      width: 260,
      decoration: BoxDecoration(
        color: cs.surfaceContainerLow,
        border: Border(right: BorderSide(color: cs.outlineVariant, width: 1)),
      ),
      child: Column(
        children: [
          // Toolbar — height matched to TabView header
          Container(
            height: 37,
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Row(
              children: [
                _CreateSplitButton(
                  onNewRequest: _newRequest,
                  onNewCollection: _newCollection,
                  onImportCurl: _importCurl,
                ),
                const SizedBox(width: 4),
                IconButton(
                  icon: const Icon(FluentIcons.copy_20_regular, size: 20),
                  onPressed: _duplicate,
                ),
                IconButton(
                  icon: const Icon(FluentIcons.rename_20_regular, size: 20),
                  onPressed: _rename,
                ),
                IconButton(
                  icon: const Icon(FluentIcons.delete_20_regular, size: 20),
                  onPressed: _delete,
                ),
              ],
            ),
          ),
          Divider(height: 1),
          // Tree
          Expanded(
            child: CollectionTree(
              collections: rootState.collections,
              rootRequests: rootState.rootRequests,
              onRequestSelected: (req) {
                setState(() {
                  _selectedRequestId = req.id;
                  _selectedCollectionId = '';
                  _selectionFromUser = true;
                });
                widget.onRequestSelected(req);
              },
              onCollectionSelected: (id) => setState(() {
                _selectedCollectionId = id;
                _selectedRequestId = '';
                _selectionFromUser = true;
              }),
              onDeselect: () => setState(() {
                _selectedRequestId = '';
                _selectedCollectionId = '';
                _selectionFromUser = false;
              }),
              selectedRequestId: _selectedRequestId,
              selectedCollectionId: _selectedCollectionId,
              editingId: _editingId,
              expandCollectionId: _autoExpandId,
              onEditingDone: (id) => _editingDone(id),
            ),
          ),
        ],
      ),
    );
  }
}

/// Split button for "create" actions: main tap creates a new request;
/// the dropdown arrow opens a menu with New Request / New Collection / Import cURL.
class _CreateSplitButton extends StatelessWidget {
  final VoidCallback onNewRequest;
  final VoidCallback onNewCollection;
  final VoidCallback onImportCurl;

  const _CreateSplitButton({
    required this.onNewRequest,
    required this.onNewCollection,
    required this.onImportCurl,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FilledButton.tonal(
            onPressed: onNewRequest,
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
              minimumSize: Size.zero,
              visualDensity: VisualDensity.compact,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.horizontal(left: Radius.circular(6)),
              ),
            ),
            child: const Icon(FluentIcons.add_16_regular, size: 18),
          ),
          const SizedBox(width: 1),
          _SplitMenuAnchor(
            onNewRequest: onNewRequest,
            onNewCollection: onNewCollection,
            onImportCurl: onImportCurl,
          ),
        ],
      ),
    );
  }
}

/// The dropdown-arrow half of the split button.
class _SplitMenuAnchor extends StatefulWidget {
  final VoidCallback onNewRequest;
  final VoidCallback onNewCollection;
  final VoidCallback onImportCurl;

  const _SplitMenuAnchor({
    required this.onNewRequest,
    required this.onNewCollection,
    required this.onImportCurl,
  });

  @override
  State<_SplitMenuAnchor> createState() => _SplitMenuAnchorState();
}

class _SplitMenuAnchorState extends State<_SplitMenuAnchor> {
  final _menuController = MenuController();

  @override
  void dispose() {
    _menuController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      controller: _menuController,
      menuChildren: [
        CompactMenuItem(
          leading: const Icon(FluentIcons.add_16_regular, size: 16),
          label: context.l10n.context_new_request,
          onTap: () {
            widget.onNewRequest();
            _menuController.close();
          },
        ),
        CompactMenuItem(
          leading: const Icon(FluentIcons.folder_add_20_regular, size: 16),
          label: context.l10n.context_new_collection,
          onTap: () {
            widget.onNewCollection();
            _menuController.close();
          },
        ),
        CompactMenuItem(
          leading: const Icon(FluentIcons.code_20_regular, size: 16),
          label: context.l10n.sidebar_import_from_curl,
          onTap: () {
            widget.onImportCurl();
            _menuController.close();
          },
        ),
      ],
      child: Material(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: const BorderRadius.horizontal(right: Radius.circular(6)),
        child: InkWell(
          onTap: () => _menuController.open(),
          borderRadius: const BorderRadius.horizontal(
            right: Radius.circular(6),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Icon(FluentIcons.chevron_down_12_regular, size: 12),
          ),
        ),
      ),
    );
  }
}
