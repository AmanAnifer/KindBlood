import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kindblood_common/core_entities.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/string_constants.dart';

abstract class OnlineContactInfoCacheSource {
  Future<List<ContactInfo>> getCachedContacts({
    required SearchInfo searchInfo,
  });

  Future<void> cacheContacts({
    required SearchInfo searchInfo,
    required List<ContactInfo> contactsList,
  });
}

class HiveOnlineContactInfoCacheSource implements OnlineContactInfoCacheSource {
  final Box box;
  String cacheKey(SearchInfo searchInfo) {
    // Using different keys for each searchInfo since no two different ones should show same result
    // TODO: Do away with this fickle key implementation, also use actual cache storage instead of app data
    return "$onlineContactCacheKey:${sha1.convert(utf8.encode(searchInfo.toString()))}";
  }

  HiveOnlineContactInfoCacheSource({required this.box});
  @override
  Future<List<ContactInfo>> getCachedContacts({
    required SearchInfo searchInfo,
  }) async {
    if (box.containsKey(cacheKey(searchInfo))) {
      List<Map<String, dynamic>> cachedContactsJsonList =
          (box.get(cacheKey(searchInfo)) as List<dynamic>)
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
  Future<void> cacheContacts({
    required SearchInfo searchInfo,
    required List<ContactInfo> contactsList,
  }) async {
    box.put(cacheKey(searchInfo), contactsList.map((e) => e.toJson()).toList());
  }
}
