import 'package:flutter_test/flutter_test.dart';
import 'package:reqhub/models/http_request.dart';
import 'package:reqhub/models/key_value_pair.dart';

void main() {
  group('HttpRequestModel', () {
    test('creates with minimum required fields', () {
      final req = HttpRequestModel(id: '1', name: 'Test');
      expect(req.id, '1');
      expect(req.name, 'Test');
      expect(req.method, 'GET');
      expect(req.url, '');
      expect(req.headers, isEmpty);
    });

    test('copyWith updates method and url', () {
      final req = HttpRequestModel(id: '1', name: 'Test');
      final updated = req.copyWith(method: 'POST', url: 'https://example.com');
      expect(updated.method, 'POST');
      expect(updated.url, 'https://example.com');
      expect(updated.id, '1'); // unchanged
    });

    test('copyWith with headers replaces the list', () {
      final req = HttpRequestModel(id: '1', name: 'Test');
      final headers = [KeyValuePair(key: 'Content-Type', value: 'application/json')];
      final updated = req.copyWith(headers: headers);
      expect(updated.headers.length, 1);
      expect(updated.headers.first.key, 'Content-Type');
    });

    test('AuthConfig.noAuth is the default', () {
      const auth = AuthConfig.noAuth();
      expect(auth, isA<NoAuth>());
    });

    test('BasicAuth stores username/password and supports copyWith', () {
      const auth = AuthConfig.basic(username: 'admin', password: 's3cret');
      expect(auth, isA<BasicAuth>());
      final result = (auth as BasicAuth).copyWith(username: 'root');
      expect(result.username, 'root');
      expect(result.password, 's3cret');
    });

    test('BearerAuth stores token and supports copyWith', () {
      const auth = AuthConfig.bearer(token: 'tok123');
      expect(auth, isA<BearerAuth>());
      final result = (auth as BearerAuth).copyWith(token: 'newtok');
      expect(result.token, 'newtok');
    });

    test('ApiKeyAuth stores key/value/addTo and supports copyWith', () {
      const auth = AuthConfig.apiKey(key: 'X-Key', value: 'val', addTo: 'header');
      final result = (auth as ApiKeyAuth).copyWith(value: 'newval');
      expect(result.value, 'newval');
      expect(result.key, 'X-Key');
    });
  });

  group('KeyValuePair', () {
    test('enabled is false by default', () {
      final kv = KeyValuePair(key: 'k', value: 'v');
      expect(kv.enabled, false);
    });

    test('description is null by default', () {
      final kv = KeyValuePair(key: 'k', value: 'v');
      expect(kv.description, null);
    });
  });
}
