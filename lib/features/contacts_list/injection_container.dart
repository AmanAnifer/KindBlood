import 'package:kindblood/features/contacts_list/data/datasources/contact_info_datasource.dart';
import 'package:kindblood/features/contacts_list/data/repositories/contact_repository_impl.dart';
import 'package:kindblood/features/contacts_list/domain/repositories/contact_repository.dart';
import 'package:kindblood/features/contacts_list/domain/usecases/get_contacts.dart';

import 'presentation/cubit/contact_listing_cubit.dart';

import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => ContactListingCubit(getContacts: sl()));

  sl.registerLazySingleton(() => GetContacts(contactInfoRepository: sl()));
  sl.registerLazySingleton<ContactInfoRepository>(
      () => ContactInfoRepositoryImpl(contactInfoDataSource: sl()));
  sl.registerLazySingleton<ContactInfoDataSource>(
      () => ContactInfoDataSourceImpl(dataStore: sl()));
}