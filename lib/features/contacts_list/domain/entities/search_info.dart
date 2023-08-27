import '../../../../core/entities/blood_group.dart';

class SearchInfo {
  final String? locationGeohash;
  final BloodGroup? bloodGroup;
  SearchInfo({
    this.locationGeohash,
    this.bloodGroup,
  });
}
