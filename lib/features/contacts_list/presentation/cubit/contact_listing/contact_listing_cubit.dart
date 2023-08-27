import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kindblood/core/errors/failure.dart';
import 'package:kindblood/features/contacts_list/domain/usecases/get_online_contacts.dart';
import '../../../../../core/entities/location_entity.dart';
import '../../../../../core/entities/myinfo_entity.dart';
import '../../../../../core/entities/blood_compatibility_info.dart' as bci;
import '../../../domain/entities/search_info.dart';
import '../../../domain/usecases/get_offline_contacts.dart';
import '../../../domain/usecases/update_offline_contact.dart';
import '../../../domain/entities/contact_info.dart';
import '../../../../../core/entities/blood_group.dart';
import '../../../domain/entities/search_filters.dart';
import '../../../../../core/entities/length_units.dart';
import '../../../domain/usecases/calculate_distance.dart';
import '../../../domain/usecases/get_blood_compatibility.dart';
import '../../../domain/entities/search_sorting.dart';

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
        searchInfo: OfflineSearchInfo(
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
            ).toList()
              ..sort(
                (a, b) {
                  int compareNum;
                  switch (sortBy.sortByColumn) {
                    case SortByColumn.distance:
                      if (a.distanceFromUser != null &&
                          b.distanceFromUser != null) {
                        compareNum = a.distanceFromUser!.lengthInMeters
                            .compareTo(b.distanceFromUser!.lengthInMeters);
                      } else {
                        if (a.distanceFromUser == null) {
                          compareNum = 1;
                        } else if (b.distanceFromUser == null) {
                          compareNum = -1;
                        } else {
                          compareNum = 0;
                        }
                      }
                    case SortByColumn.bloodGroup:
                      if (a.bloodCompatibility == b.bloodCompatibility) {
                        compareNum = 0;
                      } else if (a.bloodCompatibility is bci.CompatibleSame) {
                        compareNum = -1;
                      } else if (b.bloodCompatibility is bci.CompatibleSame) {
                        compareNum = 1;
                      } else if (a.bloodCompatibility
                          is bci.CompatibleButDifferent) {
                        compareNum = -1;
                      } else if (b.bloodCompatibility
                          is bci.CompatibleButDifferent) {
                        compareNum = 1;
                      } else {
                        compareNum = 0;
                      }
                  }
                  return (sortBy.order == Order.best ? 1 : -1) * compareNum;
                },
              ),
          ),
        );
      },
    );
  }

  void populateContactsOnline(
      {required SearchFilter searchFilter,
      required SortBy sortBy,
      required bool fromCache}) async {
    emit(ContactListingLoading());
    final retrievedContacts = await getOnlineContacts.getSearchResultContacts(
        searchInfo: OnlineSearchInfo(
          userLocation: searchFilter.userLocation,
          bloodGroup: searchFilter.bloodGroup,
          maxDistance: searchFilter.maxDistance,
          showAnonVolunteers: searchFilter.showAnonVolunteers,
        ),
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
