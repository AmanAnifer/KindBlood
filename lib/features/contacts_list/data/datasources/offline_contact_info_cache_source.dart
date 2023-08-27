import '../models/offline_contact_info_model.dart';
import '../../../../core/string_constants.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../core/errors/exceptions.dart';

abstract class OfflineContactInfoCacheSource {
  Future<List<OfflineContactInfoModel>> getCachedContacts();

  Future<void> cacheContacts(
      {required List<OfflineContactInfoModel> contactsList});
}

class HiveOfflineContactInfoCacheSource
    implements OfflineContactInfoCacheSource {
  final Box box;
  HiveOfflineContactInfoCacheSource({required this.box});
  @override
  Future<List<OfflineContactInfoModel>> getCachedContacts() async {
    if (box.containsKey(contactCacheKey)) {
      List<Map<String, dynamic>> cachedContactsJsonList =
          (box.get(contactCacheKey) as List<dynamic>)
              .map((e) => Map<String, dynamic>.from(e))
              .toList();

      return cachedContactsJsonList
          .map((e) => OfflineContactInfoModel.fromJson(e))
          .toList();
    } else {
      throw NoCachedContactsException();
    }
  }

  @override
  Future<void> cacheContacts(
      {required List<OfflineContactInfoModel> contactsList}) async {
    box.put(contactCacheKey, contactsList.map((e) => e.toJson()).toList());
  }
}
