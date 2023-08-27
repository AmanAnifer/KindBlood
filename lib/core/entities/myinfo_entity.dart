import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'blood_group.dart';
import 'location_entity.dart';

part 'myinfo_entity.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class MyInfo extends Equatable {
  final String name;
  final String phoneNumber;
  final LatLong locationCoordinates;
  final BloodGroup bloodGroup;
  final DateTime? lastDonateDate;
  const MyInfo({
    required this.name,
    required this.phoneNumber,
    required this.locationCoordinates,
    required this.bloodGroup,
    this.lastDonateDate,
  });

  factory MyInfo.fromJson(Map<String, dynamic> json) => _$MyInfoFromJson(json);

  Map<String, dynamic> toJson() => _$MyInfoToJson(this);

  @override
  List<Object?> get props =>
      [name, phoneNumber, locationCoordinates, bloodGroup, lastDonateDate];
}
