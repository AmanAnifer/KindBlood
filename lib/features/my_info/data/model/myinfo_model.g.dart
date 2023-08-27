// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'myinfo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyInfoModel _$MyInfoModelFromJson(Map json) => MyInfoModel(
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      bloodGroup: $enumDecode(_$BloodGroupEnumMap, json['bloodGroup']),
      locationCoordinates: LatLong.fromJson(json['locationCoordinates'] as Map),
      lastDonateDate: json['lastDonateDate'] == null
          ? null
          : DateTime.parse(json['lastDonateDate'] as String),
    );

Map<String, dynamic> _$MyInfoModelToJson(MyInfoModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'locationCoordinates': instance.locationCoordinates.toJson(),
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
