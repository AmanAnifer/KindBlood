// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OnlineSearchInfo _$OnlineSearchInfoFromJson(Map json) => OnlineSearchInfo(
      bloodGroup: $enumDecode(_$BloodGroupEnumMap, json['bloodGroup']),
      userLocation: LatLong.fromJson(json['userLocation'] as Map),
      maxDistance: LengthUnit.fromJson(
          Map<String, dynamic>.from(json['maxDistance'] as Map)),
      bloodCompatibility: json['bloodCompatibility'] == null
          ? const Compatible()
          : BloodCompatibility.fromJson(
              Map<String, dynamic>.from(json['bloodCompatibility'] as Map)),
      showAnonVolunteers: json['showAnonVolunteers'] as bool? ?? true,
    );

Map<String, dynamic> _$OnlineSearchInfoToJson(OnlineSearchInfo instance) =>
    <String, dynamic>{
      'bloodGroup': _$BloodGroupEnumMap[instance.bloodGroup]!,
      'userLocation': instance.userLocation.toJson(),
      'maxDistance': instance.maxDistance.toJson(),
      'bloodCompatibility': instance.bloodCompatibility.toJson(),
      'showAnonVolunteers': instance.showAnonVolunteers,
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
