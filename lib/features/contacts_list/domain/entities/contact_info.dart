import '../../../../core/entities/blood_group.dart';
import '../../../../core/entities/location_entity.dart';

class ContactInfo {
  final String name;
  final String phone;
  final LatLong? locationCoordinates;
  final BloodGroup? bloodGroup;
  ContactInfo({
    required this.name,
    required this.phone,
    this.locationCoordinates,
    this.bloodGroup,
  });
}
