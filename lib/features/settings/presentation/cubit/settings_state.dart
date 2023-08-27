part of 'settings_cubit.dart';

sealed class SettingsState {}

class SettingsInitalized implements SettingsState {
  final Uri serverAddress;
  SettingsInitalized({required this.serverAddress});
}
