import 'package:flutter/material.dart';

import '../../extensions/localization_ext.dart';
import '../../models/http_request.dart';
import '../../models/key_value_pair.dart';
import '../../models/request_body.dart';
import 'headers_editor.dart';
import 'params_editor.dart';
import 'body_editor.dart';
import 'auth_editor.dart';

class RequestTab extends StatefulWidget {
  final HttpRequestModel request;
  final ValueChanged<List<KeyValuePair>> onHeadersChanged;
  final ValueChanged<List<KeyValuePair>> onParamsChanged;
  final ValueChanged<RequestBody> onBodyChanged;
  final ValueChanged<AuthConfig> onAuthChanged;

  const RequestTab({
    super.key,
    required this.request,
    required this.onHeadersChanged,
    required this.onParamsChanged,
    required this.onBodyChanged,
    required this.onAuthChanged,
  });

  @override
  State<RequestTab> createState() => _RequestTabState();
}

class _RequestTabState extends State<RequestTab> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tabs = [
      context.l10n.request_tab_params,
      context.l10n.request_tab_auth,
      context.l10n.request_tab_headers,
      context.l10n.request_tab_body,
    ];

    return Column(
      children: [
        // Lightweight underline-style tab bar
        Row(
          children: [
            for (int i = 0; i < tabs.length; i++)
              GestureDetector(
                onTap: () => setState(() => _currentIndex = i),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: _currentIndex == i
                            ? cs.primary
                            : const Color(0x00000000),
                        width: 2,
                      ),
                    ),
                  ),
                  child: Text(
                    tabs[i],
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: _currentIndex == i
                          ? FontWeight.w600
                          : FontWeight.normal,
                      color: _currentIndex == i
                          ? cs.primary
                          : cs.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
          ],
        ),
        Container(height: 1, color: cs.outlineVariant),
        // Content area
        Expanded(
          child: IndexedStack(
            index: _currentIndex,
            children: [
              ParamsEditor(
                params: widget.request.queryParams,
                onChanged: widget.onParamsChanged,
              ),
              AuthEditor(
                auth: widget.request.auth ?? const AuthConfig.noAuth(),
                onChanged: widget.onAuthChanged,
              ),
              HeadersEditor(
                headers: widget.request.headers,
                onChanged: widget.onHeadersChanged,
              ),
              BodyEditor(
                body: widget.request.body,
                onChanged: widget.onBodyChanged,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
