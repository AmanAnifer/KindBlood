import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/errors/failure.dart';
import '../../../domain/usecases/get_online_contacts.dart';
import 'package:kindblood_common/core_entities.dart';
import '../../../domain/usecases/get_offline_contacts.dart';
import '../../../domain/usecases/update_offline_contact.dart';
import 'package:kindblood_common/utils.dart';
part 'contact_listing_state.dart';

class ContactListingCubit extends Cubit<ContactListingState> {
  final GetOfflineContacts getOfflineContacts;
  final UpdateOfflineContact updateContact;
  final GetOnlineContacts getOnlineContacts;
  final MyInfo myInfo;
  ContactListingCubit({
    required this.getOfflineContacts,
    required this.updateContact,
    required this.getOnlineContacts,
    required this.myInfo,
  }) : super(ContactListingInitial());

  void populateContacts({
    required SearchFilter searchFilter,
    required SortBy sortBy,
    bool fromCache = true,
  }) async {
    // sortBy = SortBy(sortByColumn: SortByColumn.bloodGroup);
    switch (searchFilter.contactSearchMode) {
      case ContactSearchMode.offline:
        populateContactsOffline(
          searchFilter: searchFilter,
          sortBy: sortBy,
          fromCache: fromCache,
        );
        break;
      case ContactSearchMode.online:
        populateContactsOnline(
          searchFilter: searchFilter,
          sortBy: sortBy,
          fromCache: fromCache,
        );
        break;
    }
  }

  void populateContactsOffline({
    required SearchFilter searchFilter,
    required SortBy sortBy,
    required bool fromCache,
  }) async {
    emit(ContactListingLoading());
    final retrievedContacts = await getOfflineContacts.getSearchResultContacts(
        searchInfo: SearchInfo(
          userLocation: searchFilter.userLocation,
          bloodGroup: searchFilter.bloodGroup,
          maxDistance: searchFilter.maxDistance,
        ),
        fromCache: fromCache);
    retrievedContacts.fold(
      (failure) {
        emit(const ContactListingError(
            errorMessage:
                "Contacts permission denied. Please allow contacts permission"));
      },
      (contactsList) {
        var contactComparator = ContactComparator(sortBy: sortBy);
        emit(
          ContactListingSuccess(
              contactsList: contactsList
                  .map(
                    (e) => getContactInfoWithContext(
                      contact: e,
                      searchInfo: searchFilter.searchInfo,
                    ),
                  )
                  .toList()
                ..sort(contactComparator.comparator)),
        );
      },
    );
  }

  void populateContactsOnline({
    required SearchFilter searchFilter,
    required SortBy sortBy,
    required bool fromCache,
  }) async {
    emit(ContactListingLoading());
    final retrievedContacts = await getOnlineContacts.getSearchResultContacts(
        searchInfo: searchFilter.searchInfo,
        sortBy: sortBy,
        fromCache: fromCache);
    retrievedContacts.fold(
      (failure) {
        if (failure is NetworkFailure) {
          emit(const ContactListingError(
              errorMessage: "Network error, please check your network"));
        } else {
          emit(const ContactListingError(
              errorMessage: "An unknown error occurred"));
        }
      },
      (contactsList) {
        emit(
          ContactListingSuccess(
            contactsList: contactsList,
          ),
        );
      },
    );
  }

  ContactInfoWithSearchInfoContext? getContactByPhoneNumber(
      {required String phone}) {
    var localState = state;
    if (localState is ContactListingSuccess) {
      try {
        return localState.contactsList
            .firstWhere((element) => element.contactInfo.phoneNumber == phone);
      } on (StateError,) {
        return null;
      }
    } else {
      return null;
    }
  }

  void updateContactInfo(
      {required String id,
      BloodGroup? bloodGroup,
      LatLong? locationCoordinates}) {
    updateContact.updateContact(
      id: id,
      bloodGroup: bloodGroup,
      locationCoordinates: locationCoordinates,
    );
  }
}
