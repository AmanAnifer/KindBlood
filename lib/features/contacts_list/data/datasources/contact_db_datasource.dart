import '../../../../core/entities/blood_group.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../core/utils/phone_number_normalise.dart';
import '../../../../core/string_constants.dart';
import '../../../../core/entities/location_entity.dart';

abstract class ContactDataStore {
  Future<void> storeInfo({
    required String phoneNumber,
    BloodGroup? bloodGroup,
    LatLong? locationCoordinates,
  });
  Future<BloodGroup?> getBloodGroup({required String phoneNumber});
  Future<LatLong?> getLocationCoordinates({required String phoneNumber});
}

class HiveContactDataStore implements ContactDataStore {
  final Box box;

  HiveContactDataStore({required this.box});

  Future<void> existsCheck() async {
    if (!box.containsKey(contactExtraInfo)) {
      box.put(contactExtraInfo, {});
    }
  }

  @override
  Future<void> storeInfo({
    required String phoneNumber,
    BloodGroup? bloodGroup,
    LatLong? locationCoordinates,
  }) async {
    Map<dynamic, dynamic> existingData = box.get(contactExtraInfo);
    existingData[getNormalisedPhoneNumber(phoneNumber: phoneNumber)] = {
      "bloodGroup": bloodGroup?.name,
      "locationCoordinates": locationCoordinates?.toJson(),
    };
    box.put(contactExtraInfo, existingData);
  }

  @override
  Future<BloodGroup?> getBloodGroup({required String phoneNumber}) async {
    await existsCheck();
    String? bloodGroupName = box.get(contactExtraInfo)[
        getNormalisedPhoneNumber(phoneNumber: phoneNumber)]?["bloodGroup"];
    return bloodGroupName != null
        ? BloodGroup.values.byName(bloodGroupName)
        : null;
  }

  @override
  Future<LatLong?> getLocationCoordinates({required String phoneNumber}) async {
    await existsCheck();
    var json = box.get(contactExtraInfo)[
            getNormalisedPhoneNumber(phoneNumber: phoneNumber)]
        ?["locationCoordinates"];
    LatLong? locationCoordinates;
    if (json != null) {
      locationCoordinates = LatLong.fromJson(json);
    }
    return locationCoordinates;
  }
}
