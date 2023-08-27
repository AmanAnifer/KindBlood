import 'package:hive_flutter/hive_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:kindblood/core/cubit/my_info_cubit.dart';
import 'platform/launch_call_interface.dart';
import 'platform/launch_call_impl.dart';
import 'string_constants.dart' as strings;
import 'package:kindblood_common/core_entities.dart';
import 'entities/app_settings.dart';
import 'package:http/http.dart' as http;

MyInfo? getMyInfo() {
  MyInfo? myInfo;
  try {
    myInfo = sl();
  } catch (error) {
    myInfo = null;
  }
  return myInfo;
}

final sl = GetIt.instance;
// typedef EitherMyInfoOrFailure = Either<NoExistingMyInfoFailure, MyInfo>;
Future<void> init() async {
  await Hive.initFlutter();
  String boxName = "kindblood_db";
  var box = await Hive.openBox(boxName);
  sl.registerLazySingleton(() => box);
  var myInfoJson = box.get(strings.myInfoDBKey);
  if (myInfoJson != null) {
    final castedMyInfo = Map<String, dynamic>.from(myInfoJson);
    sl.registerSingleton<MyInfo>(MyInfo.fromJson(castedMyInfo));
  }
  sl.registerSingleton<MyInfoCubit>(MyInfoCubit(myInfo: getMyInfo()));

  sl.registerFactory<AppSettings>(
    () {
      final appSettingsJson = box.get(strings.appSettingsKey);

      if (appSettingsJson == null) {
        return AppSettings(
            onlineContactsEndpoint: Uri.http("192.168.240.1:8100"));
      } else {
        var appSettingsCasted = Map<String, dynamic>.from(appSettingsJson);
        return AppSettings.fromJson(appSettingsCasted);
      }
    },
  );
  sl.registerLazySingleton<http.Client>(() => http.Client());
  // sl.registerFactory<EitherMyInfoOrFailure>(
  //   () {
  //     var myInfoJson = box.get(myInfoDBKey);
  //     EitherMyInfoOrFailure myInfoOrFailure;
  //     if (myInfoJson == null) {
  //       myInfoOrFailure = Either.left(NoExistingMyInfoFailure());
  //     } else {
  //       var castedMyInfo = Map<String, dynamic>.from(myInfoJson);
  //       myInfoOrFailure = Either.right(MyInfo.fromJson(castedMyInfo));
  //     }
  //     return myInfoOrFailure;
  //   },
  // );
  sl.registerLazySingleton<LaunchCall>(() => URLLauncherLaunchCall());
}
