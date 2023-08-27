import 'dart:io';

import 'package:kindblood/core/entities/app_settings.dart';

import '../models/online_contact_info_model.dart';
import '../../../../core/errors/exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:kindblood_common/core_entities.dart';
import 'dart:convert' as convert;

typedef OnlineContactResponse = Future<List<OnlineContactInfoModel>>;

abstract class OnlineContactInfoDataSource {
  OnlineContactResponse getSearchResultContacts(
      {required OnlineSearchInfo searchInfo});
}

class HTTPOnlineContactInfoDataSourceImpl
    implements OnlineContactInfoDataSource {
  final http.Client httpClient;
  final AppSettings appSettings;
  HTTPOnlineContactInfoDataSourceImpl({
    required this.httpClient,
    required this.appSettings,
  });
  @override
  OnlineContactResponse getSearchResultContacts({
    required OnlineSearchInfo searchInfo,
  }) async {
    try {
      print(convert.jsonEncode(searchInfo.toJson()));
      // print(appSettings.onlineContactsEndpointGet);
      var response = await httpClient.post(
          appSettings.onlineContactsEndpointGet,
          body: convert.jsonEncode(searchInfo.toJson()));
      if (response.statusCode == HttpStatus.ok) {
        List<dynamic> decodedResponse = convert.jsonDecode(response.body);
        return decodedResponse.map((element) {
          var castedMap = Map<String, dynamic>.from(element);
          return OnlineContactInfoModel.fromJson(castedMap);
        }).toList();
      } else {
        throw NetworkException();
      }
    } catch (error) {
      // rethrow;
      throw NetworkException();
    }
  }
}
