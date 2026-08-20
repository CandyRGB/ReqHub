import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_settings.freezed.dart';
part 'app_settings.g.dart';

@freezed
class AppSettings with _$AppSettings {
  const factory AppSettings({
    required String storagePath,
    @Default(ThemeMode.system) ThemeMode themeMode,
    @Default(false) bool followRedirects,
    @Default(30) int timeoutSeconds,
    @Default(true) bool verifySsl,
    @Default('') String proxyUrl,
    @Default(14) int maxHistoryItems,
    @Default('en') String localeCode,
    @Default(0xFF2196F3) int themeSeedColor,
  }) = _AppSettings;

  factory AppSettings.fromJson(Map<String, dynamic> json) =>
      _$AppSettingsFromJson(json);
}
