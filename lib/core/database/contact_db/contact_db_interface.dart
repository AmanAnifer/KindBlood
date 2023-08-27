import 'package:kindblood/features/contacts_list/domain/entities/blood_group.dart';

abstract class ContactDataStore {
  Future<void> storeInfo({
    required String phoneNumber,
    BloodGroup? bloodGroup,
    String? locationGeoHash,
  });
  Future<BloodGroup?> getBloodGroup({required String phoneNumber});
  Future<String?> getLocationGeoHash({required String phoneNumber});
}
