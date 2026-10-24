import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import '../../extensions/localization_ext.dart';
import '../compact_menu_item.dart';

/// Anchors the create menu to the whole split button, including the plus half.
class CreateSplitButton extends StatefulWidget {
  final VoidCallback onNewRequest;
  final VoidCallback onNewCollection;
  final VoidCallback onImportCurl;

  const CreateSplitButton({
    super.key,
    required this.onNewRequest,
    required this.onNewCollection,
    required this.onImportCurl,
  });

  @override
  State<CreateSplitButton> createState() => _CreateSplitButtonState();
}

class _CreateSplitButtonState extends State<CreateSplitButton> {
  final _menuController = MenuController();
  final _dropdownFocus = FocusNode(debugLabel: 'Create menu');
  final _firstItemFocus = FocusNode(debugLabel: 'New request menu item');

  @override
  void dispose() {
    _dropdownFocus.dispose();
    _firstItemFocus.dispose();
    super.dispose();
  }

  void _select(VoidCallback action) {
    _menuController.close();
    action();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    const dropdownRadius = BorderRadius.horizontal(right: Radius.circular(6));
    return MenuAnchor(
      controller: _menuController,
      childFocusNode: _dropdownFocus,
      onOpen: () => WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && _menuController.isOpen) {
          _firstItemFocus.requestFocus();
        }
      }),
      consumeOutsideTap: true,
      alignmentOffset: const Offset(0, 4),
      clipBehavior: Clip.none,
      style: const MenuStyle(
        alignment: Alignment.bottomLeft,
        padding: WidgetStatePropertyAll(EdgeInsets.zero),
        backgroundColor: WidgetStatePropertyAll(Colors.transparent),
        surfaceTintColor: WidgetStatePropertyAll(Colors.transparent),
        shadowColor: WidgetStatePropertyAll(Colors.transparent),
        side: WidgetStatePropertyAll(BorderSide.none),
        elevation: WidgetStatePropertyAll(0),
      ),
      menuChildren: [
        _CreateMenuSurface(
          children: [
            CompactMenuItem(
              focusNode: _firstItemFocus,
              leading: const Icon(FluentIcons.add_16_regular, size: 16),
              label: context.l10n.context_new_request,
              onTap: () => _select(widget.onNewRequest),
            ),
            CompactMenuItem(
              leading: const Icon(FluentIcons.folder_add_20_regular, size: 16),
              label: context.l10n.context_new_collection,
              onTap: () => _select(widget.onNewCollection),
            ),
            CompactMenuItem(
              leading: const Icon(FluentIcons.code_20_regular, size: 16),
              label: context.l10n.sidebar_import_from_curl,
              onTap: () => _select(widget.onImportCurl),
            ),
          ],
        ),
      ],
      builder: (context, controller, child) => IntrinsicHeight(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Tooltip(
              message: context.l10n.context_new_request,
              child: FilledButton.tonal(
                onPressed: () => _select(widget.onNewRequest),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 14,
                  ),
                  minimumSize: Size.zero,
                  visualDensity: VisualDensity.compact,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(6),
                    ),
                  ),
                ),
                child: const Icon(FluentIcons.add_16_regular, size: 18),
              ),
            ),
            const SizedBox(width: 1),
            Tooltip(
              message: MaterialLocalizations.of(context).showMenuTooltip,
              child: Semantics(
                expanded: controller.isOpen,
                child: Material(
                  color: controller.isOpen
                      ? cs.primaryContainer
                      : cs.secondaryContainer,
                  borderRadius: dropdownRadius,
                  child: InkWell(
                    key: const ValueKey('create-menu-toggle'),
                    focusNode: _dropdownFocus,
                    borderRadius: dropdownRadius,
                    onTap: () => controller.isOpen
                        ? controller.close()
                        : controller.open(),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Icon(
                        FluentIcons.chevron_down_12_regular,
                        size: 12,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CreateMenuSurface extends StatelessWidget {
  final List<Widget> children;
  const _CreateMenuSurface({required this.children});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SizedBox(
      width: 192,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: 1),
        duration: MediaQuery.disableAnimationsOf(context)
            ? Duration.zero
            : const Duration(milliseconds: 160),
        curve: Curves.easeOutCubic,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children,
          ),
        ),
        builder: (context, progress, child) => Opacity(
          opacity: progress,
          child: Material(
            key: const ValueKey('create-menu-surface'),
            color: cs.surface,
            surfaceTintColor: Colors.transparent,
            elevation: 4,
            shadowColor: cs.shadow.withValues(alpha: 0.2),
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
              side: BorderSide(color: cs.outlineVariant),
            ),
            child: Align(
              alignment: Alignment.topLeft,
              heightFactor: progress,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
