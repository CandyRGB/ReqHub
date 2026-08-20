import 'package:flutter/material.dart';

import '../../extensions/localization_ext.dart';

class ResponseHeadersViewer extends StatelessWidget {
  final Map<String, String> headers;

  const ResponseHeadersViewer({super.key, required this.headers});

  @override
  Widget build(BuildContext context) {
    if (headers.isEmpty) {
      return Center(child: Text(context.l10n.response_no_headers));
    }

    final entries = headers.entries.toList();

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: entries.length,
      itemBuilder: (context, index) {
        final e = entries[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 180,
                child: SelectableText(
                  e.key,
                  maxLines: 1,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
              Expanded(
                child: SelectableText(
                  e.value,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
