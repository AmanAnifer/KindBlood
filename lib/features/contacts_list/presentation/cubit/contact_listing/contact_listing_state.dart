part of 'contact_listing_cubit.dart';

class DisplayContactInfo extends ContactInfo {
  final LengthUnit? distanceFromUser;
  DisplayContactInfo({
    required super.name,
    required super.phone,
    super.bloodGroup,
    super.locationGeohash,
    this.distanceFromUser,
  });
  factory DisplayContactInfo.fromContactInfo({
    required ContactInfo contactInfo,
    LengthUnit? distanceFromUser,
  }) {
    return DisplayContactInfo(
      name: contactInfo.name,
      phone: contactInfo.phone,
      bloodGroup: contactInfo.bloodGroup,
      locationGeohash: contactInfo.locationGeohash,
      distanceFromUser: distanceFromUser,
    );
  }
}

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
  final List<DisplayContactInfo> contactsList;
  const ContactListingSuccess({required this.contactsList});
}
