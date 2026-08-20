import 'package:flutter/material.dart';

import '../../config/colors.dart';
import '../../extensions/localization_ext.dart';
import '../menu_button.dart';

class UrlBar extends StatefulWidget {
  final String method;
  final String url;
  final ValueChanged<String> onMethodChanged;
  final ValueChanged<String> onUrlChanged;
  final VoidCallback onSend;

  const UrlBar({
    super.key,
    required this.method,
    required this.url,
    required this.onMethodChanged,
    required this.onUrlChanged,
    required this.onSend,
  });

  @override
  State<UrlBar> createState() => _UrlBarState();
}

class _UrlBarState extends State<UrlBar> {
  late final TextEditingController _urlCtrl;

  @override
  void initState() {
    super.initState();
    _urlCtrl = TextEditingController(text: widget.url);
  }

  @override
  void didUpdateWidget(covariant UrlBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.url != _urlCtrl.text && widget.url != oldWidget.url) {
      _urlCtrl.text = widget.url;
    }
  }

  @override
  void dispose() {
    _urlCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    const radius = BorderRadius.all(Radius.circular(4));
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Method selector
          SizedBox(
            width: 124,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: radius,
                border: Border.all(color: cs.outline.withValues(alpha: 0.3)),
              ),
              child: MenuButton<String>(
                value: widget.method,
                borderRadius: BorderRadius.zero,
                items: const [
                  (value: 'GET', label: 'GET', color: methodGet),
                  (value: 'POST', label: 'POST', color: methodPost),
                  (value: 'PUT', label: 'PUT', color: methodPut),
                  (value: 'PATCH', label: 'PATCH', color: methodPatch),
                  (value: 'DELETE', label: 'DELETE', color: methodDelete),
                  (value: 'HEAD', label: 'HEAD', color: methodHead),
                  (value: 'OPTIONS', label: 'OPTIONS', color: methodOptions),
                ],
                onChanged: (m) => widget.onMethodChanged(m),
              ),
            ),
          ),
          const SizedBox(width: 8),
          // URL input with outline border + floating label
          Expanded(
            child: TextField(
              controller: _urlCtrl,
              onChanged: widget.onUrlChanged,
              decoration: InputDecoration(
                labelText: context.l10n.url_placeholder,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                border: OutlineInputBorder(
                  borderRadius: radius,
                  borderSide: BorderSide(
                    color: cs.outline.withValues(alpha: 0.5),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: radius,
                  borderSide: BorderSide(
                    color: cs.outline.withValues(alpha: 0.4),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: radius,
                  borderSide: BorderSide(color: cs.primary, width: 1.5),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Send button
          FilledButton(
            onPressed: widget.onSend,
            style: FilledButton.styleFrom(
              shape: const RoundedRectangleBorder(borderRadius: radius),
            ),
            child: Text(context.l10n.url_send),
          ),
        ],
      ),
    );
  }
}
