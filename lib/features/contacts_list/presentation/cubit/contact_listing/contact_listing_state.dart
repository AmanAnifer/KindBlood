part of 'contact_listing_cubit.dart';

class DisplayContactInfo extends ContactInfo {
  DisplayContactInfo(
      {required super.name,
      required super.phone,
      super.bloodGroup,
      super.locationGeohash});
  factory DisplayContactInfo.fromContactInfo(ContactInfo contactInfo) {
    return DisplayContactInfo(
      name: contactInfo.name,
      phone: contactInfo.phone,
      bloodGroup: contactInfo.bloodGroup,
      locationGeohash: contactInfo.locationGeohash,
    );
  }
  double? get distanceInKm {
    //TODO: calculate distance between user and contact location
    return null;
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
