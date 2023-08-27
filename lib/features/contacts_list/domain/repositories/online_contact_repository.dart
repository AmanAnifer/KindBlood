import 'package:kindblood_common/core_entities.dart';

import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failure.dart';

abstract class OnlineContactInfoRepository {
  Future<Either<Failure, List<ContactInfoWithSearchInfoContext>>>
      getSearchResultContacts({
    required SearchInfo searchInfo,
    required SortBy sortBy,
    required bool fromCache,
  });
}
