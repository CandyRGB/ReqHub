// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'http_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HttpRequestModelImpl _$$HttpRequestModelImplFromJson(
  Map<String, dynamic> json,
) => _$HttpRequestModelImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  method: json['method'] as String? ?? 'GET',
  url: json['url'] as String? ?? '',
  headers:
      (json['headers'] as List<dynamic>?)
          ?.map((e) => KeyValuePair.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  queryParams:
      (json['queryParams'] as List<dynamic>?)
          ?.map((e) => KeyValuePair.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  body: json['body'] == null
      ? const RequestBody.none()
      : RequestBody.fromJson(json['body'] as Map<String, dynamic>),
  auth: json['auth'] == null
      ? null
      : AuthConfig.fromJson(json['auth'] as Map<String, dynamic>),
  collectionId: json['collectionId'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$$HttpRequestModelImplToJson(
  _$HttpRequestModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'method': instance.method,
  'url': instance.url,
  'headers': instance.headers,
  'queryParams': instance.queryParams,
  'body': instance.body,
  'auth': instance.auth,
  'collectionId': instance.collectionId,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
};

_$BasicAuthImpl _$$BasicAuthImplFromJson(Map<String, dynamic> json) =>
    _$BasicAuthImpl(
      username: json['username'] as String? ?? '',
      password: json['password'] as String? ?? '',
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$BasicAuthImplToJson(_$BasicAuthImpl instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'runtimeType': instance.$type,
    };

_$BearerAuthImpl _$$BearerAuthImplFromJson(Map<String, dynamic> json) =>
    _$BearerAuthImpl(
      token: json['token'] as String? ?? '',
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$BearerAuthImplToJson(_$BearerAuthImpl instance) =>
    <String, dynamic>{'token': instance.token, 'runtimeType': instance.$type};

_$ApiKeyAuthImpl _$$ApiKeyAuthImplFromJson(Map<String, dynamic> json) =>
    _$ApiKeyAuthImpl(
      addTo: json['addTo'] as String? ?? 'header',
      key: json['key'] as String? ?? '',
      value: json['value'] as String? ?? '',
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ApiKeyAuthImplToJson(_$ApiKeyAuthImpl instance) =>
    <String, dynamic>{
      'addTo': instance.addTo,
      'key': instance.key,
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$NoAuthImpl _$$NoAuthImplFromJson(Map<String, dynamic> json) =>
    _$NoAuthImpl($type: json['runtimeType'] as String?);

Map<String, dynamic> _$$NoAuthImplToJson(_$NoAuthImpl instance) =>
    <String, dynamic>{'runtimeType': instance.$type};
