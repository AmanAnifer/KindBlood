// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offline_contact_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfflineContactInfoModel _$OfflineContactInfoModelFromJson(Map json) =>
    OfflineContactInfoModel(
      id: json['id'] as String,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      bloodGroup: $enumDecodeNullable(_$BloodGroupEnumMap, json['bloodGroup']),
      locationCoordinates: json['locationCoordinates'] == null
          ? null
          : LatLong.fromJson(json['locationCoordinates'] as Map),
    );

Map<String, dynamic> _$OfflineContactInfoModelToJson(
        OfflineContactInfoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'locationCoordinates': instance.locationCoordinates?.toJson(),
      'bloodGroup': _$BloodGroupEnumMap[instance.bloodGroup],
    };

const _$BloodGroupEnumMap = {
  BloodGroup.APositive: 'APositive',
  BloodGroup.ANegative: 'ANegative',
  BloodGroup.ABPositive: 'ABPositive',
  BloodGroup.ABNegative: 'ABNegative',
  BloodGroup.BPositive: 'BPositive',
  BloodGroup.BNegative: 'BNegative',
  BloodGroup.OPositive: 'OPositive',
  BloodGroup.ONegative: 'ONegative',
  BloodGroup.Other: 'Other',
  BloodGroup.Unknown: 'Unknown',
};
