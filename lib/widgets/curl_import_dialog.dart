import 'package:flutter/material.dart';

import '../extensions/localization_ext.dart';
import '../models/http_request.dart';
import '../services/curl_parser.dart';
import 'global_message.dart';

/// Shows the "Import cURL" dialog and returns the parsed request, or null if
/// the user cancels. Invalid input keeps the dialog open with an inline error
/// so the user can correct the command and retry.
Future<HttpRequestModel?> showCurlImportDialog(BuildContext context) {
  return showDialog<HttpRequestModel>(
    context: context,
    builder: (_) => const CurlImportDialog(),
  );
}

class CurlImportDialog extends StatefulWidget {
  const CurlImportDialog({super.key});

  @override
  State<CurlImportDialog> createState() => _CurlImportDialogState();
}

class _CurlImportDialogState extends State<CurlImportDialog> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _import() {
    final text = _controller.text.trim();
    if (text.isEmpty) {
      showGlobalMessage(
        context,
        context.l10n.sidebar_curl_invalid,
        isError: true,
      );
      return;
    }
    try {
      final parsed = CurlParser.parse(text);
      Navigator.pop(context, parsed);
    } catch (_) {
      showGlobalMessage(
        context,
        context.l10n.sidebar_curl_invalid,
        isError: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return AlertDialog(
      title: Text(context.l10n.sidebar_import_curl_title),
      content: SizedBox(
        width: 500,
        height: 220,
        child: Column(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: context.l10n.sidebar_import_curl_hint,
                  isDense: true,
                  contentPadding: const EdgeInsets.fromLTRB(8, 12, 8, 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(
                      color: cs.outline.withValues(alpha: 0.5),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(
                      color: cs.outline.withValues(alpha: 0.4),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(color: cs.primary, width: 1.5),
                  ),
                ),
                style: const TextStyle(
                  fontFamily: 'JetBrainsMono',
                  fontSize: 13,
                ),
                textAlignVertical: TextAlignVertical.top,
                maxLines: null,
                expands: true,
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(context.l10n.button_cancel),
        ),
        FilledButton(
          onPressed: _import,
          child: Text(context.l10n.button_import),
        ),
      ],
    );
  }
}
