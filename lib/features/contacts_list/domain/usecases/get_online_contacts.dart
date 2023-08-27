import '../../../../core/entities/blood_compatibility_info.dart' as bci;
import '../../../../core/entities/length_units.dart';

import '../entities/contact_info.dart';
import '../entities/search_info.dart';
import '../repositories/online_contact_repository.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failure.dart';
import 'get_blood_compatibility.dart';
import '../../../../core/entities/blood_group.dart';

class GetOnlineContacts {
  final OnlineContactInfoRepository contactInfoRepository;
  GetOnlineContacts({
    required this.contactInfoRepository,
  });

  Future<Either<Failure, List<OnlineContactInfo>>> getSearchResultContacts(
      {required OnlineSearchInfo searchInfo, required bool fromCache}) async {
    /*
    It will first honour fromCache flag but if its giving failure then
    it will try to get directly without cache 
    */
    var allContacts = await contactInfoRepository.getSearchResultContacts(
        searchInfo: searchInfo, fromCache: fromCache);
    if (allContacts.isLeft()) {
      allContacts = await contactInfoRepository.getSearchResultContacts(
          searchInfo: searchInfo, fromCache: false);
    }
    // TODO: other things like sorting, better caching?
    return allContacts;
  }
}
