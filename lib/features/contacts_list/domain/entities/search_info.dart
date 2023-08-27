import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kindblood_common/core_entities.dart';

// import '../../../../core/entities/blood_group.dart';
// import '../../../../core/entities/length_units.dart';
// import '../../../../core/entities/location_entity.dart';

part 'search_info.g.dart';

sealed class SearchInfo extends Equatable {
  final BloodGroup bloodGroup;
  final LatLong userLocation;
  final LengthUnit maxDistance;
  final BloodCompatibility bloodCompatibility;
  const SearchInfo({
    required this.bloodGroup,
    required this.userLocation,
    required this.maxDistance,
    this.bloodCompatibility = const Compatible(),
  });

  // Map<String, dynamic> toJson() {
  //   return {
  //     "SearchInfo": (this).runtimeType.toString(),
  //     "bloodGroup": BloodGroupToJson(bloodGroup),
  //     "maxDistance": maxDistance.toJson(),
  //     "bloodCompatibility": bloodCompatibility.toJson(),
  //   };
  // }

  // factory SearchInfo.fromJson(Map<String, dynamic> json) {
  //   var typeString = json["SearchInfo"];
  //   switch (typeString) {
  //     case "OfflineSearchInfo":
  //       return OfflineSearchInfo(bloodGroup: bloodGroup, userLocation: userLocation, maxDistance: maxDistance);
  //     case "CompatibleButDifferent":
  //       return const CompatibleButDifferent();
  //     case "Incompatible":
  //     default:
  //       return const Incompatible();
  //   }
  // }
}

class OfflineSearchInfo extends SearchInfo {
  const OfflineSearchInfo({
    required super.bloodGroup,
    required super.userLocation,
    required super.maxDistance,
    super.bloodCompatibility,
  });

  @override
  List<Object?> get props => [
        bloodGroup,
        userLocation,
        maxDistance,
        bloodCompatibility,
      ];
}

@JsonSerializable(anyMap: true, explicitToJson: true)
class OnlineSearchInfo extends SearchInfo {
  final bool showAnonVolunteers;
  const OnlineSearchInfo({
    required super.bloodGroup,
    required super.userLocation,
    required super.maxDistance,
    super.bloodCompatibility,
    this.showAnonVolunteers = true,
  });

  factory OnlineSearchInfo.fromJson(Map<String, dynamic> json) =>
      _$OnlineSearchInfoFromJson(json);

  Map<String, dynamic> toJson() => _$OnlineSearchInfoToJson(this);

  @override
  List<Object?> get props => [
        bloodGroup,
        userLocation,
        maxDistance,
        bloodCompatibility,
        showAnonVolunteers,
      ];
}
