import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../extensions/localization_ext.dart';
import '../../providers/providers.dart';
import 'url_bar.dart';
import 'request_tab.dart';
import '../response/response_pane.dart';

/// The body of a single request tab — request editor on top, response pane
/// below.  Reads the active request and response from the shared providers
/// (which are kept in sync with the active tab by [RequestTabsNotifier]).
class RequestPage extends ConsumerWidget {
  const RequestPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final currentRequest = ref.watch(currentRequestProvider);

    if (currentRequest == null) {
      return Center(
        child: Text(
          context.l10n.request_placeholder,
          style: TextStyle(fontSize: 16, color: cs.onSurfaceVariant),
        ),
      );
    }

    return Column(
      children: [
        Expanded(flex: 3, child: _RequestEditor(request: currentRequest)),
        const Expanded(flex: 3, child: ResponsePane()),
      ],
    );
  }
}

class _RequestEditor extends ConsumerWidget {
  final dynamic request; // HttpRequestModel
  const _RequestEditor({required this.request});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          UrlBar(
            method: request.method,
            url: request.url,
            onMethodChanged: (m) =>
                ref.read(requestTabsProvider.notifier).updateActiveMethod(m),
            onUrlChanged: (u) =>
                ref.read(requestTabsProvider.notifier).updateActiveUrl(u),
            onSend: () =>
                ref.read(requestTabsProvider.notifier).sendActiveRequest(),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: RequestTab(
              request: request,
              onHeadersChanged: (h) =>
                  ref.read(requestTabsProvider.notifier).updateActiveHeaders(h),
              onParamsChanged: (p) => ref
                  .read(requestTabsProvider.notifier)
                  .updateActiveQueryParams(p),
              onBodyChanged: (b) =>
                  ref.read(requestTabsProvider.notifier).updateActiveBody(b),
              onAuthChanged: (a) =>
                  ref.read(requestTabsProvider.notifier).updateActiveAuth(a),
            ),
          ),
        ],
      ),
    );
  }
}
