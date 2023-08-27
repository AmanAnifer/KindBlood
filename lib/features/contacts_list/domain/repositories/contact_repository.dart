import '../entities/contact_info.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failure.dart';
import '../entities/search_info.dart';

abstract class ContactInfoRepository {
  Either<Failure, List<ContactInfo>> getAllContacts();
  Either<Failure, List<ContactInfo>> getSearchResultContacts({
    required SearchInfo searchInfo,
  });
}
