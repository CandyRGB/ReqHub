import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import '../../config/colors.dart'; // HTTP method badge colors

import 'tree_entry.dart';

/// Renders one row in the collection tree — chevron, icon, label, method badge.
class TreeItemTile extends StatelessWidget {
  final TreeEntry entry;
  final bool isSelected;
  final bool isHovered;
  final bool isEditing;
  final bool isExpanded;
  final Widget? editWidget; // shown instead of label when editing
  final VoidCallback? onTap;
  final VoidCallback? onChevronTap;
  final void Function(TapDownDetails)? onSecondaryTap;
  final void Function()? onDragStarted;

  const TreeItemTile({
    super.key,
    required this.entry,
    this.isSelected = false,
    this.isHovered = false,
    this.isEditing = false,
    this.isExpanded = false,
    this.editWidget,
    this.onTap,
    this.onChevronTap,
    this.onSecondaryTap,
    this.onDragStarted,
  });

  Color _methodColor(String m) => switch (m) {
    'GET' => methodGet,
    'POST' => methodPost,
    'PUT' => methodPut,
    'PATCH' => methodPatch,
    'DELETE' => methodDelete,
    'HEAD' => methodHead,
    'OPTIONS' => methodOptions,
    _ => methodDefault,
  };

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final indent = entry.depth * 16.0;
    final bgColor = isSelected
        ? cs.primary.withValues(alpha: 0.12)
        : isHovered
        ? cs.primary.withValues(alpha: 0.04)
        : null;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      onSecondaryTapDown: onSecondaryTap,
      child: Container(
        height: 28,
        padding: EdgeInsets.only(left: 8 + indent, right: 12),
        color: bgColor,
        child: Row(
          children: [
            // Expand/collapse chevron
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: entry.hasChildren ? onChevronTap : null,
              child: SizedBox(
                width: 16,
                height: 28,
                child: entry.hasChildren
                    ? Icon(
                        isExpanded
                            ? FluentIcons.chevron_down_16_regular
                            : FluentIcons.chevron_right_16_regular,
                        size: 12,
                      )
                    : null,
              ),
            ),
            // Folder icon
            if (entry.isCollection) ...[
              Icon(FluentIcons.folder_16_regular, size: 16, color: cs.primary),
              const SizedBox(width: 6),
            ],
            // Label
            Expanded(
              child: isEditing && editWidget != null
                  ? editWidget!
                  : Text(
                      entry.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    ),
            ),
            // Method badge
            if (!entry.isCollection && entry.method != null) ...[
              const SizedBox(width: 6),
              Text(
                entry.method!,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: _methodColor(entry.method!),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
