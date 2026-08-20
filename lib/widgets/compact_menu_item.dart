import 'package:flutter/material.dart';

/// A compact, desktop-friendly menu item for use inside [MenuAnchor] popups.
///
/// Matches the visual style of [ContextMenuItem] so every menu in the app —
/// dropdowns and right-click menus alike — shares one consistent look:
/// 32px tall rows, subtle primary-tinted hover, small border radius.
class CompactMenuItem extends StatefulWidget {
  /// Optional leading widget (e.g. an icon or a colored dot).
  final Widget? leading;

  final String label;
  final VoidCallback? onTap;

  /// When true the label is tinted with the error color (delete actions).
  final bool destructive;

  const CompactMenuItem({
    super.key,
    this.leading,
    required this.label,
    this.onTap,
    this.destructive = false,
  });

  @override
  State<CompactMenuItem> createState() => _CompactMenuItemState();
}

class _CompactMenuItemState extends State<CompactMenuItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.onTap,
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
              if (widget.leading != null) ...[
                widget.leading!,
                const SizedBox(width: 10),
              ],
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
