// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'myinfo_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyInfo _$MyInfoFromJson(Map<String, dynamic> json) => MyInfo(
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      locationGeohash: json['locationGeohash'] as String,
      bloodGroup: $enumDecode(_$BloodGroupEnumMap, json['bloodGroup']),
      lastDonateDate: json['lastDonateDate'] == null
          ? null
          : DateTime.parse(json['lastDonateDate'] as String),
    );

Map<String, dynamic> _$MyInfoToJson(MyInfo instance) => <String, dynamic>{
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'locationGeohash': instance.locationGeohash,
      'bloodGroup': _$BloodGroupEnumMap[instance.bloodGroup]!,
      'lastDonateDate': instance.lastDonateDate?.toIso8601String(),
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
