import 'package:hive_flutter/hive_flutter.dart';
import 'package:get_it/get_it.dart';
import 'platform/launch_call_interface.dart';
import 'platform/launch_call_impl.dart';
import 'string_constants.dart';
import 'entities/myinfo_entity.dart';

final sl = GetIt.instance;
// typedef EitherMyInfoOrFailure = Either<NoExistingMyInfoFailure, MyInfo>;
Future<void> init() async {
  await Hive.initFlutter();
  String boxName = "kindblood_db";
  var box = await Hive.openBox(boxName);
  sl.registerLazySingleton(() => box);
  var myInfoJson = box.get(myInfoDBKey);
  if (myInfoJson != null) {
    final castedMyInfo = Map<String, dynamic>.from(myInfoJson);
    sl.registerSingleton<MyInfo>(MyInfo.fromJson(castedMyInfo));
  }

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
