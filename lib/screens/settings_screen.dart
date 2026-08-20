import 'package:flutter/material.dart';
import 'package:file_selector/file_selector.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../config/colors.dart';
import '../extensions/localization_ext.dart';
import '../providers/providers.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final appSettings = ref.watch(settingsProvider);
    final cs = Theme.of(context).colorScheme;

    return Column(
      children: [
        // ─── Header ──────────────────────────────────────────────
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(FluentIcons.arrow_left_16_regular, size: 18),
                onPressed: () => context.go('/'),
              ),
              const SizedBox(width: 12),
              Text(
                context.l10n.settings_title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        // ─── Content ─────────────────────────────────────────────
        Expanded(
          child: Container(
            color: cs.surfaceContainer,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Data Storage ─────────────────────────────
                    _SettingsGroup(
                      title: context.l10n.settings_data_storage,
                      description: context.l10n.settings_storage_desc,
                      rows: [
                        _PathRow(
                          icon: FluentIcons.folder_16_regular,
                          label: context.l10n.settings_storage_path,
                          path: appSettings.storagePath,
                          onChange: _changeStoragePath,
                          changeLabel: context.l10n.settings_change,
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    // ── Appearance ───────────────────────────────
                    _SettingsGroup(
                      title: context.l10n.settings_appearance,
                      description: context.l10n.settings_appearance_desc,
                      rows: [
                        _SettingsRow(
                          icon: FluentIcons.brightness_high_16_regular,
                          label: context.l10n.settings_theme,
                          trailing: SegmentedButton<ThemeMode>(
                            segments: [
                              ButtonSegment(
                                value: ThemeMode.light,
                                label: Text(
                                  context.l10n.theme_light,
                                  style: const TextStyle(fontSize: 13),
                                ),
                              ),
                              ButtonSegment(
                                value: ThemeMode.dark,
                                label: Text(
                                  context.l10n.theme_dark,
                                  style: const TextStyle(fontSize: 13),
                                ),
                              ),
                              ButtonSegment(
                                value: ThemeMode.system,
                                label: Text(
                                  context.l10n.theme_system,
                                  style: const TextStyle(fontSize: 13),
                                ),
                              ),
                            ],
                            selected: {appSettings.themeMode},
                            onSelectionChanged: (v) => ref
                                .read(settingsProvider.notifier)
                                .setThemeMode(v.first),
                            showSelectedIcon: false,
                            emptySelectionAllowed: false,
                            style: const ButtonStyle(
                              visualDensity: VisualDensity.compact,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                        ),
                        _SettingsRow(
                          icon: FluentIcons.color_16_regular,
                          label: context.l10n.settings_theme_color,
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: presetThemeSeeds
                                .map(
                                  (seed) => Padding(
                                    padding: const EdgeInsets.only(left: 6),
                                    child: GestureDetector(
                                      onTap: () => ref
                                          .read(settingsProvider.notifier)
                                          .setThemeSeed(seed.value),
                                      child: Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: Color(seed.value),
                                          shape: BoxShape.circle,
                                          border:
                                              appSettings.themeSeedColor ==
                                                  seed.value
                                              ? Border.all(
                                                  color: cs.surface,
                                                  width: 2,
                                                )
                                              : null,
                                          boxShadow:
                                              appSettings.themeSeedColor ==
                                                  seed.value
                                              ? [
                                                  BoxShadow(
                                                    color: Color(
                                                      seed.value,
                                                    ).withValues(alpha: 0.5),
                                                    blurRadius: 4,
                                                  ),
                                                ]
                                              : null,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        _SettingsRow(
                          icon: FluentIcons.local_language_16_regular,
                          label: context.l10n.settings_language,
                          trailing: SegmentedButton<String>(
                            segments: [
                              ButtonSegment(
                                value: 'en',
                                label: Text(
                                  context.l10n.language_en,
                                  style: const TextStyle(fontSize: 13),
                                ),
                              ),
                              ButtonSegment(
                                value: 'zh',
                                label: Text(
                                  context.l10n.language_zh,
                                  style: const TextStyle(fontSize: 13),
                                ),
                              ),
                            ],
                            selected: {appSettings.localeCode},
                            onSelectionChanged: (v) => ref
                                .read(settingsProvider.notifier)
                                .setLocale(v.first),
                            showSelectedIcon: false,
                            emptySelectionAllowed: false,
                            style: const ButtonStyle(
                              visualDensity: VisualDensity.compact,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    // ── Request Settings ─────────────────────────
                    _SettingsGroup(
                      title: context.l10n.settings_request_settings,
                      description: context.l10n.settings_request_desc,
                      rows: [
                        _SettingsRow(
                          icon: FluentIcons.timer_16_regular,
                          label: context.l10n.settings_timeout,
                          trailing: SizedBox(
                            width: 80,
                            child: _TimeoutField(
                              initialValue: appSettings.timeoutSeconds
                                  .toString(),
                              onChanged: (v) {
                                final s = int.tryParse(v);
                                if (s != null && s > 0) {
                                  ref
                                      .read(settingsProvider.notifier)
                                      .setTimeout(s);
                                }
                              },
                            ),
                          ),
                        ),
                        _SettingsRow(
                          icon: FluentIcons.arrow_sync_16_regular,
                          label: context.l10n.settings_follow_redirects,
                          trailing: SizedBox(
                            height: 28,
                            child: Transform.scale(
                              scale: 0.75,
                              child: Switch(
                                value: appSettings.followRedirects,
                                onChanged: (v) => ref
                                    .read(settingsProvider.notifier)
                                    .setFollowRedirects(v),
                              ),
                            ),
                          ),
                        ),
                        _SettingsRow(
                          icon: FluentIcons.shield_checkmark_16_regular,
                          label: context.l10n.settings_ssl_verification,
                          trailing: SizedBox(
                            height: 28,
                            child: Transform.scale(
                              scale: 0.75,
                              child: Switch(
                                value: appSettings.verifySsl,
                                onChanged: (v) => ref
                                    .read(settingsProvider.notifier)
                                    .setVerifySsl(v),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _changeStoragePath() async {
    final path = await getDirectoryPath();
    if (path != null && path.isNotEmpty) {
      ref.read(settingsProvider.notifier).setStoragePath(path);
    }
  }
}

/// A rounded-rectangle card holding a header row and a list of settings rows,
/// separated by full-width hairline dividers.
class _SettingsGroup extends StatelessWidget {
  final String? title;
  final String? description;
  final List<Widget> rows;
  const _SettingsGroup({this.title, this.description, required this.rows});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).dividerColor.withValues(alpha: 0.4),
        ),
      ),
      child: Column(
        children: [
          if (title != null) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
              child: Row(
                children: [
                  Text(
                    title!,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Spacer(),
                  if (description != null)
                    Text(
                      description!,
                      style: TextStyle(
                        fontSize: 14,
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                ],
              ),
            ),
            const Divider(height: 1),
          ],
          for (int i = 0; i < rows.length; i++) ...[
            rows[i],
            if (i < rows.length - 1) const Divider(height: 1),
          ],
        ],
      ),
    );
  }
}

/// A single settings row: icon + label left, control right.
class _SettingsRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget trailing;
  const _SettingsRow({
    required this.icon,
    required this.label,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Icon(icon, size: 16),
          const SizedBox(width: 10),
          Text(label, style: const TextStyle(fontSize: 14)),
          const Spacer(),
          trailing,
        ],
      ),
    );
  }
}

/// A settings row for the storage path: icon + label left,
/// path in the middle (truncated, grey), change button on the right.
class _PathRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String path;
  final VoidCallback onChange;
  final String changeLabel;
  const _PathRow({
    required this.icon,
    required this.label,
    required this.path,
    required this.onChange,
    required this.changeLabel,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Icon(icon, size: 16),
          const SizedBox(width: 10),
          Text(label, style: const TextStyle(fontSize: 14)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              path,
              style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 12),
          FilledButton(
            onPressed: onChange,
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(changeLabel, style: const TextStyle(fontSize: 12)),
          ),
        ],
      ),
    );
  }
}

/// A duration/timeout input field that manages its own [TextEditingController]
/// lifecycle to avoid leaks from rebuilding parents.
class _TimeoutField extends StatefulWidget {
  final String initialValue;
  final ValueChanged<String> onChanged;

  const _TimeoutField({required this.initialValue, required this.onChanged});

  @override
  State<_TimeoutField> createState() => _TimeoutFieldState();
}

class _TimeoutFieldState extends State<_TimeoutField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return TextField(
      controller: _controller,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: cs.outline.withValues(alpha: 0.5)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: cs.outline.withValues(alpha: 0.4)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: cs.primary, width: 1),
        ),
      ),
      onChanged: widget.onChanged,
    );
  }
}
