import 'package:flutter/material.dart';

/// A compact, desktop-friendly menu item for use inside [MenuAnchor] popups.
///
/// Matches the visual style of [ContextMenuItem] so every menu in the app —
/// dropdowns and right-click menus alike — shares one consistent look:
/// 32px tall rows, subtle hover, keyboard focus and small border radius.
class CompactMenuItem extends StatelessWidget {
  /// Optional leading widget (e.g. an icon or a colored dot).
  final Widget? leading;

  final String label;
  final VoidCallback? onTap;
  final FocusNode? focusNode;

  /// When true the label is tinted with the error color (delete actions).
  final bool destructive;

  const CompactMenuItem({
    super.key,
    this.leading,
    required this.label,
    this.onTap,
    this.focusNode,
    this.destructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return MenuItemButton(
      onPressed: onTap,
      focusNode: focusNode,
      leadingIcon: leading,
      style: ButtonStyle(
        minimumSize: const WidgetStatePropertyAll(Size(0, 32)),
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 8),
        ),
        visualDensity: VisualDensity.standard,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: const WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
        ),
        foregroundColor: WidgetStatePropertyAll(
          destructive ? cs.error : cs.onSurface,
        ),
        iconColor: WidgetStatePropertyAll(
          destructive ? cs.error : cs.onSurfaceVariant,
        ),
        overlayColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.focused)) {
            return cs.primary.withValues(alpha: 0.12);
          }
          if (states.contains(WidgetState.hovered) ||
              states.contains(WidgetState.pressed)) {
            return cs.onSurface.withValues(alpha: 0.06);
          }
          return Colors.transparent;
        }),
      ),
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 13),
      ),
    );
  }
}
