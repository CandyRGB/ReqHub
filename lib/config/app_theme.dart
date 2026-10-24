import 'package:flutter/material.dart';

import 'app_typography.dart';
import 'colors.dart';

/// Neutral workspace surfaces stay consistent as the user changes accents.
/// Accents are reserved for actions, selection and keyboard focus.
ThemeData buildAppTheme(Brightness brightness, Color seed) {
  final isDark = brightness == Brightness.dark;
  final generated = ColorScheme.fromSeed(
    seedColor: seed,
    brightness: brightness,
  );
  final accent =
      themeAccentForSeed(seed.toARGB32(), brightness) ?? generated.primary;
  final surface = isDark ? const Color(0xFF191B22) : const Color(0xFFFFFFFF);
  final foreground = isDark ? const Color(0xFFE8EAF0) : const Color(0xFF20242D);
  final muted = isDark ? const Color(0xFFA5ADBC) : const Color(0xFF5B6474);
  final selection = Color.alphaBlend(
    accent.withValues(alpha: isDark ? 0.16 : 0.09),
    surface,
  );
  final colors = generated.copyWith(
    primary: accent,
    onPrimary: isDark ? const Color(0xFF111318) : Colors.white,
    primaryContainer: selection,
    onPrimaryContainer: accent,
    secondary: muted,
    onSecondary: surface,
    secondaryContainer: isDark
        ? const Color(0xFF2B2F39)
        : const Color(0xFFF0F2F5),
    onSecondaryContainer: foreground,
    tertiary: accent,
    onTertiary: isDark ? const Color(0xFF111318) : Colors.white,
    tertiaryContainer: selection,
    onTertiaryContainer: accent,
    surface: surface,
    onSurface: foreground,
    onSurfaceVariant: muted,
    surfaceDim: isDark ? const Color(0xFF111318) : const Color(0xFFF0F2F5),
    surfaceBright: isDark ? const Color(0xFF30343E) : Colors.white,
    surfaceContainerLowest: isDark ? const Color(0xFF111318) : Colors.white,
    surfaceContainerLow: isDark
        ? const Color(0xFF15171D)
        : const Color(0xFFF8F9FB),
    surfaceContainer: isDark
        ? const Color(0xFF20232B)
        : const Color(0xFFF0F2F5),
    surfaceContainerHigh: isDark
        ? const Color(0xFF292D37)
        : const Color(0xFFE9ECF1),
    surfaceContainerHighest: isDark
        ? const Color(0xFF343945)
        : const Color(0xFFDFE3EA),
    outline: isDark ? const Color(0xFF626B7C) : const Color(0xFF9CA4B2),
    outlineVariant: isDark ? const Color(0xFF303540) : const Color(0xFFE1E5EB),
    error: isDark ? const Color(0xFFFF9B9B) : const Color(0xFFB91C1C),
    onError: isDark ? const Color(0xFF420A12) : Colors.white,
    errorContainer: isDark ? const Color(0xFF42232B) : const Color(0xFFFEF0F0),
    onErrorContainer: isDark
        ? const Color(0xFFFFB4B4)
        : const Color(0xFF991B1B),
    inverseSurface: isDark ? const Color(0xFFE8EAF0) : const Color(0xFF292D37),
    onInverseSurface: isDark
        ? const Color(0xFF20242D)
        : const Color(0xFFF8F9FB),
    inversePrimary: isDark
        ? themeAccentForSeed(seed.toARGB32(), Brightness.light)
        : themeAccentForSeed(seed.toARGB32(), Brightness.dark),
    surfaceTint: Colors.transparent,
  );
  const shape = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(6)),
  );
  final base = ThemeData(
    useMaterial3: true,
    brightness: brightness,
    colorScheme: colors,
    fontFamily: appFontFamily,
    fontFamilyFallback: appFontFallback,
    scaffoldBackgroundColor: surface,
    canvasColor: surface,
    cardColor: surface,
    dividerColor: colors.outlineVariant,
    disabledColor: muted.withValues(alpha: 0.45),
    hoverColor: foreground.withValues(alpha: 0.04),
    focusColor: accent.withValues(alpha: 0.12),
    splashFactory: NoSplash.splashFactory,
    iconTheme: IconThemeData(color: muted, size: 18),
    dividerTheme: DividerThemeData(
      color: colors.outlineVariant,
      thickness: 1,
      space: 1,
    ),
    cardTheme: CardThemeData(
      color: surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shape: shape,
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: surface,
      surfaceTintColor: Colors.transparent,
      shape: shape.copyWith(side: BorderSide(color: colors.outlineVariant)),
    ),
    menuTheme: MenuThemeData(
      style: MenuStyle(
        backgroundColor: WidgetStatePropertyAll(surface),
        surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
        shape: const WidgetStatePropertyAll(shape),
        side: WidgetStatePropertyAll(BorderSide(color: colors.outlineVariant)),
        visualDensity: VisualDensity.compact,
        padding: const WidgetStatePropertyAll(EdgeInsets.all(4)),
        elevation: const WidgetStatePropertyAll(4),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        shape: shape,
        textStyle: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          fontFamily: appFontFamily,
          fontFamilyFallback: appFontFallback,
        ),
        elevation: 0,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(shape: shape),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: shape,
        side: BorderSide(color: colors.outline),
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(shape: shape, foregroundColor: muted),
    ),
    segmentedButtonTheme: SegmentedButtonThemeData(
      style: ButtonStyle(
        shape: const WidgetStatePropertyAll(shape),
        side: WidgetStatePropertyAll(BorderSide(color: colors.outlineVariant)),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return colors.surfaceContainerLow;
          }
          if (states.contains(WidgetState.selected)) {
            return selection;
          }
          return surface;
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return muted.withValues(alpha: 0.45);
          }
          return states.contains(WidgetState.selected) ? accent : muted;
        }),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      filled: true,
      fillColor: isDark ? const Color(0xFF15171D) : const Color(0xFFFCFCFD),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      hintStyle: TextStyle(color: muted),
      labelStyle: TextStyle(color: muted),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(
          color: Color.alphaBlend(
            colors.outline.withValues(alpha: 0.32),
            surface,
          ),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: accent, width: 1.5),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: colors.outlineVariant),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: colors.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: colors.error, width: 1.5),
      ),
    ),
    tabBarTheme: TabBarThemeData(
      indicatorSize: TabBarIndicatorSize.tab,
      dividerHeight: 0,
      labelColor: accent,
      unselectedLabelColor: muted,
      indicatorColor: accent,
      labelStyle: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        fontFamily: appFontFamily,
        fontFamilyFallback: appFontFallback,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 13,
        fontFamily: appFontFamily,
        fontFamilyFallback: appFontFallback,
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: accent,
      selectionColor: accent.withValues(alpha: isDark ? 0.3 : 0.18),
      selectionHandleColor: accent,
    ),
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: colors.inverseSurface,
        borderRadius: BorderRadius.circular(4),
      ),
      textStyle: TextStyle(
        color: colors.onInverseSurface,
        fontSize: 12,
        fontFamily: appFontFamily,
        fontFamilyFallback: appFontFallback,
      ),
    ),
  );
  return base.copyWith(
    textTheme: base.textTheme.apply(
      bodyColor: foreground,
      displayColor: foreground,
      fontFamilyFallback: appFontFallback,
    ),
    primaryTextTheme: base.primaryTextTheme.apply(
      fontFamilyFallback: appFontFallback,
    ),
  );
}
