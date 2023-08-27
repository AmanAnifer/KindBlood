import '../../data/datasources/contact_db_datasource.dart';
import '../../../../core/entities/blood_group.dart';
import '../../../../core/entities/location_entity.dart';

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
