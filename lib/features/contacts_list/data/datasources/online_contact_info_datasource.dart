import 'dart:io';

import '../../../../core/entities/app_settings.dart';

import '../../../../core/errors/exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:kindblood_common/core_entities.dart';
import 'package:kindblood_common/constants.dart';

import 'dart:convert' as convert;

typedef OnlineContactResponse = Future<List<ContactInfoWithSearchInfoContext>>;

// Server will already return ContactInfoWithSearchInfoContext, so no need
// convert again
abstract class OnlineContactInfoDataSource {
  OnlineContactResponse getSearchResultContacts({
    required SearchInfo searchInfo,
    required SortBy sortBy,
  });
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
    required SearchInfo searchInfo,
    required SortBy sortBy,
  }) async {
    try {
      Map<String, dynamic> mergedMap = {
        JsonKeys.searchInfoJsonKey: searchInfo.toJson(),
        JsonKeys.sortByJsonKey: sortBy.toJson(),
      };
      // print(convert.jsonEncode(mergedMap));
      // print(appSettings.onlineContactsEndpointGet);
      var response = await httpClient.post(
          appSettings.onlineContactsEndpointGet,
          body: convert.jsonEncode(mergedMap));
      if (response.statusCode == HttpStatus.ok) {
        List<dynamic> decodedResponse = convert.jsonDecode(response.body);
        // print(decodedResponse);
        return decodedResponse.map((element) {
          var castedMap = Map<String, dynamic>.from(element);
          return ContactInfoWithSearchInfoContext.fromJson(castedMap);
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
