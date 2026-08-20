import 'dart:convert';

import 'package:flutter/material.dart';

class ResponseBodyViewer extends StatelessWidget {
  final String body;

  const ResponseBodyViewer({super.key, required this.body});

  static String _formatJson(String raw) {
    try {
      final decoded = jsonDecode(raw);
      return const JsonEncoder.withIndent('  ').convert(decoded);
    } catch (_) {
      return raw;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8),
      child: SelectableText(
        _formatJson(body),
        style: const TextStyle(fontFamily: 'JetBrainsMono', fontSize: 13),
      ),
    );
  }
}
