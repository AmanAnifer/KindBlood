part of 'contact_listing_cubit.dart';

class DisplayContactInfo extends OfflineContactInfo {
  final LengthUnit? distanceFromUser;
  final BloodCompatibility? bloodCompatibility;
  const DisplayContactInfo({
    required super.id,
    super.name,
    super.phone,
    super.bloodGroup,
    this.bloodCompatibility,
    super.locationCoordinates,
    this.distanceFromUser,
  });
  factory DisplayContactInfo.fromContactInfo({
    required ContactInfo contactInfo,
    LengthUnit? distanceFromUser,
    BloodCompatibility? bloodCompatibility,
  }) {
    return DisplayContactInfo(
      id: contactInfo.id,
      name: contactInfo.name,
      phone: contactInfo.phone,
      bloodGroup: contactInfo.bloodGroup,
      locationCoordinates: contactInfo.locationCoordinates,
      distanceFromUser: distanceFromUser,
      bloodCompatibility: bloodCompatibility,
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

class ContactListingError extends ContactListingState {
  final String errorMessage;
  const ContactListingError({required this.errorMessage});
}

class ContactListingDenied extends ContactListingState {}

class ContactListingSuccess extends ContactListingState {
  final List<DisplayContactInfo> contactsList;
  const ContactListingSuccess({required this.contactsList});
}
