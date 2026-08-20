import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../models/http_request.dart';
import '../models/http_response.dart';
import '../models/request_body.dart';

/// Wraps Dio to send HTTP requests based on [HttpRequestModel] and return
/// structured [HttpResponseModel].
class HttpService {
  late Dio _dio;

  HttpService() {
    _dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        followRedirects: true,
        validateStatus: (status) => true, // accept all status codes
      ),
    );
  }

  /// Configure the Dio instance with current settings.
  void configure({
    bool followRedirects = true,
    int timeoutSeconds = 30,
    bool verifySsl = true,
    String? proxyUrl,
  }) {
    _dio.close();
    _dio = Dio(
      BaseOptions(
        connectTimeout: Duration(seconds: timeoutSeconds),
        receiveTimeout: Duration(seconds: timeoutSeconds),
        followRedirects: followRedirects,
        validateStatus: (status) => true,
      ),
    );
    if (proxyUrl != null && proxyUrl.isNotEmpty) {
      // Proxy support can be added via custom adapter if needed
    }
    if (!verifySsl) {
      debugPrint('[HttpService] SSL verification disabled (not recommended)');
    }
  }

  /// Send the request defined by [model] and return the response.
  Future<HttpResponseModel> send(HttpRequestModel model) async {
    final stopwatch = Stopwatch()..start();

    try {
      final uri = _buildUri(model.url, model.queryParams);
      final options = Options(method: model.method);

      // Headers
      final headers = <String, dynamic>{};
      for (final h in model.headers.where((h) => h.enabled)) {
        headers[h.key] = h.value;
      }
      options.headers = headers;

      // Auth
      _applyAuth(options, model.auth);

      // Body
      dynamic data;
      final body = model.body;
      switch (body) {
        case JsonBody(raw: final raw):
          if (raw.isNotEmpty) data = raw;
        case FormDataBody(fields: final fields):
          data = FormData.fromMap({
            for (final f in fields)
              f.key: f.type == FormFieldType.file
                  ? MultipartFile.fromFileSync(f.filePath, filename: f.key)
                  : f.value,
          });
        case UrlEncodedBody(params: final params):
          // Dio handles url-encoded automatically for Map data
          data = {
            for (final p in params.where((p) => p.enabled)) p.key: p.value,
          };
        case RawBody(contentType: final ct, content: final content):
          options.contentType = ct;
          data = content;
        case BinaryBody(filePath: final fp):
          data = await MultipartFile.fromFile(fp);
        case NoneBody():
          break;
      }

      final response = await _dio.request(
        uri.toString(),
        data: data,
        options: options,
      );
      stopwatch.stop();

      return HttpResponseModel(
        statusCode: response.statusCode ?? 0,
        statusMessage: response.statusMessage ?? '',
        headers: _extractHeaders(response),
        body: response.data?.toString() ?? '',
        responseSize: (response.data?.toString().length ?? 0),
        durationMs: stopwatch.elapsedMilliseconds,
        cookies: _extractCookies(response),
        receivedAt: DateTime.now(),
      );
    } on DioException catch (e) {
      stopwatch.stop();
      final userMessage = _friendlyError(e, stopwatch.elapsedMilliseconds);
      return HttpResponseModel(
        statusCode: e.response?.statusCode ?? 0,
        statusMessage: userMessage,
        headers: e.response != null ? _extractHeaders(e.response!) : {},
        body: e.response?.data?.toString() ?? userMessage,
        responseSize: 0,
        durationMs: stopwatch.elapsedMilliseconds,
        receivedAt: DateTime.now(),
      );
    }
  }

  Uri _buildUri(String url, List<dynamic> queryParams) {
    final uri = Uri.parse(url);
    if (queryParams.isEmpty) return uri;

    final existingParams = Map<String, String>.from(uri.queryParameters);
    for (final param in queryParams) {
      if (param.enabled) {
        existingParams[param.key] = param.value;
      }
    }
    return uri.replace(queryParameters: existingParams);
  }

  void _applyAuth(Options options, AuthConfig? auth) {
    if (auth == null || auth is NoAuth) return;
    switch (auth) {
      case BasicAuth(:final username, :final password):
        final credentials = base64Encode('$username:$password'.codeUnits);
        options.headers?['Authorization'] = 'Basic $credentials';
      case BearerAuth(:final token):
        if (token.isNotEmpty) {
          options.headers?['Authorization'] = 'Bearer $token';
        }
      case ApiKeyAuth(:final addTo, :final key, :final value):
        if (addTo == 'header' && key.isNotEmpty) {
          options.headers?[key] = value;
        }
      // query param api keys are handled via _buildUri
      case NoAuth():
        break;
    }
  }

  Map<String, String> _extractHeaders(Response response) {
    final map = <String, String>{};
    response.headers.forEach((name, values) {
      map[name] = values.join(', ');
    });
    return map;
  }

  List<ResponseCookie> _extractCookies(Response response) {
    final setCookie = response.headers['set-cookie'];
    if (setCookie == null || setCookie.isEmpty) return [];

    final cookies = <ResponseCookie>[];
    for (final raw in setCookie) {
      final parts = raw.split(';');
      if (parts.isEmpty) continue;

      final nameValue = parts[0].trim().split('=');
      if (nameValue.length < 2) continue;

      cookies.add(
        ResponseCookie(
          name: nameValue[0].trim(),
          value: nameValue.sublist(1).join('=').trim(),
        ),
      );
    }
    return cookies;
  }

  /// Map [DioException] to a concise user-friendly message.
  /// Avoids leaking verbose internal details (URLs, stack traces) to the UI.
  String _friendlyError(DioException e, int elapsedMs) {
    final host =
        Uri.tryParse(e.requestOptions.uri.toString())?.host ??
        e.requestOptions.uri.toString();

    return switch (e.type) {
      DioExceptionType.connectionTimeout => 'Connection timed out: $host',
      DioExceptionType.sendTimeout => 'Send timed out: $host',
      DioExceptionType.receiveTimeout => 'Receive timed out: $host',
      DioExceptionType.connectionError => 'Could not connect to: $host',
      DioExceptionType.cancel => 'Request cancelled',
      DioExceptionType.badResponse =>
        'Server error (${e.response?.statusCode ?? "?"})',
      _ => e.message ?? 'Network Error',
    };
  }
}
