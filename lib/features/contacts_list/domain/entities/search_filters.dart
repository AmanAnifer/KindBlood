import 'package:kindblood/core/entities/blood_compatibility_info.dart';
import 'package:kindblood/core/entities/blood_group.dart';
import 'package:kindblood/core/entities/length_units.dart';
import 'package:kindblood/core/entities/location_entity.dart';

enum ContactSearchMode { offline, online }

class SearchFilter {
  final ContactSearchMode contactSearchMode;
  final BloodGroup bloodGroup;
  final LatLong userLocation;
  final LengthUnit maxDistance;
  final bool? showAnonVolunteers;
  final BloodCompatibility? bloodCompatibility;
  SearchFilter(
      {required this.contactSearchMode,
      required this.bloodGroup,
      required this.userLocation,
      required this.maxDistance,
      this.showAnonVolunteers,
      this.bloodCompatibility});
  SearchFilter copyWith({
    ContactSearchMode? contactSearchMode,
    BloodGroup? bloodGroup,
    LatLong? userLocation,
    LengthUnit? maxDistance,
    bool? showAnonVolunteers,
  }) {
    return SearchFilter(
        contactSearchMode: contactSearchMode ?? this.contactSearchMode,
        bloodGroup: bloodGroup ?? this.bloodGroup,
        userLocation: userLocation ?? this.userLocation,
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
