import 'package:hive_flutter/hive_flutter.dart';
import 'package:get_it/get_it.dart';
import '../features/contacts_list/data/datasources/contact_db_datasource.dart';
import 'platform/launch_call_interface.dart';
import 'platform/launch_call_impl.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await Hive.initFlutter();
  String boxName = "blood_loc_db";
  var box = await Hive.openBox(boxName);
  sl.registerLazySingleton<ContactDataStore>(
      () => HiveContactDataStore(box: box));
  sl.registerLazySingleton<LaunchCall>(() => URLLauncherLaunchCall());
}
