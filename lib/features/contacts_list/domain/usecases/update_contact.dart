import 'package:kindblood/features/contacts_list/data/datasources/contact_db_datasource.dart';
import 'package:kindblood/core/entities/blood_group.dart';

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
