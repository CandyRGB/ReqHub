import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../models/http_request.dart';
import '../models/http_response.dart';
import '../models/key_value_pair.dart';
import '../models/request_body.dart';
import 'providers.dart';

const _uuid = Uuid();

/// Per-tab state: the request being edited and its last response.
class RequestTabData {
  final String tabId;
  final HttpRequestModel request;
  final AsyncValue<HttpResponseModel?> response;
  final bool isDirty;

  const RequestTabData({
    required this.tabId,
    required this.request,
    this.response = const AsyncValue.data(null),
    this.isDirty = false,
  });

  RequestTabData copyWith({
    HttpRequestModel? request,
    AsyncValue<HttpResponseModel?>? response,
    bool? isDirty,
  }) {
    return RequestTabData(
      tabId: tabId,
      request: request ?? this.request,
      response: response ?? this.response,
      isDirty: isDirty ?? this.isDirty,
    );
  }
}

class RequestTabsState {
  final List<RequestTabData> tabs;
  final int activeIndex;

  const RequestTabsState({this.tabs = const [], this.activeIndex = 0});

  bool get isEmpty => tabs.isEmpty;
  bool get isNotEmpty => tabs.isNotEmpty;
  RequestTabData get activeTab => tabs[activeIndex];
}

/// Manages multiple open request tabs.  [currentRequestProvider] and
/// [responseProvider] are derived from this provider — no manual sync needed.
class RequestTabsNotifier extends StateNotifier<RequestTabsState> {
  final Ref _ref;

  /// Cache the last response per request id so reopening a closed tab
  /// restores its response.
  final Map<String, AsyncValue<HttpResponseModel?>> _responseCache = {};

  RequestTabsNotifier(this._ref) : super(const RequestTabsState());

  // ─── Internal ─────────────────────────────────────────────────────

  void _updateTab(
    int index, {
    HttpRequestModel? request,
    AsyncValue<HttpResponseModel?>? response,
    bool? isDirty,
  }) {
    if (index < 0 || index >= state.tabs.length) return;
    final updated = List<RequestTabData>.from(state.tabs);
    // Auto-mark dirty when the request changes and isDirty is not explicitly provided.
    final effectiveDirty = isDirty ?? (request != null ? true : null);
    updated[index] = updated[index].copyWith(
      request: request,
      response: response,
      isDirty: effectiveDirty,
    );
    state = RequestTabsState(tabs: updated, activeIndex: state.activeIndex);
  }

  /// Whether any open tab has unsaved changes.
  bool get hasUnsavedTabs => state.tabs.any((t) => t.isDirty);

  // ─── Tab lifecycle ────────────────────────────────────────────────

  void openTab(HttpRequestModel request) {
    final existingIndex = state.tabs.indexWhere(
      (t) => t.request.id == request.id && request.id.isNotEmpty,
    );
    if (existingIndex >= 0) {
      state = RequestTabsState(tabs: state.tabs, activeIndex: existingIndex);
      return;
    }
    final cachedResponse = _responseCache[request.id];
    final tab = RequestTabData(
      tabId: _uuid.v4(),
      request: request,
      response: cachedResponse ?? const AsyncValue.data(null),
    );
    final newTabs = [...state.tabs, tab];
    state = RequestTabsState(tabs: newTabs, activeIndex: newTabs.length - 1);
  }

