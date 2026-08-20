// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NoneBodyImpl _$$NoneBodyImplFromJson(Map<String, dynamic> json) =>
    _$NoneBodyImpl($type: json['runtimeType'] as String?);

Map<String, dynamic> _$$NoneBodyImplToJson(_$NoneBodyImpl instance) =>
    <String, dynamic>{'runtimeType': instance.$type};

_$JsonBodyImpl _$$JsonBodyImplFromJson(Map<String, dynamic> json) =>
    _$JsonBodyImpl(
      raw: json['raw'] as String? ?? '',
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$JsonBodyImplToJson(_$JsonBodyImpl instance) =>
    <String, dynamic>{'raw': instance.raw, 'runtimeType': instance.$type};

_$FormDataBodyImpl _$$FormDataBodyImplFromJson(Map<String, dynamic> json) =>
    _$FormDataBodyImpl(
      fields:
          (json['fields'] as List<dynamic>?)
              ?.map((e) => FormField.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$FormDataBodyImplToJson(_$FormDataBodyImpl instance) =>
    <String, dynamic>{'fields': instance.fields, 'runtimeType': instance.$type};

_$UrlEncodedBodyImpl _$$UrlEncodedBodyImplFromJson(Map<String, dynamic> json) =>
    _$UrlEncodedBodyImpl(
      params:
          (json['params'] as List<dynamic>?)
              ?.map((e) => KeyValuePair.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$UrlEncodedBodyImplToJson(
  _$UrlEncodedBodyImpl instance,
) => <String, dynamic>{
  'params': instance.params,
  'runtimeType': instance.$type,
};

_$RawBodyImpl _$$RawBodyImplFromJson(Map<String, dynamic> json) =>
    _$RawBodyImpl(
      contentType: json['contentType'] as String? ?? 'text/plain',
      content: json['content'] as String? ?? '',
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$RawBodyImplToJson(_$RawBodyImpl instance) =>
    <String, dynamic>{
      'contentType': instance.contentType,
      'content': instance.content,
      'runtimeType': instance.$type,
    };

_$BinaryBodyImpl _$$BinaryBodyImplFromJson(Map<String, dynamic> json) =>
    _$BinaryBodyImpl(
      filePath: json['filePath'] as String? ?? '',
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$BinaryBodyImplToJson(_$BinaryBodyImpl instance) =>
    <String, dynamic>{
      'filePath': instance.filePath,
      'runtimeType': instance.$type,
    };

_$FormFieldImpl _$$FormFieldImplFromJson(Map<String, dynamic> json) =>
    _$FormFieldImpl(
      key: json['key'] as String,
      value: json['value'] as String? ?? '',
      type:
          $enumDecodeNullable(_$FormFieldTypeEnumMap, json['type']) ??
          FormFieldType.text,
      filePath: json['filePath'] as String? ?? '',
    );

Map<String, dynamic> _$$FormFieldImplToJson(_$FormFieldImpl instance) =>
    <String, dynamic>{
      'key': instance.key,
      'value': instance.value,
      'type': _$FormFieldTypeEnumMap[instance.type]!,
      'filePath': instance.filePath,
    };

const _$FormFieldTypeEnumMap = {
  FormFieldType.text: 'text',
  FormFieldType.file: 'file',
};
