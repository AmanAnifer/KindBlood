import 'blood_group.dart';

class ContactInfo {
  final String? name;
  final String? phone;
  final String? locationGeohash;
  final BloodGroup? bloodGroup;
  ContactInfo({
    this.name,
    this.phone,
    this.locationGeohash,
    this.bloodGroup,
  });
}
