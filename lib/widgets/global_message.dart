import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

OverlayEntry? _activeMessage;
Timer? _dismissTimer;

/// Shows an Ant Design-style top-centered message above pages and dialogs.
void showGlobalMessage(
  BuildContext context,
  String message, {
  bool isError = false,
}) {
  if (message.trim().isEmpty) return;
  final overlay = Overlay.maybeOf(context, rootOverlay: true);
  if (overlay == null) return;

  _dismissTimer?.cancel();
  _activeMessage?.remove();

  final entry = OverlayEntry(
    builder: (overlayContext) {
      final colors = Theme.of(overlayContext).colorScheme;
      final background = isError
          ? colors.errorContainer
          : colors.inverseSurface;
      final foreground = isError
          ? colors.onErrorContainer
          : colors.onInverseSurface;

      return Positioned(
        left: 16,
        right: 16,
        top: 16,
        child: SafeArea(
          top: true,
          bottom: false,
          child: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 720),
              child: Material(
                color: background,
                elevation: 4,
                borderRadius: BorderRadius.circular(4),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isError
                            ? FluentIcons.error_circle_16_regular
                            : FluentIcons.checkmark_circle_16_regular,
                        size: 18,
                        color: foreground,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          message,
                          style: TextStyle(color: foreground),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );

  _activeMessage = entry;
  overlay.insert(entry);
  _dismissTimer = Timer(Duration(seconds: isError ? 5 : 3), () {
    if (identical(_activeMessage, entry)) {
      entry.remove();
      _activeMessage = null;
    }
  });
}
