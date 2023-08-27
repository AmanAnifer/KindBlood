import 'package:kindblood/core/database/contact_db/contact_db_interface.dart';
import 'package:kindblood/features/contacts_list/domain/entities/blood_group.dart';

class UpdateContact {
  final ContactDataStore contactDataStore;
  UpdateContact({required this.contactDataStore});

  void updateContact(
      {required String phoneNumber,
      BloodGroup? bloodGroup,
      String? locationGeoHash}) {
    contactDataStore.storeInfo(
        phoneNumber: phoneNumber,
        bloodGroup: bloodGroup,
        locationGeoHash: locationGeoHash);
  }
}
