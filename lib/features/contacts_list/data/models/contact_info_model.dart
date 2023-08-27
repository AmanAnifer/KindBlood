import '../../domain/entities/contact_info.dart';

class ContactInfoModel extends ContactInfo {
  ContactInfoModel({
    super.name,
    required super.phone,
    super.bloodGroup,
    super.locationGeohash,
  });
}
