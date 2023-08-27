import '../../../../core/entities/blood_compatibility_info.dart' as bci;

import '../../../../core/entities/blood_group.dart';
import '../../../../core/entities/length_units.dart';
import '../../../../core/entities/location_entity.dart' as le;

abstract class SearchInfo {
  final BloodGroup bloodGroup;
  final le.LatLong userLocation;
  final LengthUnit maxDistance;
  final bci.BloodCompatibility bloodCompatibility;
  SearchInfo({
    required this.bloodGroup,
    required this.userLocation,
    required this.maxDistance,
    this.bloodCompatibility = const bci.Compatible(),
  });
}

class OfflineSearchInfo extends SearchInfo {
  OfflineSearchInfo({
    required super.bloodGroup,
    required super.userLocation,
    required super.maxDistance,
  });
}

class OnlineSearchInfo extends SearchInfo {
  bool? showAnonVolunteers;
  OnlineSearchInfo({
    required super.bloodGroup,
    required super.userLocation,
    required super.maxDistance,
    this.showAnonVolunteers,
  });
}
