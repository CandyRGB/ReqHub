import 'dart:convert';
import 'dart:io';

import '../models/collection.dart';

/// Handles export/import of collections as JSON files.
class ExportService {
  /// Export collections to a JSON file at [filePath].
  Future<void> exportToFile(
    List<Collection> collections,
    String filePath,
  ) async {
    final file = File(filePath);
    final json = const JsonEncoder.withIndent(
      '  ',
    ).convert(collections.map((c) => c.toJson()).toList());
    await file.writeAsString(json);
  }

  /// Import collections from a JSON file at [filePath].
  Future<List<Collection>> importFromFile(String filePath) async {
    final file = File(filePath);
    final json = await file.readAsString();
    final list = jsonDecode(json) as List<dynamic>;
    return list
        .map((e) => Collection.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
