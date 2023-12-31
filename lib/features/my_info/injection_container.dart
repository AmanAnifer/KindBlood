import 'package:get_it/get_it.dart';

import 'data/datasource/myinfo_db_datasource.dart';
import 'data/datasource/myinfo_upload_datasource.dart';
import 'data/repositories/myinfo_repository_impl.dart';
import 'domain/repositories/myinfo_repository.dart';
import 'domain/usecases/myinfo_usecase.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<MyInfoDBDatasource>(
      () => HiveMyInfoDBDatasource(box: sl()));
  sl.registerLazySingleton<MyInfoUploadDatasource>(
      () => HTTPMyInfoUploadDatasource(httpClient: sl(), appSettings: sl()));
  sl.registerLazySingleton<MyInfoRepository>(() => MyInfoRepositoryImpl(
      myInfoDBDatasource: sl(), myInfoUploadDatasource: sl()));
  sl.registerLazySingleton(() => MyInfoUsecase(myInfoRepository: sl()));
}
