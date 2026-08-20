import 'package:freezed_annotation/freezed_annotation.dart';

part 'http_response.freezed.dart';
part 'http_response.g.dart';

@freezed
class HttpResponseModel with _$HttpResponseModel {
  const factory HttpResponseModel({
    required int statusCode,
    required String statusMessage,
    @Default({}) Map<String, String> headers,
    @Default('') String body,
    @Default(0) int responseSize,
    @Default(0) int durationMs,
    @Default([]) List<ResponseCookie> cookies,
    DateTime? receivedAt,
  }) = _HttpResponseModel;

  factory HttpResponseModel.fromJson(Map<String, dynamic> json) =>
      _$HttpResponseModelFromJson(json);
}

@freezed
class ResponseCookie with _$ResponseCookie {
  const factory ResponseCookie({
    required String name,
    required String value,
    String? domain,
    String? path,
    DateTime? expires,
    @Default(false) bool httpOnly,
    @Default(false) bool secure,
  }) = _ResponseCookie;

  factory ResponseCookie.fromJson(Map<String, dynamic> json) =>
      _$ResponseCookieFromJson(json);
}
