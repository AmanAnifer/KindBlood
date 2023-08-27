// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kindblood_note_json.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KindBloodNoteData _$KindBloodNoteDataFromJson(Map<String, dynamic> json) =>
    KindBloodNoteData(
      locationGeoHash: json['locationGeoHash'] as String?,
      bloodGroup: $enumDecodeNullable(_$BloodGroupEnumMap, json['bloodGroup']),
    );

Map<String, dynamic> _$KindBloodNoteDataToJson(KindBloodNoteData instance) =>
    <String, dynamic>{
      'locationGeoHash': instance.locationGeoHash,
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
};
