import 'dart:convert';
import 'dart:io';

import 'package:kindblood/core/entities/app_settings.dart';
import 'package:kindblood/core/entities/myinfo_entity.dart';
import 'package:kindblood/core/errors/exceptions.dart';
import 'package:kindblood/core/errors/success.dart';
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
