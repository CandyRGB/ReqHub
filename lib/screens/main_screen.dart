import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:go_router/go_router.dart';

import '../extensions/localization_ext.dart';
import '../models/http_request.dart';
import '../providers/providers.dart';
import '../widgets/empty_state_placeholder.dart';
import '../widgets/sidebar/sidebar_panel.dart';
import '../widgets/request/request_page.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  bool _sidebarVisible = true;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    final c = ref.read(collectionsProvider.notifier);
    final s = ref.read(settingsProvider.notifier);
    await c.init();
    await s.init();
  }

  void _onRequestSelected(HttpRequestModel request) {
    ref.read(requestTabsProvider.notifier).openTab(request);
  }

  /// Close a tab by index, prompting to save if the tab has unsaved changes.
  Future<void> _handleTabClose(int index) async {
    final tabsNotifier = ref.read(requestTabsProvider.notifier);
    final tabs = ref.read(requestTabsProvider).tabs;
    if (index < 0 || index >= tabs.length) return;

    final tab = tabs[index];

    if (tab.isDirty) {
      final result = await _showUnsavedDialog(tab.request.name);
      if (result == 'save') {
        tabsNotifier.saveTab(index);
        tabsNotifier.closeTab(index);
      } else if (result == 'discard') {
        tabsNotifier.closeTab(index);
      }
    } else {
      tabsNotifier.closeTab(index);
    }
  }

  /// Show a Fluent dialog asking the user what to do with unsaved changes.
  /// Returns 'save', 'discard', or null (cancel).
  Future<String?> _showUnsavedDialog(String requestName) {
    return showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(context.l10n.main_unsaved_title),
        content: Text(context.l10n.main_unsaved_message(requestName)),
        actions: [
          TextButton(
            child: Text(context.l10n.button_cancel),
            onPressed: () => Navigator.pop(ctx),
          ),
          TextButton(
            child: Text(context.l10n.main_unsaved_dont_save),
            onPressed: () => Navigator.pop(ctx, 'discard'),
          ),
          FilledButton(
            child: Text(context.l10n.main_unsaved_save),
            onPressed: () => Navigator.pop(ctx, 'save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tabsState = ref.watch(requestTabsProvider);
    final cs = Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ── Activity Bar (always visible, VS Code style) ────
        Container(
          width: 44,
          decoration: BoxDecoration(
            color: cs.surfaceContainerLow,
            border: Border(
              right: BorderSide(color: cs.outlineVariant, width: 1),
            ),
          ),
          child: Column(
            children: [
              const Spacer(),
              // Sidebar toggle
              IconButton(
                icon: Icon(
                  _sidebarVisible
                      ? FluentIcons.panel_left_20_regular
                      : FluentIcons.panel_left_expand_20_regular,
                  size: 22,
                ),
                tooltip: _sidebarVisible
                    ? context.l10n.activity_hide_sidebar
                    : context.l10n.activity_show_sidebar,
                onPressed: () =>
                    setState(() => _sidebarVisible = !_sidebarVisible),
              ),
              // Settings
              IconButton(
                icon: const Icon(FluentIcons.settings_20_regular, size: 20),
                tooltip: context.l10n.activity_settings,
                onPressed: () => context.go('/settings'),
              ),
              const SizedBox(height: 4),
            ],
          ),
        ),

        // ── Sidebar Panel (toggleable) ─────────────────────
        if (_sidebarVisible)
          SidebarPanel(onRequestSelected: _onRequestSelected),

        // ── Main content area ──────────────────────────────
        Expanded(
          child: tabsState.isEmpty
              ? Container(
                  color: cs.surface,
                  child: const Center(child: EmptyStatePlaceholder()),
                )
              : Container(
                  color: cs.surfaceContainerLow,
                  child: Column(
                    children: [
                      // Tab strip
                      Container(
                        height: 36,
                        color: cs.surfaceContainerLow,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: tabsState.tabs.length,
                          itemBuilder: (_, i) {
                            final isActive = i == tabsState.activeIndex;
                            return GestureDetector(
                              onTap: () => ref
                                  .read(requestTabsProvider.notifier)
                                  .activateTab(i),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: isActive
                                      ? cs.surface
                                      : cs.surfaceContainerLow,
                                  border: Border(
                                    bottom: BorderSide(
                                      color: isActive
                                          ? cs.primary
                                          : Colors.transparent,
                                      width: 2,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    _TabLabel(
                                      name: tabsState.tabs[i].request.name,
                                      isDirty: tabsState.tabs[i].isDirty,
                                    ),
                                    const SizedBox(width: 8),
                                    GestureDetector(
                                      onTap: () => _handleTabClose(i),
                                      child: Icon(
                                        FluentIcons.dismiss_16_regular,
                                        size: 16,
                                        color: cs.onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const Divider(height: 1),
                      // Tab content
                      Expanded(
                        child: ColoredBox(
                          color: cs.surface,
                          child: const RequestPage(),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ],
    );
  }
}

/// A small widget for the tab label: shows a colored dot before the name when
/// the tab has unsaved changes.
class _TabLabel extends StatelessWidget {
  final String name;
  final bool isDirty;

  const _TabLabel({required this.name, required this.isDirty});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isDirty)
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(right: 6),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: cs.primary,
            ),
          ),
        Text(name),
      ],
    );
  }
}
