import 'package:kindblood/features/contacts_list/domain/entities/blood_group.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'contact_db_interface.dart';

class HiveContactDataStore implements ContactDataStore {
  final Box box;
  String contactExtraInfo = "contactExtraInfo";
  HiveContactDataStore({required this.box});

  Future<void> existsCheck() async {
    if (!box.containsKey(contactExtraInfo)) {
      box.put(contactExtraInfo, {});
    }
  }

  @override
  Future<void> storeInfo(
      {required String phoneNumber,
      BloodGroup? bloodGroup,
      String? locationGeoHash}) async {
    Map<String, dynamic> existingData = box.get(contactExtraInfo);
    existingData[phoneNumber] = {
      "bloodGroup": bloodGroup?.name,
      "locationGeoHash": locationGeoHash,
    };
    box.put(contactExtraInfo, existingData);
  }

  @override
  Future<BloodGroup?> getBloodGroup({required String phoneNumber}) async {
    await existsCheck();
    String? bloodGroupName =
        box.get(contactExtraInfo)[phoneNumber]?["bloodGroup"];
    return bloodGroupName != null
        ? BloodGroup.values.byName(bloodGroupName)
        : null;
  }

  @override
  Future<String?> getLocationGeoHash({required String phoneNumber}) async {
    await existsCheck();
    String? locationGeoHash =
        box.get(contactExtraInfo)[phoneNumber]?["locationGeoHash"];
    return locationGeoHash;
  }
}
