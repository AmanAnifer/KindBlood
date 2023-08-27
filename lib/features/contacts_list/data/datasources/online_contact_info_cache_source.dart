import '../models/online_contact_info_model.dart';
import '../../../../core/string_constants.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../core/errors/exceptions.dart';

abstract class OnlineContactInfoCacheSource {
  Future<List<OnlineContactInfoModel>> getCachedContacts();

  Future<void> cacheContacts(
      {required List<OnlineContactInfoModel> contactsList});
}

class HiveOnlineContactInfoCacheSource implements OnlineContactInfoCacheSource {
  final Box box;
  HiveOnlineContactInfoCacheSource({required this.box});
  @override
  Future<List<OnlineContactInfoModel>> getCachedContacts() async {
    if (box.containsKey(onlineContactCacheKey)) {
      List<Map<String, dynamic>> cachedContactsJsonList =
          (box.get(onlineContactCacheKey) as List<dynamic>)
              .map((e) => Map<String, dynamic>.from(e))
              .toList();

      return cachedContactsJsonList
          .map((e) => OnlineContactInfoModel.fromJson(e))
          .toList();
    } else {
      throw NoCachedContactsException();
    }
  }

  @override
  Future<void> cacheContacts(
      {required List<OnlineContactInfoModel> contactsList}) async {
    box.put(
        onlineContactCacheKey, contactsList.map((e) => e.toJson()).toList());
  }
}
