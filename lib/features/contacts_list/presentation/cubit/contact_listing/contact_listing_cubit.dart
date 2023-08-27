import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/entities/location_entity.dart';
import '../../../../../core/entities/myinfo_entity.dart';
import '../../../../../core/entities/blood_compatibility_info.dart' as bci;
import '../../../domain/entities/search_info.dart';
import '../../../domain/usecases/get_contacts.dart';
import '../../../domain/usecases/update_contact.dart';
import '../../../domain/entities/contact_info.dart';
import '../../../../../core/entities/blood_group.dart';
import '../../../domain/entities/search_filters.dart';
import '../../../../../core/entities/length_units.dart';
import '../../../domain/usecases/calculate_distance.dart';
import '../../../domain/usecases/get_blood_compatibility.dart';
part 'contact_listing_state.dart';

class ContactListingCubit extends Cubit<ContactListingState> {
  final GetContacts getContacts;
  final UpdateContact updateContact;
  final MyInfo myInfo;
  ContactListingCubit({
    required this.getContacts,
    required this.updateContact,
    required this.myInfo,
  }) : super(ContactListingInitial());

  void populateContacts(
      {required SearchFilter searchFilter, bool fromCache = true}) async {
    switch (searchFilter.contactSearchMode) {
      case ContactSearchMode.offline:
        populateContactsOffline(
          searchFilter: searchFilter,
          fromCache: fromCache,
        );
        break;
      case ContactSearchMode.online:
        populateContactsOnline(
          searchFilter: searchFilter,
          fromCache: fromCache,
        );
        break;
    }
  }

  void populateContactsOffline(
      {required SearchFilter searchFilter, required bool fromCache}) async {
    emit(ContactListingLoading());
    final retrievedContacts = await getContacts.getSearchResultContacts(
        searchInfo: OfflineSearchInfo(
          userLocation: searchFilter.userLocation,
          bloodGroup: searchFilter.bloodGroup,
          maxDistance: searchFilter.maxDistance,
        ),
        fromCache: fromCache);
    retrievedContacts.fold(
      (failure) {
        emit(ContactListingError());
      },
      (contactsList) {
        emit(
          ContactListingSuccess(
            contactsList: contactsList.map(
              (e) {
                LengthUnit? distance;
                bci.BloodCompatibility? bloodCompatibility;
                if (e.locationCoordinates != null) {
                  distance = getDistanceBetweenTwoLatLongs(
                    from: searchFilter.userLocation,
                    to: e.locationCoordinates!,
                  );
                }
                if (e.bloodGroup != null) {
                  bloodCompatibility = getBloodCompatibility(
                    receiver: searchFilter.bloodGroup,
                    donor: e.bloodGroup!,
                  );
                }

                return DisplayContactInfo.fromContactInfo(
                  contactInfo: e,
                  distanceFromUser: distance,
                  bloodCompatibility: bloodCompatibility,
                );
              },
            ).toList(),
          ),
        );
      },
    );
  }

  void populateContactsOnline(
      {required SearchFilter searchFilter, required bool fromCache}) async {
    emit(ContactListingLoading());
    emit(const ContactListingSuccess(contactsList: []));
  }

  DisplayContactInfo? getContactByPhoneNumber({required String phone}) {
    var localState = state;
    if (localState is ContactListingSuccess) {
      try {
        return localState.contactsList
            .firstWhere((element) => element.phone == phone);
      } on (StateError,) {
        return null;
      }
    } else {
      return null;
    }
  }

  void updateContactInfo(
      {required String phoneNumber,
      BloodGroup? bloodGroup,
      LatLong? locationCoordinates}) {
    updateContact.updateContact(
      phoneNumber: phoneNumber,
      bloodGroup: bloodGroup,
      locationCoordinates: locationCoordinates,
    );
  }
}
