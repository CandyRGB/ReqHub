import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/app_settings.dart';
import '../services/storage_service.dart';

/// Manages application settings with persistence.
class SettingsNotifier extends StateNotifier<AppSettings> {
  final StorageService _storage;
  bool _initialized = false;

  SettingsNotifier(this._storage) : super(AppSettings(storagePath: ''));

  bool get isInitialized => _initialized;

  Future<void> init() async {
    if (_initialized) return;
    final saved = await _storage.loadSettings();
    state = saved ?? AppSettings(storagePath: _storage.storagePath);
    _initialized = true;
  }

  Future<void> _save() => _storage.saveSettings(state);

  void setStoragePath(String path) {
    state = state.copyWith(storagePath: path);
    _save();
  }

  void setThemeMode(ThemeMode mode) {
    state = state.copyWith(themeMode: mode);
    _save();
  }

  void setFollowRedirects(bool value) {
    state = state.copyWith(followRedirects: value);
    _save();
  }

  void setTimeout(int seconds) {
    state = state.copyWith(timeoutSeconds: seconds);
    _save();
  }

  void setVerifySsl(bool value) {
    state = state.copyWith(verifySsl: value);
    _save();
  }

  void setProxyUrl(String url) {
    state = state.copyWith(proxyUrl: url);
    _save();
  }

  void setLocale(String localeCode) {
    state = state.copyWith(localeCode: localeCode);
    _save();
  }

  void setThemeSeed(int colorValue) {
    state = state.copyWith(themeSeedColor: colorValue);
    _save();
  }
}
