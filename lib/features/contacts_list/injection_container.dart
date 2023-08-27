import 'package:kindblood/features/contacts_list/data/datasources/contact_info_datasource.dart';
import 'package:kindblood/features/contacts_list/data/repositories/contact_repository_impl.dart';
import 'package:kindblood/features/contacts_list/domain/repositories/contact_repository.dart';
import 'package:kindblood/features/contacts_list/domain/usecases/get_contacts.dart';
import 'package:kindblood/features/contacts_list/domain/usecases/update_contact.dart';
import 'package:kindblood/features/contacts_list/data/datasources/contact_db_datasource.dart';
import 'package:kindblood/features/contacts_list/data/datasources/contact_info_cache_source.dart';
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
