import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import '../../extensions/localization_ext.dart';
import '../context_menu.dart';
import 'tree_entry.dart';

/// Show the right-click context menu for a tree entry.
void showTreeContextMenu(
  BuildContext context,
  Offset position,
  TreeEntry entry, {
  required VoidCallback onNewRequest,
  required VoidCallback onNewCollection,
  VoidCallback? onExportCurl,
  required VoidCallback onDuplicate,
  required VoidCallback onRename,
  required VoidCallback onDelete,
}) {
  ContextMenu.show(
    context,
    position,
    items: [
      ContextMenuItem(
        icon: FluentIcons.add_16_regular,
        label: context.l10n.context_new_request,
        onTap: onNewRequest,
      ),
      ContextMenuItem(
        icon: FluentIcons.folder_add_16_regular,
        label: context.l10n.context_new_collection,
        onTap: onNewCollection,
      ),
      if (onExportCurl != null)
        ContextMenuItem(
          icon: FluentIcons.code_16_regular,
          label: context.l10n.context_export_curl,
          onTap: onExportCurl,
        ),
      const ContextMenuDivider(),
      ContextMenuItem(
        icon: FluentIcons.copy_16_regular,
        label: context.l10n.context_duplicate,
        onTap: onDuplicate,
      ),
      ContextMenuItem(
        icon: FluentIcons.rename_16_regular,
        label: context.l10n.context_rename,
        onTap: onRename,
      ),
      ContextMenuItem(
        icon: FluentIcons.delete_16_regular,
        label: context.l10n.context_delete,
        destructive: true,
        onTap: onDelete,
      ),
    ],
  );
}
