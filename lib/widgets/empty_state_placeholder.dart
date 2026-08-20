import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import '../extensions/localization_ext.dart';
import '../models/http_request.dart';
import '../providers/providers.dart';
import 'curl_import_dialog.dart';
import 'global_message.dart';

/// Empty state shown in the main area when no request tab is open.
/// Guides the user to create a request, a collection, or import a cURL
/// command — the same actions available in the sidebar toolbar.
class EmptyStatePlaceholder extends ConsumerStatefulWidget {
  const EmptyStatePlaceholder({super.key});

  @override
  ConsumerState<EmptyStatePlaceholder> createState() =>
      _EmptyStatePlaceholderState();
}

class _EmptyStatePlaceholderState extends ConsumerState<EmptyStatePlaceholder> {
  void _newRequest() {
    final blank = HttpRequestModel(
      id: '',
      name: context.l10n.default_request_name,
      method: 'GET',
    );
    final newId = ref
        .read(collectionsProvider.notifier)
        .addRequest(null, blank);
    final req = ref.read(collectionsProvider.notifier).findRequest(newId);
    if (req != null) {
      ref.read(requestTabsProvider.notifier).openTab(req);
    }
  }

  void _newCollection() {
    ref
        .read(collectionsProvider.notifier)
        .addCollection(context.l10n.default_collection_name);
  }

  Future<void> _importCurl() async {
    final parsed = await showCurlImportDialog(context);
    if (parsed == null) return; // cancelled
    final newId = ref
        .read(collectionsProvider.notifier)
        .addRequest(null, parsed);
    final req = ref.read(collectionsProvider.notifier).findRequest(newId);
    if (req != null) {
      ref.read(requestTabsProvider.notifier).openTab(req);
    }
    if (!mounted) return;
    showGlobalMessage(context, context.l10n.sidebar_curl_success);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          FluentIcons.send_20_regular,
          size: 48,
          color: cs.onSurfaceVariant.withAlpha(80),
        ),
        const SizedBox(height: 16),
        Text(
          context.l10n.main_placeholder,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15, color: cs.onSurfaceVariant),
        ),
        const SizedBox(height: 24),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 8,
          runSpacing: 8,
          children: [
            FilledButton.tonalIcon(
              onPressed: _newRequest,
              icon: const Icon(FluentIcons.add_16_regular, size: 16),
              label: Text(context.l10n.context_new_request),
            ),
            FilledButton.tonalIcon(
              onPressed: _newCollection,
              icon: const Icon(FluentIcons.folder_add_20_regular, size: 16),
              label: Text(context.l10n.context_new_collection),
            ),
            FilledButton.tonalIcon(
              onPressed: _importCurl,
              icon: const Icon(FluentIcons.code_20_regular, size: 16),
              label: Text(context.l10n.sidebar_import_from_curl),
            ),
          ],
        ),
      ],
    );
  }
}
