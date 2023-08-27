import 'blood_group.dart';

class ContactInfo {
  final String name;
  final String phone;
  final String? locationGeohash;
  final BloodGroup? bloodGroup;
  ContactInfo({
    required this.name,
    required this.phone,
    this.locationGeohash,
    this.bloodGroup,
  });
}
