import 'blood_group.dart';
import 'package:json_annotation/json_annotation.dart';
import 'location_entity.dart';
part 'myinfo_entity.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class MyInfo {
  final String name;
  final String phoneNumber;
  final LatLong locationCoordinates;
  final BloodGroup bloodGroup;
  final DateTime? lastDonateDate;
  MyInfo({
    required this.name,
    required this.phoneNumber,
    required this.locationCoordinates,
    required this.bloodGroup,
    this.lastDonateDate,
  });

  factory MyInfo.fromJson(Map<String, dynamic> json) => _$MyInfoFromJson(json);

  Map<String, dynamic> toJson() => _$MyInfoToJson(this);
}
