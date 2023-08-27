import 'package:kindblood/core/entities/blood_compatibility_info.dart';
import 'package:kindblood/core/entities/blood_group.dart';
import 'package:kindblood/core/entities/length_units.dart';

enum ContactSearchMode { offline, online }

class SearchFilter {
  final ContactSearchMode contactSearchMode;
  final BloodGroup bloodGroup;
  final LengthUnit? maxDistance;
  final bool? showAnonVolunteers;
  final BloodCompatibility? bloodCompatibility;
  SearchFilter(
      {required this.contactSearchMode,
      required this.bloodGroup,
      this.maxDistance,
      this.showAnonVolunteers,
      this.bloodCompatibility});
  SearchFilter copyWith({
    ContactSearchMode? contactSearchMode,
    BloodGroup? bloodGroup,
    LengthUnit? maxDistance,
    bool? showAnonVolunteers,
  }) {
    return SearchFilter(
        contactSearchMode: contactSearchMode ?? this.contactSearchMode,
        bloodGroup: bloodGroup ?? this.bloodGroup,
        maxDistance: maxDistance ?? this.maxDistance,
        showAnonVolunteers: showAnonVolunteers ?? this.showAnonVolunteers);
  }
}

// class OfflineFilter implements SearchFilter {
//   @override
//   final BloodGroup? bloodGroup;
//   @override
//   final double? maxDistanceInMeters;
//   const OfflineFilter({
//     this.bloodGroup,
//     this.maxDistanceInMeters,
//   });
// }

// class OnlineFilter implements SearchFilter {
//   @override
//   final BloodGroup? bloodGroup;
//   @override
//   final double? maxDistanceInMeters;
//   final bool? showAnonVolunteers;

//   OnlineFilter({
//     this.bloodGroup,
//     this.maxDistanceInMeters,
//     this.showAnonVolunteers,
//   });
// }
