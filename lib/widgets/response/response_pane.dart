import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../extensions/localization_ext.dart';
import '../../providers/providers.dart';
import 'response_body_viewer.dart';
import 'response_headers_viewer.dart';
import 'response_status_bar.dart';

class ResponsePane extends ConsumerWidget {
  const ResponsePane({super.key});

  /// Truncate overly long error strings so the UI is not flooded.
  static String _formatError(Object e) {
    final s = '$e';
    if (s.length <= 300) return s;
    return '${s.substring(0, 300)}…';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final responseAsync = ref.watch(responseProvider);

    return Column(
      children: [
        // Top divider: separates the response area from the request editor
        // above it in every state (placeholder / loading / error / data).
        Divider(height: 1, color: cs.outlineVariant),
        Expanded(
          child: responseAsync.when(
            data: (response) {
              if (response == null) {
                return Center(
                  child: Text(
                    context.l10n.response_placeholder,
                    style: TextStyle(
                      fontSize: 14,
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                );
              }
              return _ResponseView(response: response);
            },
            loading: () => const Align(
              alignment: Alignment.topCenter,
              child: LinearProgressIndicator(),
            ),
            error: (e, _) => Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: SelectableText(
                    context.l10n.response_error(_formatError(e)),
                    style: TextStyle(color: cs.error),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ResponseView extends StatefulWidget {
  final dynamic response; // HttpResponseModel
  const _ResponseView({required this.response});

  @override
  State<_ResponseView> createState() => _ResponseViewState();
}

class _ResponseViewState extends State<_ResponseView> {
  @override
  Widget build(BuildContext context) {
    final r = widget.response;

    return Column(
      children: [
        // Status bar
        ResponseStatusBar(
          statusCode: r.statusCode,
          statusMessage: r.statusMessage,
          durationMs: r.durationMs,
          responseSize: r.responseSize,
        ),
        // Tabs: Body | Headers | Cookies
        Expanded(
          child: DefaultTabController(
            length: 3,
            child: Column(
              children: [
                TabBar(
                  tabs: [
                    Tab(text: context.l10n.response_tab_body),
                    Tab(text: context.l10n.response_tab_headers),
                    Tab(text: context.l10n.response_tab_cookies),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      ResponseBodyViewer(body: r.body ?? ''),
                      ResponseHeadersViewer(headers: r.headers ?? {}),
                      _CookiesView(cookies: r.cookies ?? []),
                    ],
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

class _CookiesView extends StatelessWidget {
  final List<dynamic> cookies;
  const _CookiesView({required this.cookies});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    if (cookies.isEmpty) {
      return Center(
        child: Text(
          context.l10n.response_no_cookies,
          style: const TextStyle(fontSize: 13),
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: cookies.length,
      itemBuilder: (context, index) {
        final c = cookies[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: cs.primary.withValues(alpha: 0.12),
              border: Border(left: BorderSide(color: cs.primary, width: 3)),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              '${c.name}=${c.value}',
              style: const TextStyle(fontSize: 12),
            ),
          ),
        );
      },
    );
  }
}
