part of 'contact_listing_cubit.dart';

abstract class ContactListingState extends Equatable {
  const ContactListingState();

  @override
  List<Object> get props => [];
}

class ContactListingInitial extends ContactListingState {}

class ContactListingLoading extends ContactListingState {}

class ContactListingError extends ContactListingState {}

class ContactListingDenied extends ContactListingState {}

class ContactListingSuccess extends ContactListingState {
  final List<ContactInfo> contactsList;
  const ContactListingSuccess({required this.contactsList});
}
