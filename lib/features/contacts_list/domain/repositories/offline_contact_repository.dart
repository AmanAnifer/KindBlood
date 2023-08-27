import '../entities/contact_info.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failure.dart';

abstract class OfflineContactInfoRepository {
  Future<Either<Failure, List<OfflineContactInfo>>> getAllContacts(
      {required bool fromCache});
}
