import 'package:freezed_annotation/freezed_annotation.dart';
import 'key_value_pair.dart';
import 'request_body.dart';

part 'http_request.freezed.dart';
part 'http_request.g.dart';

@freezed
class HttpRequestModel with _$HttpRequestModel {
  const factory HttpRequestModel({
    required String id,
    required String name,
    @Default('GET') String method,
    @Default('') String url,
    @Default([]) List<KeyValuePair> headers,
    @Default([]) List<KeyValuePair> queryParams,
    @Default(RequestBody.none()) RequestBody body,
    AuthConfig? auth,
    String? collectionId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _HttpRequestModel;

  factory HttpRequestModel.fromJson(Map<String, dynamic> json) =>
      _$HttpRequestModelFromJson(json);
}

@freezed
class AuthConfig with _$AuthConfig {
  const factory AuthConfig.basic({
    @Default('') String username,
    @Default('') String password,
  }) = BasicAuth;

  const factory AuthConfig.bearer({@Default('') String token}) = BearerAuth;

  const factory AuthConfig.apiKey({
    @Default('header') String addTo, // header or query
    @Default('') String key,
    @Default('') String value,
  }) = ApiKeyAuth;

  const factory AuthConfig.noAuth() = NoAuth;

  factory AuthConfig.fromJson(Map<String, dynamic> json) =>
      _$AuthConfigFromJson(json);
}
