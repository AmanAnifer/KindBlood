import '../entities/contact_info.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failure.dart';

abstract class ContactInfoRepository {
  Future<Either<Failure, List<ContactInfo>>> getAllContacts(
      {required bool fromCache});
}
