import 'package:json_annotation/json_annotation.dart';

part 'app_settings.g.dart';

@JsonSerializable()
class AppSettings {
  final Uri onlineContactsEndpoint;
  AppSettings({
    required this.onlineContactsEndpoint,
  });

  Uri get onlineContactsEndpointSubmit =>
      Uri.parse("${onlineContactsEndpoint.toString()}/submitContact/");
  Uri get onlineContactsEndpointGet =>
      Uri.parse("${onlineContactsEndpoint.toString()}/getContact/");
  Map<String, dynamic> toJson() => _$AppSettingsToJson(this);

  factory AppSettings.fromJson(Map<String, dynamic> json) =>
      _$AppSettingsFromJson(json);
}
