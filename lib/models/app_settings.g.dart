// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppSettingsImpl _$$AppSettingsImplFromJson(Map<String, dynamic> json) =>
    _$AppSettingsImpl(
      storagePath: json['storagePath'] as String,
      themeMode:
          $enumDecodeNullable(_$ThemeModeEnumMap, json['themeMode']) ??
          ThemeMode.system,
      followRedirects: json['followRedirects'] as bool? ?? false,
      timeoutSeconds: (json['timeoutSeconds'] as num?)?.toInt() ?? 30,
      verifySsl: json['verifySsl'] as bool? ?? true,
      proxyUrl: json['proxyUrl'] as String? ?? '',
      maxHistoryItems: (json['maxHistoryItems'] as num?)?.toInt() ?? 14,
      localeCode: json['localeCode'] as String? ?? 'en',
      themeSeedColor: (json['themeSeedColor'] as num?)?.toInt() ?? 0xFF2196F3,
    );

Map<String, dynamic> _$$AppSettingsImplToJson(_$AppSettingsImpl instance) =>
    <String, dynamic>{
      'storagePath': instance.storagePath,
      'themeMode': _$ThemeModeEnumMap[instance.themeMode]!,
      'followRedirects': instance.followRedirects,
      'timeoutSeconds': instance.timeoutSeconds,
      'verifySsl': instance.verifySsl,
      'proxyUrl': instance.proxyUrl,
      'maxHistoryItems': instance.maxHistoryItems,
      'localeCode': instance.localeCode,
      'themeSeedColor': instance.themeSeedColor,
    };

const _$ThemeModeEnumMap = {
  ThemeMode.system: 'system',
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
};
