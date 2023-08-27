import '../entities/search_info.dart';
import '../entities/contact_info.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failure.dart';

abstract class OnlineContactInfoRepository {
  Future<Either<Failure, List<OnlineContactInfo>>> getSearchResultContacts(
      {required OnlineSearchInfo searchInfo, required bool fromCache});
}
