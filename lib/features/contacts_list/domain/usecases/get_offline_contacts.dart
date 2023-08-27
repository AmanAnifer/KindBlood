import 'package:fpdart/fpdart.dart';
import 'package:kindblood_common/core_entities.dart';
import 'package:kindblood_common/utils.dart';

import '../../../../core/errors/failure.dart';
// import '../../../../core/entities/length_units.dart';
import '../repositories/offline_contact_repository.dart';

class GetOfflineContacts {
  final OfflineContactInfoRepository contactInfoRepository;
  GetOfflineContacts({
    required this.contactInfoRepository,
  });

  Future<Either<Failure, List<ContactInfo>>> getAllContacts() async {
    return contactInfoRepository.getAllContacts(fromCache: true);
  }

  Future<Either<Failure, List<ContactInfo>>> getSearchResultContacts(
      {required SearchInfo searchInfo, required bool fromCache}) async {
    /*
    It will first honour fromCache flag but if its giving failure then
    it will try to get directly without cache 
    */
    var allContacts =
        await contactInfoRepository.getAllContacts(fromCache: fromCache);
    if (allContacts.isLeft()) {
      allContacts =
          await contactInfoRepository.getAllContacts(fromCache: false);
    }
    return allContacts.fold(
      (l) => Either.left(l),
      (r) {
        final filterUtil = ContactFilterUtil();
        List<ContactInfo> filteredContacts = r
            .filter(
              (contact) => filterUtil.runAllFilters(
                contact: contact,
                searchInfo: searchInfo,
              ),
            )
            .toList();

        return Either.right(filteredContacts);
      },
    );
  }
}
