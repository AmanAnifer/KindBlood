// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'online_contact_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OnlineContactInfoModel _$OnlineContactInfoModelFromJson(Map json) =>
    OnlineContactInfoModel(
      id: json['id'] as String,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      bloodGroup: $enumDecodeNullable(_$BloodGroupEnumMap, json['bloodGroup']),
      locationCoordinates: json['locationCoordinates'] == null
          ? null
          : LatLong.fromJson(json['locationCoordinates'] as Map),
      isAnonVolunteer: json['isAnonVolunteer'] as bool?,
    );

Map<String, dynamic> _$OnlineContactInfoModelToJson(
        OnlineContactInfoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'locationCoordinates': instance.locationCoordinates?.toJson(),
      'bloodGroup': _$BloodGroupEnumMap[instance.bloodGroup],
      'isAnonVolunteer': instance.isAnonVolunteer,
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
