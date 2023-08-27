import '../models/contact_info_model.dart';
import 'package:kindblood/core/string_constants.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kindblood/core/errors/exceptions.dart';

abstract class ContactInfoCacheSource {
  Future<List<ContactInfoModel>> getCachedContacts();

  Future<void> cacheContacts({required List<ContactInfoModel> contactsList});
}

class HiveContactInfoCacheSource implements ContactInfoCacheSource {
  final Box box;
  HiveContactInfoCacheSource({required this.box});
  @override
  Future<List<ContactInfoModel>> getCachedContacts() async {
    if (box.containsKey(contactCacheKey)) {
      List<Map<String, dynamic>> cachedContactsJsonList =
          (box.get(contactCacheKey) as List<dynamic>)
              .map((e) => Map<String, dynamic>.from(e))
              .toList();

      return cachedContactsJsonList
          .map((e) => ContactInfoModel.fromJson(e))
          .toList();
    } else {
      throw NoCachedContactsException();
    }
  }

  @override
  Future<void> cacheContacts(
      {required List<ContactInfoModel> contactsList}) async {
    box.put(contactCacheKey, contactsList.map((e) => e.toJson()).toList());
  }
}
