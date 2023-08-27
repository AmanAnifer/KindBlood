import 'package:fpdart/fpdart.dart';
import 'package:kindblood_common/core_entities.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/repositories/offline_contact_repository.dart';
import '../datasources/offline_contact_info_cache_source.dart';
import '../datasources/offline_contact_info_datasource.dart';

class OfflineContactInfoRepositoryImpl implements OfflineContactInfoRepository {
  final OfflineContactInfoDataSource contactInfoDataSource;
  final OfflineContactInfoCacheSource contactInfoCacheSource;
  OfflineContactInfoRepositoryImpl({
    required this.contactInfoDataSource,
    required this.contactInfoCacheSource,
  });

  @override
  Future<Either<Failure, List<ContactInfo>>> getAllContacts(
      {required bool fromCache}) async {
    try {
      final List<ContactInfo> allContacts;
      if (fromCache) {
        allContacts = await contactInfoCacheSource.getCachedContacts();
      } else {
        allContacts = await contactInfoDataSource.getAllContacts();
        contactInfoCacheSource.cacheContacts(
          contactsList: allContacts,
        );
      }
      return Right(allContacts);
    } on PermissionDeniedException {
      return Left(PermissionDeniedFailure());
    } on NoCachedContactsException {
      return Left(NoCachedContactsFailure());
    }
  }
}
