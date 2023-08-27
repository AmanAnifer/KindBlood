// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppSettings _$AppSettingsFromJson(Map<String, dynamic> json) => AppSettings(
      onlineContactsEndpoint:
          Uri.parse(json['onlineContactsEndpoint'] as String),
    );

Map<String, dynamic> _$AppSettingsToJson(AppSettings instance) =>
    <String, dynamic>{
      'onlineContactsEndpoint': instance.onlineContactsEndpoint.toString(),
    };
