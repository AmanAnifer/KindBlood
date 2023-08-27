import 'data/datasources/contact_info_datasource.dart';
import 'data/repositories/contact_repository_impl.dart';
import 'domain/repositories/contact_repository.dart';
import 'domain/usecases/get_offline_contacts.dart';
import 'domain/usecases/update_offline_contact.dart';
import 'data/datasources/contact_db_datasource.dart';
import 'data/datasources/contact_info_cache_source.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // sl.registerLazySingleton(
  //     () => ContactListingCubit(getContacts: sl(), updateContact: sl()));
  // sl.registerFactory(() => ContactViewCubit(launchCall: sl()));

  sl.registerLazySingleton(() => UpdateContact(contactDataStore: sl()));
  sl.registerLazySingleton(() => GetContacts(contactInfoRepository: sl()));
  sl.registerLazySingleton<ContactInfoRepository>(() =>
      ContactInfoRepositoryImpl(
          contactInfoDataSource: sl(), contactInfoCacheSource: sl()));
  sl.registerLazySingleton<ContactInfoDataSource>(
      () => ContactInfoDataSourceImpl(dataStore: sl()));
  sl.registerLazySingleton<ContactInfoCacheSource>(
      () => HiveContactInfoCacheSource(box: sl()));
  sl.registerLazySingleton<ContactDataStore>(
      () => HiveContactDataStore(box: sl()));
}
