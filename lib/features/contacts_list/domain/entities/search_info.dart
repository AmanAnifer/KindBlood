import 'package:kindblood/core/entities/blood_compatibility_info.dart' as bci;

import '../../../../core/entities/blood_group.dart';
import 'package:kindblood/core/entities/length_units.dart';

abstract class SearchInfo {
  final String? locationGeohash;
  final BloodGroup bloodGroup;
  final LengthUnit? maxDistance;
  final bci.BloodCompatibility bloodCompatibility;
  SearchInfo({
    this.locationGeohash,
    required this.bloodGroup,
    this.maxDistance,
    this.bloodCompatibility = const bci.Compatible(),
  });
}

class OfflineSearchInfo extends SearchInfo {
  OfflineSearchInfo({
    required super.bloodGroup,
    super.locationGeohash,
    super.maxDistance,
  });
}

class OnlineSearchinfo extends SearchInfo {
  bool? showAnonVolunteers;
  OnlineSearchinfo({
    required super.bloodGroup,
    super.locationGeohash,
    super.maxDistance,
    this.showAnonVolunteers,
  });
}
