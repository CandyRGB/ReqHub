import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../models/collection.dart';
import '../models/app_settings.dart';

/// Handles reading and writing data to the local filesystem.
/// Default storage location: %APPDATA%/ReqHub/ on Windows.
class StorageService {
  static const String _dataFileName = 'reqhub_data.json';
  static const String _settingsFileName = 'reqhub_settings.json';

  String _storagePath = '';

  /// Initialize with optional custom path.
  /// If no path provided, uses %APPDATA%/ReqHub/ on Windows.
  Future<void> init([String? customPath]) async {
    if (customPath != null && customPath.isNotEmpty) {
      _storagePath = customPath;
    } else {
      final appDir = await getApplicationSupportDirectory();
      _storagePath = p.join(appDir.path, 'ReqHub');
    }
    final dir = Directory(_storagePath);
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    debugPrint('[StorageService] Path: $_storagePath');
  }

  String get storagePath => _storagePath;

  /// Read all collections and requests from disk.
  Future<List<Collection>> loadCollections() async {
    final file = File(p.join(_storagePath, _dataFileName));
    if (!await file.exists()) {
      return [];
    }
    final json = await file.readAsString();
    final list = jsonDecode(json) as List<dynamic>;
    return list
        .map((e) => Collection.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// Save collections to disk.
  Future<void> saveCollections(List<Collection> collections) async {
    final file = File(p.join(_storagePath, _dataFileName));
    final json = jsonEncode(collections.map((c) => c.toJson()).toList());
    await file.writeAsString(json);
  }

  /// Load app settings from disk.
  Future<AppSettings?> loadSettings() async {
    final file = File(p.join(_storagePath, _settingsFileName));
    if (!await file.exists()) {
      return null;
    }
    final json = await file.readAsString();
    return AppSettings.fromJson(jsonDecode(json) as Map<String, dynamic>);
  }

  /// Save app settings to disk.
  Future<void> saveSettings(AppSettings settings) async {
    final file = File(p.join(_storagePath, _settingsFileName));
    await file.writeAsString(jsonEncode(settings.toJson()));
  }

  /// Export data file to a user-chosen directory.
  Future<void> exportData(String targetDir) async {
    final srcFile = File(p.join(_storagePath, _dataFileName));
    if (!await srcFile.exists()) {
      throw Exception('No data file to export.');
    }
    final destFile = File(p.join(targetDir, _dataFileName));
    await srcFile.copy(destFile.path);
  }

  /// Import data from a file into the current storage.
  Future<void> importData(String sourceFilePath) async {
    final srcFile = File(sourceFilePath);
    if (!await srcFile.exists()) {
      throw Exception('Import file not found: $sourceFilePath');
    }
    final destFile = File(p.join(_storagePath, _dataFileName));
    await srcFile.copy(destFile.path);
  }
}
