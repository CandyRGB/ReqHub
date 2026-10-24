import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reqhub/config/app_theme.dart';
import 'package:reqhub/config/colors.dart';

double contrast(Color text, Color background) {
  final a = Color.alphaBlend(text, background).computeLuminance();
  final b = background.computeLuminance();
  return a > b ? (a + 0.05) / (b + 0.05) : (b + 0.05) / (a + 0.05);
}

void main() {
  for (final brightness in Brightness.values) {
    for (final preset in presetThemeSeeds) {
      test('${preset.label} $brightness keeps interface text readable', () {
        final theme = buildAppTheme(brightness, Color(preset.value));
        final cs = theme.colorScheme;
        for (final pair in [
          (cs.onSurface, cs.surface),
          (cs.onSurfaceVariant, cs.surfaceContainerLow),
          (cs.primary, cs.surface),
          (cs.onPrimary, cs.primary),
          (cs.onPrimaryContainer, cs.primaryContainer),
          (cs.onSecondaryContainer, cs.secondaryContainer),
          (cs.error, cs.surface),
          (cs.onErrorContainer, cs.errorContainer),
        ]) {
          expect(
            contrast(pair.$1, pair.$2),
            greaterThanOrEqualTo(4.5),
            reason: '${preset.label}: ${pair.$1} on ${pair.$2}',
          );
        }
      });
    }

    test('$brightness accents leave workspace surfaces neutral', () {
      final reference = buildAppTheme(
        brightness,
        Color(presetThemeSeeds.first.value),
      ).colorScheme;
      for (final preset in presetThemeSeeds.skip(1)) {
        final cs = buildAppTheme(brightness, Color(preset.value)).colorScheme;
        expect(cs.surface, reference.surface);
        expect(cs.surfaceContainerLow, reference.surfaceContainerLow);
        expect(cs.surfaceContainer, reference.surfaceContainer);
        expect(cs.outlineVariant, reference.outlineVariant);
      }
    });

    test('$brightness HTTP labels remain readable', () {
      final cs = buildAppTheme(
        brightness,
        Color(presetThemeSeeds.first.value),
      ).colorScheme;
      for (final method in [
        'GET',
        'POST',
        'PUT',
        'PATCH',
        'DELETE',
        'HEAD',
        'OPTIONS',
      ]) {
        for (final background in [
          cs.surface,
          cs.surfaceContainerLow,
          cs.primaryContainer,
        ]) {
          expect(
            contrast(httpMethodColor(method, brightness), background),
            greaterThanOrEqualTo(4.5),
            reason: method,
          );
        }
      }
      for (final code in [0, 200, 302, 404, 500]) {
        final text = httpStatusColor(code, brightness);
        final pill = Color.alphaBlend(
          text.withAlpha(20),
          cs.surfaceContainerLow,
        );
        expect(
          contrast(text, pill),
          greaterThanOrEqualTo(4.5),
          reason: 'Status $code',
        );
      }
    });
  }
}
