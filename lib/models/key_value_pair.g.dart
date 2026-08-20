// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'key_value_pair.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$KeyValuePairImpl _$$KeyValuePairImplFromJson(Map<String, dynamic> json) =>
    _$KeyValuePairImpl(
      key: json['key'] as String,
      value: json['value'] as String,
      enabled: json['enabled'] as bool? ?? false,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$KeyValuePairImplToJson(_$KeyValuePairImpl instance) =>
    <String, dynamic>{
      'key': instance.key,
      'value': instance.value,
      'enabled': instance.enabled,
      'description': instance.description,
    };
