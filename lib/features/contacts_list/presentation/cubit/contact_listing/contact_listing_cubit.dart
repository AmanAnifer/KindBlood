import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kindblood/features/contacts_list/domain/usecases/get_contacts.dart';
import '../../../domain/entities/contact_info.dart';

part 'contact_listing_state.dart';

class ContactListingCubit extends Cubit<ContactListingState> {
  final GetContacts getContacts;
  ContactListingCubit({
    required this.getContacts,
  }) : super(ContactListingInitial());

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
}