  void createNewTab({String? collectionId}) {
    final request = HttpRequestModel(
      id: _uuid.v4(),
      name: 'New Request',
      method: 'GET',
      collectionId: collectionId,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    openTab(request);
  }

  void activateTab(int index) {
    if (index < 0 || index >= state.tabs.length || index == state.activeIndex) {
      return;
    }
    state = RequestTabsState(tabs: state.tabs, activeIndex: index);
  }

  /// Close the tab that contains [requestId], if any.
  void closeRequestTab(String requestId) {
    final index = state.tabs.indexWhere((t) => t.request.id == requestId);
    if (index >= 0) closeTab(index);
  }

  /// Persist the tab's current request to [CollectionsNotifier] and mark clean.
  void saveTab(int index) {
    if (index < 0 || index >= state.tabs.length) return;
    final request = state.tabs[index].request;
    _ref.read(collectionsProvider.notifier).updateRequest(request.id, request);
    _updateTab(index, isDirty: false);
  }

  void closeTab(int index) {
    if (index < 0 || index >= state.tabs.length) return;

    // Cache the tab's response so reopening restores it.
    final tab = state.tabs[index];
    final requestId = tab.request.id;
    if (requestId.isNotEmpty && tab.response != const AsyncValue.data(null)) {
      _responseCache[requestId] = tab.response;
    }

    if (index != state.activeIndex) {
      final newTabs = List<RequestTabData>.from(state.tabs)..removeAt(index);
      final newActive = state.activeIndex > index
          ? state.activeIndex - 1
          : state.activeIndex;
      state = RequestTabsState(tabs: newTabs, activeIndex: newActive);
      return;
    }
    final newTabs = List<RequestTabData>.from(state.tabs)..removeAt(index);
    if (newTabs.isEmpty) {
      state = RequestTabsState();
      return;
    }
    final newActive = state.activeIndex >= newTabs.length
        ? newTabs.length - 1
        : state.activeIndex;
    state = RequestTabsState(tabs: newTabs, activeIndex: newActive);
  }

  // ─── Send ─────────────────────────────────────────────────────────

  Future<void> sendActiveRequest() async {
    if (state.isEmpty) return;
    final capturingIndex = state.activeIndex;
    final capturingTabId = state.tabs[capturingIndex].tabId;
    final request = state.tabs[capturingIndex].request;

    _updateTab(capturingIndex, response: const AsyncValue.loading());

    try {
      final httpService = _ref.read(httpServiceProvider);
      final response = await httpService.send(request);
      if (state.activeIndex == capturingIndex &&
          state.tabs.length > capturingIndex &&
          state.tabs[capturingIndex].tabId == capturingTabId) {
        _updateTab(capturingIndex, response: AsyncValue.data(response));
      }
    } catch (e, st) {
      if (state.activeIndex == capturingIndex &&
          state.tabs.length > capturingIndex &&
          state.tabs[capturingIndex].tabId == capturingTabId) {
        _updateTab(capturingIndex, response: AsyncValue.error(e, st));
      }
    }
  }

  void updateActiveTabRequest(HttpRequestModel request) {
    if (state.isEmpty) return;
    _updateTab(state.activeIndex, request: request);
  }

  // ─── Field-level edits (called by editor widgets) ─────────────────

  void updateActiveMethod(String method) {
    if (state.isEmpty) return;
    _updateTab(
      state.activeIndex,
      request: state.activeTab.request.copyWith(method: method),
    );
  }

  void updateActiveUrl(String url) {
    if (state.isEmpty) return;
    _updateTab(
      state.activeIndex,
      request: state.activeTab.request.copyWith(url: url),
    );
  }

  void updateActiveName(String name) {
    if (state.isEmpty) return;
    _updateTab(
      state.activeIndex,
      request: state.activeTab.request.copyWith(name: name),
    );
  }

  void updateActiveHeaders(List<KeyValuePair> headers) {
    if (state.isEmpty) return;
    _updateTab(
      state.activeIndex,
      request: state.activeTab.request.copyWith(headers: headers),
    );
  }

  void updateActiveQueryParams(List<KeyValuePair> params) {
    if (state.isEmpty) return;
    _updateTab(
      state.activeIndex,
      request: state.activeTab.request.copyWith(queryParams: params),
    );
  }

  void updateActiveBody(RequestBody body) {
    if (state.isEmpty) return;
    _updateTab(
      state.activeIndex,
      request: state.activeTab.request.copyWith(body: body),
    );
  }

  void updateActiveAuth(AuthConfig? auth) {
    if (state.isEmpty) return;
    _updateTab(
      state.activeIndex,
      request: state.activeTab.request.copyWith(auth: auth),
    );
  }
}
