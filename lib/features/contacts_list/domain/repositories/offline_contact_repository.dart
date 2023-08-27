import 'package:kindblood_common/core_entities.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failure.dart';

abstract class OfflineContactInfoRepository {
  Future<Either<Failure, List<ContactInfo>>> getAllContacts(
      {required bool fromCache});
}
