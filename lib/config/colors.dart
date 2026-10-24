import 'package:flutter/material.dart' show Brightness, Color;

/// Accent presets and brightness-aware semantic colors for the ReqHub UI.

/// Keep persisted seed values stable while refining their displayed accents.
const presetThemeSeeds = <({String label, int value, Color light, Color dark})>[
  (
    label: 'Blue',
    value: 0xFF2196F3,
    light: Color(0xFF2563EB),
    dark: Color(0xFF8AAEFF),
  ),
  (
    label: 'Indigo',
    value: 0xFF3F51B5,
    light: Color(0xFF4F46E5),
    dark: Color(0xFFABA5FF),
  ),
  (
    label: 'Teal',
    value: 0xFF009688,
    light: Color(0xFF0F766E),
    dark: Color(0xFF65D6C5),
  ),
  (
    label: 'Green',
    value: 0xFF4CAF50,
    light: Color(0xFF16753B),
    dark: Color(0xFF7DDBA2),
  ),
  (
    label: 'Purple',
    value: 0xFF673AB7,
    light: Color(0xFF7E22CE),
    dark: Color(0xFFC7A4FF),
  ),
  (
    label: 'Orange',
    value: 0xFFFF5722,
    light: Color(0xFFC2410C),
    dark: Color(0xFFFFB482),
  ),
  (
    label: 'Slate',
    value: 0xFF607D8B,
    light: Color(0xFF475569),
    dark: Color(0xFFB6C4D8),
  ),
  (
    label: 'Mono',
    value: 0xFF757575,
    light: Color(0xFF3F3F46),
    dark: Color(0xFFD4D4D8),
  ),
];

Color? themeAccentForSeed(int value, Brightness brightness) {
  for (final preset in presetThemeSeeds) {
    if (preset.value == value) {
      return brightness == Brightness.dark ? preset.dark : preset.light;
    }
  }
  return null;
}

/// Semantic colors are independent of the selected accent and readable on
/// both the editor surface and the sidebar.
Color httpMethodColor(String method, Brightness brightness) {
  final isDark = brightness == Brightness.dark;
  return switch (method.toUpperCase()) {
    'GET' => isDark ? const Color(0xFF8AB4FF) : const Color(0xFF1D4ED8),
    'POST' => isDark ? const Color(0xFF7DDBA2) : const Color(0xFF16753B),
    'PUT' => isDark ? const Color(0xFFF7BD65) : const Color(0xFF9A4B0B),
    'PATCH' => isDark ? const Color(0xFFE8D277) : const Color(0xFF925C08),
    'DELETE' => isDark ? const Color(0xFFFF9B9B) : const Color(0xFFB91C1C),
    'HEAD' => isDark ? const Color(0xFFC7A4FF) : const Color(0xFF7E22CE),
    _ => isDark ? const Color(0xFFB6C4D8) : const Color(0xFF475569),
  };
}

Color httpStatusColor(int code, Brightness brightness) {
  if (code >= 200 && code < 300) return httpMethodColor('POST', brightness);
  if (code >= 300 && code < 400) return httpMethodColor('PUT', brightness);
  if (code <= 0 || code >= 400) return httpMethodColor('DELETE', brightness);
  return httpMethodColor('OPTIONS', brightness);
}
