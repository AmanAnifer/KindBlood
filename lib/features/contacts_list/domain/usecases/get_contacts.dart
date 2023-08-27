import 'package:kindblood/core/entities/blood_compatibility_info.dart' as bci;

import '../entities/contact_info.dart';
import '../entities/search_info.dart';
import '../repositories/contact_repository.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failure.dart';
import 'get_blood_compatibility.dart';
import 'package:kindblood/core/entities/blood_group.dart';

class GetContacts {
  final ContactInfoRepository contactInfoRepository;
  GetContacts({
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
        if (searchInfo.bloodGroup == BloodGroup.Unknown) {
          return Either.right(r);
        }
        List<ContactInfo> filteredContacts = [];
        for (var contact in r) {
          if (getBloodCompatibility(
            receiver: searchInfo.bloodGroup,
            donor: contact.bloodGroup ?? BloodGroup.Unknown,
          ) is bci.Compatible) {
            filteredContacts.add(contact);
          }
        }
        return Either.right(filteredContacts);
      },
    );
  }
}
