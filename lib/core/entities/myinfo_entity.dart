import 'blood_group.dart';
import 'package:json_annotation/json_annotation.dart';
part 'myinfo_entity.g.dart';

@JsonSerializable()
class MyInfo {
  final String name;
  final String phoneNumber;
  final String locationGeohash;
  final BloodGroup bloodGroup;
  final DateTime? lastDonateDate;
  MyInfo({
    required this.name,
    required this.phoneNumber,
    required this.locationGeohash,
    required this.bloodGroup,
    this.lastDonateDate,
  });

  factory MyInfo.fromJson(Map<String, dynamic> json) => _$MyInfoFromJson(json);

  Map<String, dynamic> toJson() => _$MyInfoToJson(this);
}
