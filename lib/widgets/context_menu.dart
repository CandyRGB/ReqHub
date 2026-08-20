import 'package:flutter/material.dart';

/// A fluent-styled context menu with acrylic background, shadow, and hover effects.
///
/// Usage:
/// ```dart
/// ContextMenu.show(context, position, items: [
///   ContextMenuItem(icon: FluentIcons.add_16_regular, label: 'New', onTap: () {}),
///   ContextMenuDivider(),
///   ContextMenuItem(icon: FluentIcons.delete_16_regular, label: 'Delete', onTap: () {}, destructive: true),
/// ]);
/// ```
class ContextMenu {
  static OverlayEntry? _current;

  /// Show a context menu at [position] (global coordinates).
  /// [items] defines the menu content. Returns an [OverlayEntry] that can be
  /// used to dismiss the menu programmatically.
  static OverlayEntry? show(
    BuildContext context,
    Offset position, {
    required List<Widget> items,
  }) {
    dismiss();
    final entry = OverlayEntry(
      builder: (_) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: dismiss,
          onSecondaryTap: dismiss,
          child: Stack(
            children: [
              Positioned(
                left: position.dx,
                top: position.dy,
                child: _ContextMenuCard(items: items),
              ),
            ],
          ),
        );
      },
    );
    Overlay.of(context).insert(entry);
    _current = entry;
    return entry;
  }

  /// Dismiss the currently shown context menu.
  static void dismiss() {
    _current?.remove();
    _current = null;
  }
}

/// A single item in a [ContextMenu].
class ContextMenuItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final bool destructive;

  const ContextMenuItem({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
    this.destructive = false,
  });

  @override
  State<ContextMenuItem> createState() => _ContextMenuItemState();
}

class _ContextMenuItemState extends State<ContextMenuItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          ContextMenu.dismiss();
          widget.onTap?.call();
        },
        child: Container(
          height: 32,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
          decoration: BoxDecoration(
            color: _hovered ? cs.primary.withValues(alpha: 0.07) : null,
            borderRadius: BorderRadius.circular(3),
          ),
          child: Row(
            children: [
              Icon(
                widget.icon,
                size: 16,
                color: widget.destructive ? cs.error : null,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  widget.label,
                  style: TextStyle(
                    fontSize: 13,
                    color: widget.destructive ? cs.error : null,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A horizontal divider for use inside a [ContextMenu].
class ContextMenuDivider extends StatelessWidget {
  const ContextMenuDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Divider(),
    );
  }
}

// ─── Internal ─────────────────────────────────────────────────────

class _ContextMenuCard extends StatelessWidget {
  final List<Widget> items;
  const _ContextMenuCard({required this.items});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return Container(
      width: 220,
      padding: const EdgeInsets.symmetric(vertical: 3),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: cs.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: cs.shadow.withValues(alpha: 0.12),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: items),
    );
  }
}
