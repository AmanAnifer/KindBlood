import 'package:kindblood/core/errors/exceptions.dart';
import 'package:kindblood/features/contacts_list/domain/entities/contact_info.dart';
import 'package:kindblood/core/errors/failure.dart';
import 'package:fpdart/fpdart.dart';
import '../datasources/contact_info_datasource.dart';
import '../../domain/repositories/contact_repository.dart';

class ContactInfoRepositoryImpl implements ContactInfoRepository {
  final ContactInfoDataSource contactInfoDataSource;

  ContactInfoRepositoryImpl({required this.contactInfoDataSource});

  @override
  Future<Either<Failure, List<ContactInfo>>> getAllContacts() async {
    try {
      // TODO: add contact  caching to speedup
      final allContacts = await contactInfoDataSource.getAllContacts();
      return Right(allContacts);
    } on PermissionDeniedException {
      return Left(PermissionDeniedFailure());
    }
  }
}
