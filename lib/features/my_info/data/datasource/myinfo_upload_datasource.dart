import 'dart:convert';
import 'dart:io';

import '../../../../core/entities/app_settings.dart';
import 'package:kindblood_common/core_entities.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/success.dart';
import 'package:http/http.dart';

abstract class MyInfoUploadDatasource {
  Future<Success> uploadMyInfo({required MyInfo myInfo});
}

class HTTPMyInfoUploadDatasource implements MyInfoUploadDatasource {
  final Client httpClient;
  final AppSettings appSettings;
  HTTPMyInfoUploadDatasource({
    required this.httpClient,
    required this.appSettings,
  });
  @override
  Future<Success> uploadMyInfo({required MyInfo myInfo}) async {
    try {
      var response = await httpClient.post(
        appSettings.onlineContactsEndpointSubmit,
        body: jsonEncode(
          myInfo.toJson(),
        ),
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == HttpStatus.ok) {
        return UploadSuccessful();
      } else {
        throw NetworkException();
      }
    } on IOException {
      throw NetworkException();
    }
  }
}
