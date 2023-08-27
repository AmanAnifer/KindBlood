import 'package:kindblood/core/entities/blood_group.dart';

class MyInfo {
  final String name;
  final String phoneNumber;
  final BloodGroup bloodGroup;
  final String locationGeohash;
  final DateTime? lastDonateDate;

  MyInfo({
    required this.name,
    required this.phoneNumber,
    required this.bloodGroup,
    required this.locationGeohash,
    this.lastDonateDate,
  });
}
