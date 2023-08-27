part of 'contact_view_cubit.dart';

abstract class ContactViewState {
  final BloodGroup currentBloodGroup;
  final LatLong? currentLocationCoordinates;
  ContactViewState({
    required this.currentBloodGroup,
    this.currentLocationCoordinates,
  });
}

class ContactViewReadOnly extends ContactViewState {
  ContactViewReadOnly({
    required super.currentBloodGroup,
    super.currentLocationCoordinates,
  });
}

class ContactViewEdit extends ContactViewState {
  ContactViewEdit(
      {required super.currentBloodGroup, super.currentLocationCoordinates});
}
