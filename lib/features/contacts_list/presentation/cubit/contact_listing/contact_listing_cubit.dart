import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kindblood/features/contacts_list/domain/usecases/get_contacts.dart';
import 'package:kindblood/features/contacts_list/domain/usecases/update_contact.dart';
import '../../../domain/entities/contact_info.dart';
import '../../../domain/entities/blood_group.dart';
part 'contact_listing_state.dart';

class ContactListingCubit extends Cubit<ContactListingState> {
  final GetContacts getContacts;
  final UpdateContact updateContact;
  ContactListingCubit({required this.getContacts, required this.updateContact})
      : super(ContactListingInitial());

  void populateContacts() async {
    emit(ContactListingLoading());
    final retrievedContacts = await getContacts.getAllContacts();
    retrievedContacts.fold(
      (failure) {
        emit(ContactListingError());
      },
      (contactsList) {
        emit(
          ContactListingSuccess(
            contactsList: contactsList
                .map(
                  (e) => DisplayContactInfo.fromContactInfo(e),
                )
                .toList(),
          ),
        );
      },
    );
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
