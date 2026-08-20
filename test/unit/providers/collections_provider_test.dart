import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reqhub/models/app_settings.dart';
import 'package:reqhub/models/collection.dart';
import 'package:reqhub/models/http_request.dart';
import 'package:reqhub/providers/providers.dart';
import 'package:reqhub/services/storage_service.dart';

ProviderContainer createContainer() {
  final container = ProviderContainer(
    overrides: [storageServiceProvider.overrideWithValue(FakeStorage())],
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  group('CollectionsNotifier', () {
    test('initial state is empty', () {
      final container = createContainer();
      final state = container.read(collectionsProvider);
      expect(state.collections, isEmpty);
      expect(state.rootRequests, isEmpty);
    });

    test('addCollection creates a new collection with non-empty id', () {
      final container = createContainer();
      final notifier = container.read(collectionsProvider.notifier);
      notifier.addCollection('Test');

      final state = container.read(collectionsProvider);
      expect(state.collections.length, 1);
      expect(state.collections.first.name, 'Test');
      expect(state.collections.first.id, isNotEmpty);
    });

    test('addCollection to parent nests correctly', () {
      final container = createContainer();
      final notifier = container.read(collectionsProvider.notifier);
      final parentId = notifier.addCollection('Parent');
      notifier.addCollection('Child', parentId: parentId);

      final state = container.read(collectionsProvider);
      expect(state.collections.first.children.length, 1);
      expect(state.collections.first.children.first.name, 'Child');
    });

    test('addRequest to root creates root-level request', () {
      final container = createContainer();
      final notifier = container.read(collectionsProvider.notifier);
      notifier.addRequest(
        null,
        HttpRequestModel(id: '', name: 'My Request', method: 'GET'),
      );

      final state = container.read(collectionsProvider);
      expect(state.rootRequests.length, 1);
      expect(state.rootRequests.first.name, 'My Request');
      expect(state.rootRequests.first.id, isNotEmpty);
    });

    test('addRequest to collection nests inside it', () {
      final container = createContainer();
      final notifier = container.read(collectionsProvider.notifier);
      final colId = notifier.addCollection('Folder');
      notifier.addRequest(
        colId,
        HttpRequestModel(id: '', name: 'Nested', method: 'POST'),
      );

      final state = container.read(collectionsProvider);
      expect(state.collections.first.requests.first.name, 'Nested');
    });

    test('deleteCollection removes it', () {
      final container = createContainer();
      final notifier = container.read(collectionsProvider.notifier);
      final id = notifier.addCollection('To Delete');
      notifier.deleteCollection(id);
      expect(container.read(collectionsProvider).collections, isEmpty);
    });

    test('deleteRequest removes it from root', () {
      final container = createContainer();
      final notifier = container.read(collectionsProvider.notifier);
      final id = notifier.addRequest(
        null,
        HttpRequestModel(id: '', name: 'Delete Me', method: 'GET'),
      );
      notifier.deleteRequest(id);
      expect(container.read(collectionsProvider).rootRequests, isEmpty);
    });

    test('renameItem renames a collection', () {
      final container = createContainer();
      final notifier = container.read(collectionsProvider.notifier);
      final id = notifier.addCollection('Old');
      notifier.renameItem(id, 'New');
      expect(
        container.read(collectionsProvider).collections.first.name,
        'New',
      );
    });

    test('duplicateRequest creates a copy with (copy) suffix', () {
      final container = createContainer();
      final notifier = container.read(collectionsProvider.notifier);
      final req = HttpRequestModel(id: '', name: 'Original', method: 'GET');
      final id = notifier.addRequest(null, req);
      notifier.duplicateRequest(id);

      final names =
          container.read(collectionsProvider).rootRequests.map((r) => r.name);
      expect(names, contains('Original (copy)'));
    });

    test('findRequest returns found request or null', () {
      final container = createContainer();
      final notifier = container.read(collectionsProvider.notifier);
      final colId = notifier.addCollection('Folder');
      final reqId = notifier.addRequest(
        colId,
        HttpRequestModel(id: '', name: 'Find Me', method: 'DELETE'),
      );

      expect(notifier.findRequest(reqId)!.name, 'Find Me');
      expect(notifier.findRequest('nonexistent'), isNull);
    });
  });
}

class FakeStorage extends StorageService {
  @override
  Future<void> init([String? customPath]) async {}

  @override
  Future<List<Collection>> loadCollections() async => [];

  @override
  Future<void> saveCollections(List<Collection> collections) async {}

  @override
  Future<AppSettings?> loadSettings() async => null;

  @override
  Future<void> saveSettings(AppSettings settings) async {}
}
