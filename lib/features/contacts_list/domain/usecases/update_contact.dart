import 'package:kindblood/features/contacts_list/data/datasources/contact_db_datasource.dart';
import 'package:kindblood/core/entities/blood_group.dart';
import 'package:kindblood/core/entities/location_entity.dart';

class UpdateContact {
  final ContactDataStore contactDataStore;
  UpdateContact({required this.contactDataStore});

  void updateContact(
      {required String phoneNumber,
      BloodGroup? bloodGroup,
      LatLong? locationCoordinates}) {
    contactDataStore.storeInfo(
        phoneNumber: phoneNumber,
        bloodGroup: bloodGroup,
        locationCoordinates: locationCoordinates);
  }
}
