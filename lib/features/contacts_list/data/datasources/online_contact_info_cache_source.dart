import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kindblood_common/core_entities.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/string_constants.dart';
import '../models/online_contact_info_model.dart';

abstract class OnlineContactInfoCacheSource {
  Future<List<OnlineContactInfoModel>> getCachedContacts({
    required OnlineSearchInfo onlineSearchInfo,
  });

  Future<void> cacheContacts({
    required OnlineSearchInfo onlineSearchInfo,
    required List<OnlineContactInfoModel> contactsList,
  });
}

class HiveOnlineContactInfoCacheSource implements OnlineContactInfoCacheSource {
  final Box box;
  String cacheKey(OnlineSearchInfo onlineSearchInfo) {
    // Using different keys for each searchInfo since no two different ones should show same result
    // TODO: Do away with this fickle key implementation, also use actual cache storage instead of app data
    return "$onlineContactCacheKey:${sha1.convert(utf8.encode(onlineSearchInfo.toString()))}";
  }

  HiveOnlineContactInfoCacheSource({required this.box});
  @override
  Future<List<OnlineContactInfoModel>> getCachedContacts({
    required OnlineSearchInfo onlineSearchInfo,
  }) async {
    if (box.containsKey(cacheKey(onlineSearchInfo))) {
      List<Map<String, dynamic>> cachedContactsJsonList =
          (box.get(cacheKey(onlineSearchInfo)) as List<dynamic>)
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
  Future<void> cacheContacts({
    required OnlineSearchInfo onlineSearchInfo,
    required List<OnlineContactInfoModel> contactsList,
  }) async {
    box.put(cacheKey(onlineSearchInfo),
        contactsList.map((e) => e.toJson()).toList());
  }
}
