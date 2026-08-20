import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/app_settings.dart';
import '../models/http_request.dart';
import '../models/http_response.dart';
import '../services/http_service.dart';
import '../services/export_service.dart';
import '../services/storage_service.dart';
import 'collections_provider.dart';
import 'request_tabs_provider.dart';
import 'settings_provider.dart';

// ─── Services ───────────────────────────────────────────────────────────────

final storageServiceProvider = Provider<StorageService>((ref) {
  return StorageService();
});

final httpServiceProvider = Provider<HttpService>((ref) {
  final settings = ref.watch(settingsProvider);
  final service = HttpService();
  service.configure(
    followRedirects: settings.followRedirects,
    timeoutSeconds: settings.timeoutSeconds,
    verifySsl: settings.verifySsl,
    proxyUrl: settings.proxyUrl,
  );
  return service;
});

// ─── State Notifiers ────────────────────────────────────────────────────────

final collectionsProvider =
    StateNotifierProvider<CollectionsNotifier, RootState>((ref) {
      final storage = ref.watch(storageServiceProvider);
      return CollectionsNotifier(storage);
    });

final requestTabsProvider =
    StateNotifierProvider<RequestTabsNotifier, RequestTabsState>((ref) {
      return RequestTabsNotifier(ref);
    });

/// Derived from the active tab — no separate state.
final currentRequestProvider = Provider<HttpRequestModel?>((ref) {
  final tabs = ref.watch(requestTabsProvider);
  if (tabs.isEmpty) return null;
  return tabs.activeTab.request;
});

/// Derived from the active tab — no separate state.
final responseProvider = Provider<AsyncValue<HttpResponseModel?>>((ref) {
  final tabs = ref.watch(requestTabsProvider);
  if (tabs.isEmpty) return const AsyncValue.data(null);
  return tabs.activeTab.response;
});

final settingsProvider = StateNotifierProvider<SettingsNotifier, AppSettings>((
  ref,
) {
  final storage = ref.watch(storageServiceProvider);
  return SettingsNotifier(storage);
});

/// Derives [ThemeMode] from persisted settings — single source of truth.
final appThemeProvider = Provider<ThemeMode>((ref) {
  final settings = ref.watch(settingsProvider);
  switch (settings.themeMode) {
    case ThemeMode.light:
      return ThemeMode.light;
    case ThemeMode.dark:
      return ThemeMode.dark;
    case ThemeMode.system:
      return ThemeMode.system;
  }
});

/// Derives the display [Locale] from persisted settings.
final localeProvider = Provider<Locale>((ref) {
  final settings = ref.watch(settingsProvider);
  return Locale(settings.localeCode);
});

/// Derives the theme seed [Color] from persisted settings.
final themeSeedProvider = Provider<Color>((ref) {
  final settings = ref.watch(settingsProvider);
  return Color(settings.themeSeedColor);
});

final exportServiceProvider = Provider<ExportService>((ref) => ExportService());
