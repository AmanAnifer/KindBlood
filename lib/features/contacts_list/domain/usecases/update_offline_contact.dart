import '../../data/datasources/contact_db_datasource.dart';
import '../../../../core/entities/blood_group.dart';
import '../../../../core/entities/location_entity.dart';

class UpdateContact {
  final ContactDataStore contactDataStore;
  UpdateContact({required this.contactDataStore});

  void updateContact(
      {required String id,
      BloodGroup? bloodGroup,
      LatLong? locationCoordinates}) {
    contactDataStore.storeInfo(
        id: id,
        bloodGroup: bloodGroup,
        locationCoordinates: locationCoordinates);
  }
}
