import 'package:kindblood/core/errors/exceptions.dart';
import 'package:kindblood/features/contacts_list/data/models/contact_info_model.dart';
import 'package:kindblood/features/contacts_list/domain/entities/contact_info.dart';
import 'package:kindblood/core/errors/failure.dart';
import 'package:fpdart/fpdart.dart';
import '../datasources/contact_info_datasource.dart';
import '../datasources/contact_info_cache_source.dart';
import '../../domain/repositories/contact_repository.dart';

class ContactInfoRepositoryImpl implements ContactInfoRepository {
  final ContactInfoDataSource contactInfoDataSource;
  final ContactInfoCacheSource contactInfoCacheSource;
  ContactInfoRepositoryImpl({
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
          contactsList: allContacts
              .map((e) => ContactInfoModel.fromContactInfo(contactInfo: e))
              .toList(),
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
