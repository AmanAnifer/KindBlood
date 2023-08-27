import 'package:kindblood_common/core_entities.dart';
// import '../../../../core/entities/length_units.dart';
import '../repositories/offline_contact_repository.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failure.dart';
import 'get_blood_compatibility.dart';
// import '../../../../core/entities/blood_group.dart';
import 'calculate_distance.dart';

class GetOfflineContacts {
  final OfflineContactInfoRepository contactInfoRepository;
  GetOfflineContacts({
    required this.contactInfoRepository,
  });

  Future<Either<Failure, List<OfflineContactInfo>>> getAllContacts() async {
    return contactInfoRepository.getAllContacts(fromCache: true);
  }

  Future<Either<Failure, List<OfflineContactInfo>>> getSearchResultContacts(
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
        List<OfflineContactInfo> filteredContacts = [];

        // Bloodgroup filtering
        if (searchInfo.bloodGroup == BloodGroup.Unknown) {
          filteredContacts = r;
        } else {
          for (var contact in r) {
            if (getBloodCompatibility(
              receiver: searchInfo.bloodGroup,
              donor: contact.bloodGroup ?? BloodGroup.Unknown,
            ) is Compatible) {
              filteredContacts.add(contact);
            }
          }
        }

        // Max distance filtering
        filteredContacts = filteredContacts.filter((contact) {
          final contactLocation = contact.locationCoordinates;
          if (contactLocation == null) {
            if (searchInfo.maxDistance is InfiniteMeter) {
              // If 'within' is no limit then we want to return everything
              return true;
            } else {
              return false;
            }
          } else {
            final distance = getDistanceBetweenTwoLatLongs(
                from: searchInfo.userLocation, to: contactLocation);
            return (distance.lengthInMeters >
                        searchInfo.maxDistance.lengthInMeters &&
                    searchInfo.maxDistance is! InfiniteMeter)
                // If 'within' is no limit then we want to return everything
                ? false
                : true;
            // if (distance.lengthInMeters >
            //     searchInfo.maxDistance.lengthInMeters) {
            //   return false;
            // } else {
            //   return true;
            // }
          }
        }).toList();

        return Either.right(filteredContacts);
      },
    );
  }
}
