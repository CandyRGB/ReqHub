import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';
import 'tree_entry.dart';

/// Wraps a [child] tree row with long-press draggable and (for collections)
/// a drop target.
class DraggableTreeItem extends ConsumerStatefulWidget {
  final TreeEntry entry;
  final Widget child;
  final Set<String> expanded;
  final void Function(String id) onExpand;

  const DraggableTreeItem({
    super.key,
    required this.entry,
    required this.child,
    required this.expanded,
    required this.onExpand,
  });

  @override
  ConsumerState<DraggableTreeItem> createState() => _DraggableTreeItemState();
}

class _DraggableTreeItemState extends ConsumerState<DraggableTreeItem> {
  Timer? _expandTimer;

  @override
  void dispose() {
    _expandTimer?.cancel();
    super.dispose();
  }

  bool _canAccept(TreeEntry dragged) {
    if (widget.entry.id == dragged.id) return false;
    if (dragged.isCollection) {
      final notifier = ref.read(collectionsProvider.notifier);
      if (notifier.isDescendantOf(dragged.id, widget.entry.id)) return false;
    }
    return true;
  }

  Widget _buildFeedback() {
    return Material(
      child: Container(
        height: 28,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerLow,
          border: Border.all(
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.entry.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final rowContent = widget.child;

    Widget item = LongPressDraggable<TreeEntry>(
      data: widget.entry,
      dragAnchorStrategy: pointerDragAnchorStrategy,
      feedback: _buildFeedback(),
      childWhenDragging: Opacity(opacity: 0.3, child: rowContent),
      onDragEnd: (_) => _expandTimer?.cancel(),
      child: widget.entry.isCollection
          ? DragTarget<TreeEntry>(
              onWillAcceptWithDetails: (d) {
                if (!_canAccept(d.data)) return false;
                if (!widget.expanded.contains(widget.entry.id) &&
                    widget.entry.hasChildren) {
                  _expandTimer?.cancel();
                  _expandTimer = Timer(const Duration(milliseconds: 800), () {
                    widget.onExpand(widget.entry.id);
                  });
                }
                return true;
              },
              onAcceptWithDetails: (d) {
                _expandTimer?.cancel();
                final notifier = ref.read(collectionsProvider.notifier);
                if (d.data.isCollection) {
                  notifier.moveCollection(d.data.id, widget.entry.id);
                } else {
                  notifier.moveRequest(d.data.id, widget.entry.id);
                }
              },
              onLeave: (_) => _expandTimer?.cancel(),
              builder: (_, candidateData, _) {
                final targeted = candidateData.isNotEmpty;
                return Container(
                  decoration: targeted
                      ? BoxDecoration(
                          border: Border.all(color: cs.primary, width: 1),
                          borderRadius: BorderRadius.circular(4),
                        )
                      : null,
                  child: rowContent,
                );
              },
            )
          : rowContent,
    );

    return item;
  }
}
