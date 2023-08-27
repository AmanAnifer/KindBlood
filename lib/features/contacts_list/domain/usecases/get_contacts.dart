import '../entities/contact_info.dart';
import '../entities/search_info.dart';
import '../repositories/contact_repository.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failure.dart';

class GetContacts {
  final ContactInfoRepository contactInfoRepository;
  GetContacts({
    required this.contactInfoRepository,
  });

  Future<Either<Failure, List<ContactInfo>>> getAllContacts() async {
    return contactInfoRepository.getAllContacts();
  }

  Future<Either<Failure, List<ContactInfo>>> getSearchResultContacts(
      {required SearchInfo searchInfo}) async {
    return contactInfoRepository.getAllContacts();
  }
}
