import 'package:flutter_test/flutter_test.dart';
import 'package:reqhub/models/request_body.dart';
import 'package:reqhub/models/key_value_pair.dart';

void main() {
  group('RequestBody — sealed union types', () {
    test('NoneBody is RequestBody.none()', () {
      const body = RequestBody.none();
      expect(body, isA<NoneBody>());
      expect(body, isNot(isA<JsonBody>()));
    });

    test('JsonBody stores raw string', () {
      final body = RequestBody.json(raw: '{"key":"value"}');
      expect(body, isA<JsonBody>());
      expect((body as JsonBody).raw, '{"key":"value"}');
    });

    test('JsonBody defaults raw to empty string', () {
      const body = RequestBody.json();
      expect((body as JsonBody).raw, '');
    });

    test('FormDataBody stores list of FormField', () {
      final body = RequestBody.formData(
        fields: [FormField(key: 'name', value: 'test')],
      );
      expect(body, isA<FormDataBody>());
      final fields = (body as FormDataBody).fields;
      expect(fields.length, 1);
      expect(fields.first.key, 'name');
      expect(fields.first.value, 'test');
      expect(fields.first.type, FormFieldType.text);
    });

    test('UrlEncodedBody stores query params', () {
      final body = RequestBody.urlEncoded(
        params: [KeyValuePair(key: 'q', value: 'hello')],
      );
      expect(body, isA<UrlEncodedBody>());
      expect((body as UrlEncodedBody).params.length, 1);
    });

    test('RawBody stores content type and body', () {
      const body = RequestBody.raw(contentType: 'text/xml', content: '<xml/>');
      expect(body, isA<RawBody>());
      expect((body as RawBody).contentType, 'text/xml');
      expect((body).content, '<xml/>');
    });

    test('creating a new body replaces the old one', () {
      final old = RequestBody.json(raw: 'old');
      final updated = RequestBody.json(raw: 'new');
      expect((old as JsonBody).raw, 'old');
      expect((updated as JsonBody).raw, 'new');
    });
  });

  group('FormField', () {
    test('creates with required key', () {
      final field = FormField(key: 'Authorization');
      expect(field.key, 'Authorization');
      expect(field.value, '');
      expect(field.type, FormFieldType.text);
      expect(field.filePath, '');
    });

    test('equality works', () {
      final a = FormField(key: 'k', value: 'v');
      final b = FormField(key: 'k', value: 'v');
      expect(a, equals(b));
    });
  });
}
