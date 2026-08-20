// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'http_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HttpResponseModelImpl _$$HttpResponseModelImplFromJson(
  Map<String, dynamic> json,
) => _$HttpResponseModelImpl(
  statusCode: (json['statusCode'] as num).toInt(),
  statusMessage: json['statusMessage'] as String,
  headers:
      (json['headers'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ) ??
      const {},
  body: json['body'] as String? ?? '',
  responseSize: (json['responseSize'] as num?)?.toInt() ?? 0,
  durationMs: (json['durationMs'] as num?)?.toInt() ?? 0,
  cookies:
      (json['cookies'] as List<dynamic>?)
          ?.map((e) => ResponseCookie.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  receivedAt: json['receivedAt'] == null
      ? null
      : DateTime.parse(json['receivedAt'] as String),
);

Map<String, dynamic> _$$HttpResponseModelImplToJson(
  _$HttpResponseModelImpl instance,
) => <String, dynamic>{
  'statusCode': instance.statusCode,
  'statusMessage': instance.statusMessage,
  'headers': instance.headers,
  'body': instance.body,
  'responseSize': instance.responseSize,
  'durationMs': instance.durationMs,
  'cookies': instance.cookies,
  'receivedAt': instance.receivedAt?.toIso8601String(),
};

_$ResponseCookieImpl _$$ResponseCookieImplFromJson(Map<String, dynamic> json) =>
    _$ResponseCookieImpl(
      name: json['name'] as String,
      value: json['value'] as String,
      domain: json['domain'] as String?,
      path: json['path'] as String?,
      expires: json['expires'] == null
          ? null
          : DateTime.parse(json['expires'] as String),
      httpOnly: json['httpOnly'] as bool? ?? false,
      secure: json['secure'] as bool? ?? false,
    );

Map<String, dynamic> _$$ResponseCookieImplToJson(
  _$ResponseCookieImpl instance,
) => <String, dynamic>{
  'name': instance.name,
  'value': instance.value,
  'domain': instance.domain,
  'path': instance.path,
  'expires': instance.expires?.toIso8601String(),
  'httpOnly': instance.httpOnly,
  'secure': instance.secure,
};
