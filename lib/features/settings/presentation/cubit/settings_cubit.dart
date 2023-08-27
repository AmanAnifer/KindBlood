import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kindblood/core/entities/app_settings.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kindblood/core/injection_container.dart';
import 'package:kindblood/core/string_constants.dart';
part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  AppSettings appSettings;
  SettingsCubit({required this.appSettings})
      : super(SettingsInitalized(
          serverAddress: appSettings.onlineContactsEndpoint,
        ));

  void updateServerAddress({required String url}) {
    // TODO: better separation
    Box box = sl();
    var uri = Uri.tryParse(url);
    if (uri != null) {
      appSettings = AppSettings(onlineContactsEndpoint: uri);
      box.put(appSettingsKey, appSettings.toJson());
    }
  }
}
