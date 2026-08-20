import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import 'compact_menu_item.dart';

/// A Material 3 menu button that replaces [DropdownButton].
///
/// Displays the currently selected [value]'s label with a chevron-down icon,
/// and opens a [MenuAnchor] popup when tapped.
class MenuButton<T> extends StatefulWidget {
  final T value;

  /// Menu entries. An optional [Color] tints the method dot and label.
  final List<({T value, String label, Color? color})> items;
  final ValueChanged<T> onChanged;
  final BorderRadius borderRadius;

  const MenuButton({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.borderRadius = const BorderRadius.all(Radius.circular(6)),
  });

  @override
  State<MenuButton<T>> createState() => _MenuButtonState<T>();
}

class _MenuButtonState<T> extends State<MenuButton<T>> {
  final MenuController _controller = MenuController();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final items = widget.items;
    final selected = items.firstWhere(
      (i) => i.value == widget.value,
      orElse: () => items.first,
    );

    final br = widget.borderRadius;
    return MenuAnchor(
      controller: _controller,
      menuChildren: [
        for (final item in items)
          CompactMenuItem(
            leading: item.color == null ? null : _MethodDot(color: item.color!),
            label: item.label,
            onTap: () {
              widget.onChanged(item.value);
              _controller.close();
            },
          ),
      ],
      child: InkWell(
        borderRadius: br,
        onTap: () {
          if (_controller.isOpen) {
            _controller.close();
          } else {
            _controller.open();
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            borderRadius: br,
            border: Border.all(color: cs.outline.withValues(alpha: 0.3)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              if (selected.color != null) ...[
                _MethodDot(color: selected.color!),
                const SizedBox(width: 6),
              ],
              Expanded(
                child: Text(
                  selected.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(
                    fontSize: 14,
                    color: selected.color,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                FluentIcons.chevron_down_12_regular,
                size: 14,
                color: cs.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Small colored circle used to mark HTTP methods.
class _MethodDot extends StatelessWidget {
  final Color color;
  const _MethodDot({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withValues(alpha: 0.9),
      ),
    );
  }
}
