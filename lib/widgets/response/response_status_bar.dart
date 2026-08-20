import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import '../../config/colors.dart';

class ResponseStatusBar extends StatelessWidget {
  final int statusCode;
  final String statusMessage;
  final int durationMs;
  final int responseSize;

  const ResponseStatusBar({
    super.key,
    required this.statusCode,
    required this.statusMessage,
    required this.durationMs,
    required this.responseSize,
  });

  Color _statusColor(int code) {
    if (code >= 200 && code < 300) return statusSuccess;
    if (code >= 300 && code < 400) return statusRedirect;
    if (code >= 400 && code < 500) return statusClientError;
    if (code >= 500) return statusServerError;
    return statusDefault;
  }

  String _formatSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final accent = _statusColor(statusCode);

    return Container(
      constraints: const BoxConstraints(minHeight: 36),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: cs.surfaceContainerLow,
        border: Border(bottom: BorderSide(color: cs.outlineVariant, width: 1)),
      ),
      child: Row(
        children: [
          const Spacer(),
          // ── Status pill ─────────────────────────────────────
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: accent.withAlpha(20),
              borderRadius: BorderRadius.circular(3),
            ),
            child: Text(
              statusCode > 0
                  ? '$statusCode${statusMessage.isNotEmpty ? ' $statusMessage' : ''}'
                  : 'Error',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: accent,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // ── Duration ────────────────────────────────────────
          Icon(
            FluentIcons.clock_12_regular,
            size: 16,
            color: cs.onSurfaceVariant,
          ),
          const SizedBox(width: 3),
          Text(
            '${durationMs}ms',
            style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant),
          ),
          // ── Separator ───────────────────────────────────────
          Container(
            width: 1,
            height: 10,
            margin: const EdgeInsets.symmetric(horizontal: 12),
            color: cs.outlineVariant,
          ),
          // ── Size ────────────────────────────────────────────
          Icon(
            FluentIcons.document_data_16_regular,
            size: 16,
            color: cs.onSurfaceVariant,
          ),
          const SizedBox(width: 3),
          Text(
            _formatSize(responseSize),
            style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant),
          ),
          const SizedBox(width: 14),
        ],
      ),
    );
  }
}
