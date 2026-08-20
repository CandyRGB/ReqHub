import 'package:flutter_test/flutter_test.dart';
import 'package:reqhub/services/curl_parser.dart';
import 'package:reqhub/models/http_request.dart';
import 'package:reqhub/models/request_body.dart';

void main() {
  group('CurlParser', () {
    test('throws FormatException for empty input', () {
      expect(() => CurlParser.parse(''), throwsFormatException);
    });

    test('throws FormatException for non-curl input', () {
      expect(
        () => CurlParser.parse('wget http://example.com'),
        throwsFormatException,
      );
    });

    test('parses simple curl GET', () {
      final result = CurlParser.parse('curl https://example.com');
      expect(result.method, 'GET');
      expect(result.url, 'https://example.com');
    });

    test('parses curl with -X method flag', () {
      final result = CurlParser.parse('curl -X POST https://example.com');
      expect(result.method, 'POST');
    });

    test('parses curl with --request flag', () {
      final result =
          CurlParser.parse('curl --request PUT https://example.com/api');
      expect(result.method, 'PUT');
    });

    test('parses curl with single -H header', () {
      final result = CurlParser.parse(
        'curl -H "Content-Type: application/json" https://example.com',
      );
      expect(result.headers.length, 1);
      expect(result.headers.first.key, 'Content-Type');
      expect(result.headers.first.value, 'application/json');
    });

    test('parses curl with multiple -H headers', () {
      final result = CurlParser.parse(
        'curl -H "Accept: json" -H "Auth: Bearer tok" https://example.com',
      );
      expect(result.headers.length, 2);
    });

    test('parses curl with --header flag', () {
      final result = CurlParser.parse(
        'curl --header "X-Custom: val" https://example.com',
      );
      expect(result.headers.length, 1);
      expect(result.headers.first.key, 'X-Custom');
    });

    test('parses curl with -d data as JSON body', () {
      final result = CurlParser.parse(
        "curl -X POST -d '{\"name\":\"test\"}' https://example.com",
      );
      expect(result.body, isA<JsonBody>());
    });

    test('parses curl with --data-raw flag', () {
      final result = CurlParser.parse(
        "curl --data-raw 'raw content' https://example.com",
      );
      expect(result.body, isA<RawBody>());
    });

    test('parses curl with -u basic auth', () {
      final result = CurlParser.parse(
        'curl -u admin:secret https://example.com',
      );
      expect(result.auth, isA<BasicAuth>());
    });

    test('parses curl with --url flag', () {
      final result = CurlParser.parse(
        'curl --url https://example.com/api',
      );
      expect(result.url, 'https://example.com/api');
    });

    test('default method is GET when no method flag', () {
      final result = CurlParser.parse('curl https://example.com/path');
      expect(result.method, 'GET');
    });
  });
}
