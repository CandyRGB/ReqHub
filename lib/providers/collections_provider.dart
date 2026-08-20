import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../models/collection.dart';
import '../models/http_request.dart';
import '../services/storage_service.dart';

const _uuid = Uuid();

/// Combined state: collections tree + requests that live directly at root.
class RootState {
  final List<Collection> collections;
  final List<HttpRequestModel> rootRequests;

  const RootState({this.collections = const [], this.rootRequests = const []});

  RootState copyWith({
    List<Collection>? collections,
    List<HttpRequestModel>? rootRequests,
  }) {
    return RootState(
      collections: collections ?? this.collections,
      rootRequests: rootRequests ?? this.rootRequests,
    );
  }

  bool get isEmpty => collections.isEmpty && rootRequests.isEmpty;
}

/// Manages the tree of collections (folders) and their requests.
class CollectionsNotifier extends StateNotifier<RootState> {
  final StorageService _storage;
  bool _initialized = false;

  CollectionsNotifier(this._storage) : super(const RootState());

  bool get isInitialized => _initialized;

  Future<void> init() async {
    if (_initialized) return;
    final list = await _storage.loadCollections();
    state = RootState(collections: list);
    _initialized = true;
  }

  Future<void> _save() => _storage.saveCollections(state.collections);

  /// Add a new collection at the root level or inside a parent collection.
  /// Returns the id of the newly created collection.
  String addCollection(String name, {String? parentId}) {
    final id = _uuid.v4();
    final collection = Collection(
      id: id,
      name: name,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    if (parentId == null) {
      state = state.copyWith(collections: [...state.collections, collection]);
    } else {
      state = state.copyWith(
        collections: _updateCollection(state.collections, parentId, (c) {
          return c.copyWith(children: [...c.children, collection]);
        }),
      );
    }
    _save();
    return id;
  }

  /// Add a new request.  If [collectionId] is null the request goes directly
  /// under root (outside any collection).
  /// Returns the id of the newly created request.
  String addRequest(String? collectionId, HttpRequestModel request) {
    final id = _uuid.v4();
    final updated = request.copyWith(
      id: id,
      collectionId: collectionId,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    if (collectionId == null) {
      state = state.copyWith(rootRequests: [...state.rootRequests, updated]);
    } else {
      state = state.copyWith(
        collections: _updateCollection(state.collections, collectionId, (c) {
          return c.copyWith(requests: [...c.requests, updated]);
        }),
      );
    }
    _save();
    return id;
  }

  /// Update an existing request by id.
  void updateRequest(String requestId, HttpRequestModel updated) {
    // Check root requests first
    final ri = state.rootRequests.indexWhere((r) => r.id == requestId);
    if (ri >= 0) {
      final newList = [...state.rootRequests];
      newList[ri] = updated.copyWith(updatedAt: DateTime.now());
      state = state.copyWith(rootRequests: newList);
      _save();
      return;
    }
    state = state.copyWith(
      collections: state.collections
          .map((c) => _updateRequestInCollection(c, requestId, updated))
          .toList(),
    );
    _save();
  }

  Collection _updateRequestInCollection(
    Collection collection,
    String requestId,
    HttpRequestModel updated,
  ) {
    final reqIndex = collection.requests.indexWhere((r) => r.id == requestId);
    if (reqIndex >= 0) {
      final newRequests = [...collection.requests];
      newRequests[reqIndex] = updated.copyWith(updatedAt: DateTime.now());
      return collection.copyWith(requests: newRequests);
    }
    return collection.copyWith(
      children: collection.children
          .map((c) => _updateRequestInCollection(c, requestId, updated))
          .toList(),
    );
  }

  /// Delete a request by id.
  void deleteRequest(String requestId) {
    // Check root requests
    if (state.rootRequests.any((r) => r.id == requestId)) {
      state = state.copyWith(
        rootRequests: state.rootRequests
            .where((r) => r.id != requestId)
            .toList(),
      );
      _save();
      return;
    }
    state = state.copyWith(
      collections: state.collections
          .map((c) => _deleteRequestFromCollection(c, requestId))
          .toList(),
    );
    _save();
  }

  Collection _deleteRequestFromCollection(
    Collection collection,
    String requestId,
  ) {
    return collection.copyWith(
      requests: collection.requests.where((r) => r.id != requestId).toList(),
      children: collection.children
          .map((c) => _deleteRequestFromCollection(c, requestId))
          .toList(),
    );
  }

  /// Delete a collection by id.
  void deleteCollection(String collectionId) {
    state = state.copyWith(
      collections: _removeCollection(state.collections, collectionId),
    );
    _save();
  }

  List<Collection> _removeCollection(List<Collection> collections, String id) {
    return collections
        .where((c) => c.id != id)
        .map((c) => c.copyWith(children: _removeCollection(c.children, id)))
        .toList();
  }

  // ─── Move / reorder ──────────────────────────────────────────────

  /// Move a request from its current location to [targetCollectionId], or to
  /// root if [targetCollectionId] is null.
  void moveRequest(String requestId, String? targetCollectionId) {
    final request = findRequest(requestId);
    if (request == null) return;
    // Remove from current location
    final removed = state.collections
        .map((c) => _deleteRequestFromCollection(c, requestId))
        .toList();
    final rootReqs = state.rootRequests
        .where((r) => r.id != requestId)
        .toList();
    // Add to target
    final moved = request.copyWith(collectionId: targetCollectionId);
    if (targetCollectionId == null) {
      state = RootState(
        collections: removed,
        rootRequests: [...rootReqs, moved],
      );
    } else {
      state = RootState(
        collections: _addRequestToCollection(
          removed,
          targetCollectionId,
          moved,
        ),
        rootRequests: rootReqs,
      );
    }
    _save();
  }

  /// Move a collection to a new parent, or to root if [targetParentId] is null.
  void moveCollection(String collectionId, String? targetParentId) {
    final collection = findCollection(collectionId);
    if (collection == null) return;
    if (_isDescendantOf(collectionId, targetParentId)) return;
    final removed = _removeCollection(state.collections, collectionId);
    if (targetParentId == null) {
      state = state.copyWith(collections: [...removed, collection]);
    } else {
      state = state.copyWith(
        collections: _addCollectionToParent(
          removed,
          targetParentId,
          collection,
        ),
      );
    }
    _save();
  }

  /// Public helper: true if [descendantId] is nested anywhere under [ancestorId].
  bool isDescendantOf(String ancestorId, String descendantId) {
    final ancestor = findCollection(ancestorId);
    if (ancestor == null) return false;
    return _collectionContains(ancestor, descendantId);
  }

  /// Find the parent collection id for a request, or null if it's a root request.
  String? findRequestParentId(String requestId) {
    return _findRequestParentId(state.collections, requestId);
  }

  bool _isDescendantOf(String ancestorId, String? targetId) {
    if (targetId == null) return false;
    final ancestor = findCollection(ancestorId);
    if (ancestor == null) return false;
    return _collectionContains(ancestor, targetId);
  }

  bool _collectionContains(Collection parent, String id) {
    for (final child in parent.children) {
      if (child.id == id || _collectionContains(child, id)) return true;
    }
    return false;
  }

  List<Collection> _addRequestToCollection(
    List<Collection> collections,
    String collectionId,
    HttpRequestModel request,
  ) {
    return collections.map((c) {
      if (c.id == collectionId) {
        return c.copyWith(requests: [...c.requests, request]);
      }
      return c.copyWith(
        children: _addRequestToCollection(c.children, collectionId, request),
      );
    }).toList();
  }

  List<Collection> _addCollectionToParent(
    List<Collection> collections,
    String parentId,
    Collection child,
  ) {
    return collections.map((c) {
      if (c.id == parentId) {
        return c.copyWith(children: [...c.children, child]);
      }
      return c.copyWith(
        children: _addCollectionToParent(c.children, parentId, child),
      );
    }).toList();
  }

  String? duplicateRequest(String requestId) {
    final request = findRequest(requestId);
    if (request == null) return null;
    final parentId = _findRequestParentId(state.collections, requestId);
    final copy = request.copyWith(name: '${request.name} (copy)');
    return addRequest(parentId, copy);
  }

  String? _findRequestParentId(List<Collection> collections, String requestId) {
    for (final c in collections) {
      if (c.requests.any((r) => r.id == requestId)) return c.id;
      final found = _findRequestParentId(c.children, requestId);
      if (found != null) return found;
    }
    return null;
  }

  void renameItem(String id, String newName) {
    if (findCollection(id) != null) {
      renameCollection(id, newName);
      return;
    }
    final request = findRequest(id);
    if (request != null) {
      updateRequest(id, request.copyWith(name: newName));
    }
  }

  void renameCollection(String collectionId, String newName) {
    state = state.copyWith(
      collections: _updateCollection(
        state.collections,
        collectionId,
        (c) => c.copyWith(name: newName),
      ),
    );
    _save();
  }

  Collection? findCollection(String id) =>
      _findCollection(state.collections, id);

  Collection? _findCollection(List<Collection> collections, String id) {
    for (final c in collections) {
      if (c.id == id) return c;
      final found = _findCollection(c.children, id);
      if (found != null) return found;
    }
    return null;
  }

  HttpRequestModel? findRequest(String id) {
    for (final r in state.rootRequests) {
      if (r.id == id) return r;
    }
    for (final c in state.collections) {
      final found = _findRequestInCollection(c, id);
      if (found != null) return found;
    }
    return null;
  }

  HttpRequestModel? _findRequestInCollection(Collection collection, String id) {
    for (final r in collection.requests) {
      if (r.id == id) return r;
    }
    for (final child in collection.children) {
      final found = _findRequestInCollection(child, id);
      if (found != null) return found;
    }
    return null;
  }

  List<Collection> _updateCollection(
    List<Collection> collections,
    String id,
    Collection Function(Collection) updater,
  ) {
    return collections.map((c) {
      if (c.id == id) return updater(c);
      return c.copyWith(children: _updateCollection(c.children, id, updater));
    }).toList();
  }

  List<Collection> exportCollections() => state.collections;

  void importData(List<Collection> collections) {
    state = RootState(collections: collections);
    _save();
  }
}
