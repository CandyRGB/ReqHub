import '../models/http_request.dart';
import '../models/key_value_pair.dart';
import '../models/request_body.dart';

/// Parses a curl command string into an [HttpRequestModel].
///
/// Handles common curl flags:
/// - `-X` / `--request` → HTTP method
/// - `-H` / `--header` → headers
/// - `-d` / `--data` / `--data-raw` / `--data-binary` → request body
/// - `-u` / `--user` → basic auth
/// - `--url` or trailing non-flag arg → URL
/// - `-G` / `--get` → force GET with data as query params
class CurlParser {
  /// Parse a raw curl command string and return a partially-filled [HttpRequestModel].
  /// The caller should set [id] and [name] after parsing.
  static HttpRequestModel parse(String curlCommand) {
    final tokens = _tokenize(curlCommand);
    if (tokens.isEmpty || tokens.first.toLowerCase() != 'curl') {
      throw FormatException('Not a valid curl command');
    }

    String method = 'GET';
    final headers = <KeyValuePair>[];
    String? bodyData;
    String? url;
    String? username;
    String? password;
    bool forceGet = false;

    for (int i = 1; i < tokens.length; i++) {
      final token = tokens[i];

      switch (token.toLowerCase()) {
        case '-x':
        case '--request':
          method = tokens[++i].toUpperCase();
          break;

        case '-h':
        case '--header':
          final raw = tokens[++i];
          final colonIndex = raw.indexOf(':');
          if (colonIndex > 0) {
            headers.add(
              KeyValuePair(
                key: raw.substring(0, colonIndex).trim(),
                value: raw.substring(colonIndex + 1).trim(),
              ),
            );
          }
          break;

        case '-d':
        case '--data':
        case '--data-raw':
        case '--data-binary':
          bodyData = _stripQuotes(tokens[++i]);
          if (method == 'GET') method = 'POST';
          break;

        case '-u':
        case '--user':
          final userPass = tokens[++i].split(':');
          username = userPass[0];
          if (userPass.length > 1) password = userPass.sublist(1).join(':');
          break;

        case '-g':
        case '--get':
          forceGet = true;
          break;

        case '--url':
          url = _stripQuotes(tokens[++i]);
          break;

        default:
          // If it doesn't look like a flag, treat it as the URL
          if (!token.startsWith('-') && url == null) {
            url = _stripQuotes(token);
          }
          break;
      }
    }

    if (forceGet) method = 'GET';

    if (url == null) {
      throw FormatException('No URL found in curl command');
    }

    // Determine body type
    RequestBody body = const RequestBody.none();
    if (bodyData != null && method != 'GET') {
      body = _inferBodyType(bodyData, headers);
    }

    // Build auth
    AuthConfig? auth;
    if (username != null) {
      auth = AuthConfig.basic(username: username, password: password ?? '');
    }

    // Check for bearer token in headers
    if (auth == null) {
      for (final h in headers) {
        if (h.key.toLowerCase() == 'authorization' &&
            h.value.toLowerCase().startsWith('bearer ')) {
          auth = AuthConfig.bearer(token: h.value.substring(7).trim());
          break;
        }
      }
    }

    return HttpRequestModel(
      id: '',
      name: _extractName(url),
      method: method,
      url: url,
      headers: headers,
      body: body,
      auth: auth ?? const AuthConfig.noAuth(),
    );
  }

  /// Tokenize keeping quoted strings together.
  static List<String> _tokenize(String command) {
    final tokens = <String>[];
    final buffer = StringBuffer();
    bool inSingle = false;
    bool inDouble = false;

    for (int i = 0; i < command.length; i++) {
      final c = command[i];

      if (inSingle) {
        if (c == "'") {
          inSingle = false;
        } else {
          buffer.write(c);
        }
      } else if (inDouble) {
        if (c == '"' && (i + 1 >= command.length || command[i + 1] != '"')) {
          inDouble = false;
        } else if (c == '"' &&
            i + 1 < command.length &&
            command[i + 1] == '"') {
          buffer.write('"');
          i++;
        } else {
          buffer.write(c);
        }
      } else {
        if (c == "'") {
          inSingle = true;
        } else if (c == '"') {
          inDouble = true;
        } else if (c == ' ' || c == '\t' || c == '\n') {
          if (buffer.isNotEmpty) {
            tokens.add(buffer.toString());
            buffer.clear();
          }
        } else {
          buffer.write(c);
        }
      }
    }
    if (buffer.isNotEmpty) tokens.add(buffer.toString());

    return tokens;
  }

  static String _stripQuotes(String s) {
    if ((s.startsWith('"') && s.endsWith('"')) ||
        (s.startsWith("'") && s.endsWith("'"))) {
      return s.substring(1, s.length - 1);
    }
    return s;
  }

  static RequestBody _inferBodyType(String data, List<KeyValuePair> headers) {
    final ct = headers
        .where((h) => h.key.toLowerCase() == 'content-type')
        .map((h) => h.value.toLowerCase())
        .firstOrNull;

    if (ct != null && ct.contains('application/x-www-form-urlencoded')) {
      final params = data.split('&').map((pair) {
        final parts = pair.split('=');
        return KeyValuePair(
          key: Uri.decodeComponent(parts[0]),
          value: parts.length > 1
              ? Uri.decodeComponent(parts.sublist(1).join('='))
              : '',
        );
      }).toList();
      return RequestBody.urlEncoded(params: params);
    }

    if (ct != null && ct.contains('multipart/form-data')) {
      // For simplicity, store as raw with the content-type
      return RequestBody.raw(contentType: ct, content: data);
    }

    // Try to detect JSON
    final trimmed = data.trim();
    if ((trimmed.startsWith('{') && trimmed.endsWith('}')) ||
        (trimmed.startsWith('[') && trimmed.endsWith(']'))) {
      return RequestBody.json(raw: trimmed);
    }

    return RequestBody.raw(contentType: ct ?? 'text/plain', content: data);
  }

  static String _extractName(String url) {
    try {
      final uri = Uri.parse(url);
      final segments = uri.pathSegments;
      if (segments.isNotEmpty) {
        return segments.last.isNotEmpty ? segments.last : uri.host;
      }
      return uri.host;
    } catch (_) {
      return url.length > 50 ? '${url.substring(0, 50)}...' : url;
    }
  }
}
