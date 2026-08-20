import '../models/http_request.dart';
import '../models/request_body.dart';

/// Generates a curl command string from an [HttpRequestModel].
class CurlGenerator {
  static String generate(HttpRequestModel model) {
    final buffer = StringBuffer();
    buffer.write('curl');

    // Method
    if (model.method != 'GET') {
      buffer.write(' -X ${model.method}');
    }

    // URL
    buffer.write(' "${_escapeQuote(model.url)}"');

    // Headers
    for (final h in model.headers.where((h) => h.enabled)) {
      buffer.write(
        ' \\\n  -H "${_escapeQuote(h.key)}: ${_escapeQuote(h.value)}"',
      );
    }

    // Auth
    final auth = model.auth;
    if (auth != null && auth is! NoAuth) {
      switch (auth) {
        case BasicAuth(:final username, :final password):
          buffer.write(
            ' \\\n  -u "${_escapeQuote(username)}:${_escapeQuote(password)}"',
          );
        case BearerAuth(:final token):
          if (token.isNotEmpty) {
            buffer.write(
              ' \\\n  -H "Authorization: Bearer ${_escapeQuote(token)}"',
            );
          }
        case ApiKeyAuth(:final addTo, :final key, :final value):
          if (addTo == 'header' && key.isNotEmpty) {
            buffer.write(
              ' \\\n  -H "${_escapeQuote(key)}: ${_escapeQuote(value)}"',
            );
          }
        case NoAuth():
          break;
      }
    }

    // Body
    final body = model.body;
    switch (body) {
      case JsonBody(raw: final raw):
        if (raw.isNotEmpty) {
          buffer.write(' \\\n  -H "Content-Type: application/json"');
          buffer.write(' \\\n  -d \'${_escapeSingleQuote(raw)}\'');
        }
      case UrlEncodedBody(params: final params):
        final data = params
            .where((p) => p.enabled)
            .map(
              (p) =>
                  '${Uri.encodeComponent(p.key)}=${Uri.encodeComponent(p.value)}',
            )
            .join('&');
        if (data.isNotEmpty) {
          buffer.write(" \\\n  -d '$data'");
        }
      case FormDataBody(fields: final fields):
        for (final f in fields) {
          if (f.type == FormFieldType.file) {
            buffer.write(" \\\n  -F '${f.key}=@${f.filePath}'");
          } else {
            buffer.write(" \\\n  -F '${f.key}=${f.value}'");
          }
        }
      case RawBody(contentType: final ct, content: final content):
        if (content.isNotEmpty) {
          buffer.write(' \\\n  -H "Content-Type: ${_escapeQuote(ct)}"');
          buffer.write(" \\\n  -d '${_escapeSingleQuote(content)}'");
        }
      case BinaryBody(filePath: final fp):
        buffer.write(" \\\n  --data-binary '@$fp'");
      case NoneBody():
        break;
    }

    return buffer.toString();
  }

  static String _escapeQuote(String s) => s.replaceAll('"', '\\"');
  static String _escapeSingleQuote(String s) => s.replaceAll("'", "'\\''");
}
