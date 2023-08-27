import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kindblood/core/entities/myinfo_entity.dart';
import 'package:kindblood/features/contacts_list/domain/entities/search_info.dart';
import 'package:kindblood/features/contacts_list/domain/usecases/get_contacts.dart';
import 'package:kindblood/features/contacts_list/domain/usecases/update_contact.dart';
import '../../../domain/entities/contact_info.dart';
import '../../../../../core/entities/blood_group.dart';
import '../../../domain/entities/search_filters.dart';
import 'package:kindblood/core/entities/length_units.dart';
import 'package:kindblood/core/errors/failure.dart';
import 'package:fpdart/fpdart.dart';
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

  void populateContacts({required SearchFilter searchFilter}) async {
    switch (searchFilter.contactSearchMode) {
      case ContactSearchMode.offline:
        populateContactsOffline(searchFilter: searchFilter);
        break;
      case ContactSearchMode.online:
        populateContactsOnline(searchFilter: searchFilter);
        break;
    }
  }

  void populateContactsOffline({required SearchFilter searchFilter}) async {
    emit(ContactListingLoading());
    final retrievedContacts = await getContacts.getSearchResultContacts(
        searchInfo: OfflineSearchInfo(
      bloodGroup: searchFilter.bloodGroup,
      maxDistance: searchFilter.maxDistance,
    ));
    retrievedContacts.fold(
      (failure) {
        emit(ContactListingError());
      },
      (contactsList) {
        emit(
          ContactListingSuccess(
            contactsList: contactsList
                .map(
                  (e) => DisplayContactInfo.fromContactInfo(contactInfo: e),
                )
                .toList(),
          ),
        );
      },
    );
  }

  void populateContactsOnline({required SearchFilter searchFilter}) async {
    emit(ContactListingLoading());
    emit(const ContactListingSuccess(contactsList: []));
  }

  void updateContactInfo(
      {required String phoneNumber,
      BloodGroup? bloodGroup,
      String? locationGeoHash}) {
    updateContact.updateContact(
      phoneNumber: phoneNumber,
      bloodGroup: bloodGroup,
      locationGeoHash: locationGeoHash,
    );
  }
}
