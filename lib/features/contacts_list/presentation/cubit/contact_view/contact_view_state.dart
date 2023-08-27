part of 'contact_view_cubit.dart';

abstract class ContactViewState {}

class ContactViewReadOnly implements ContactViewState {}

class ContactViewEdit implements ContactViewState {
  final BloodGroup editedBloodGroup;
  final String? editedlocationGeoHash;
  ContactViewEdit({required this.editedBloodGroup, this.editedlocationGeoHash});
}
