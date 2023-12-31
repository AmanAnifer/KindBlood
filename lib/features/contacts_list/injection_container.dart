import 'package:get_it/get_it.dart';

import 'data/datasources/offline_contact_db_datasource.dart';
import 'data/datasources/offline_contact_info_cache_source.dart';
import 'data/datasources/offline_contact_info_datasource.dart';
import 'data/datasources/online_contact_info_cache_source.dart';
import 'data/datasources/online_contact_info_datasource.dart';
import 'data/repositories/offline_contact_repository_impl.dart';
import 'data/repositories/online_contact_repository_impl.dart';
import 'domain/repositories/offline_contact_repository.dart';
import 'domain/repositories/online_contact_repository.dart';
import 'domain/usecases/get_offline_contacts.dart';
import 'domain/usecases/get_online_contacts.dart';
import 'domain/usecases/update_offline_contact.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // sl.registerLazySingleton(
  //     () => ContactListingCubit(getContacts: sl(), updateContact: sl()));
  // sl.registerFactory(() => ContactViewCubit(launchCall: sl()));

  sl.registerLazySingleton(() => UpdateOfflineContact(contactDataStore: sl()));
  sl.registerLazySingleton(
      () => GetOfflineContacts(contactInfoRepository: sl()));
  sl.registerLazySingleton<OfflineContactInfoRepository>(() =>
      OfflineContactInfoRepositoryImpl(
          contactInfoDataSource: sl(), contactInfoCacheSource: sl()));
  sl.registerLazySingleton<OfflineContactInfoDataSource>(
      () => OfflineContactInfoDataSourceImpl(dataStore: sl()));
  sl.registerLazySingleton<OfflineContactInfoCacheSource>(
      () => HiveOfflineContactInfoCacheSource(box: sl()));
  sl.registerLazySingleton<OfflineContactDataStore>(
      () => HiveOfflineContactDataStore(box: sl()));

  sl.registerSingleton<OnlineContactInfoDataSource>(
    HTTPOnlineContactInfoDataSourceImpl(
      httpClient: sl(),
      appSettings: sl(),
    ),
  );
  sl.registerLazySingleton<OnlineContactInfoCacheSource>(
      () => HiveOnlineContactInfoCacheSource(box: sl()));
  sl.registerLazySingleton<OnlineContactInfoRepository>(
    () => OnlineContactInfoRepositoryImpl(
      contactInfoDataSource: sl(),
      contactInfoCacheSource: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => GetOnlineContacts(
      contactInfoRepository: sl(),
    ),
  );
}
