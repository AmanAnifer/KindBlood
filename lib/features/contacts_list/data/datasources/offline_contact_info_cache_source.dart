import '../../../../core/string_constants.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../core/errors/exceptions.dart';
import 'package:kindblood_common/core_entities.dart';

abstract class OfflineContactInfoCacheSource {
  Future<List<ContactInfo>> getCachedContacts();

  Future<void> cacheContacts({required List<ContactInfo> contactsList});
}

class HiveOfflineContactInfoCacheSource
    implements OfflineContactInfoCacheSource {
  final Box box;
  HiveOfflineContactInfoCacheSource({required this.box});
  @override
  Future<List<ContactInfo>> getCachedContacts() async {
    if (box.containsKey(offlineContactCacheKey)) {
      List<Map<String, dynamic>> cachedContactsJsonList =
          (box.get(offlineContactCacheKey) as List<dynamic>)
              .map((e) => Map<String, dynamic>.from(e))
              .toList();

      return cachedContactsJsonList
          .map((e) => ContactInfo.fromJson(e))
          .toList();
    } else {
      throw NoCachedContactsException();
    }
  }

  @override
  Future<void> cacheContacts({required List<ContactInfo> contactsList}) async {
    box.put(
        offlineContactCacheKey, contactsList.map((e) => e.toJson()).toList());
  }
}
