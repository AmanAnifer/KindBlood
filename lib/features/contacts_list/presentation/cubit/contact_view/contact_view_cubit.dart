import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kindblood/core/platform/launch_call_interface.dart';
import '../../../../../core/entities/blood_group.dart';
import 'package:kindblood/core/entities/location_entity.dart';

part 'contact_view_state.dart';

class ContactViewCubit extends Cubit<ContactViewState> {
  final LaunchCall launchCall;
  ContactViewCubit(
      {required this.launchCall,
      required BloodGroup bloodGroup,
      LatLong? locationCoordinates})
      : super(ContactViewReadOnly(
          currentBloodGroup: bloodGroup,
          currentLocationCoordinates: locationCoordinates,
        ));

  void editDetail({
    required BloodGroup editedBloodGroup,
    LatLong? editedLocationCoordinates,
  }) {
    emit(ContactViewEdit(
      currentBloodGroup: editedBloodGroup,
      currentLocationCoordinates: editedLocationCoordinates,
    ));
  }

  void endEdit() {
    // var localState = state;
    // if (localState is ContactViewEdit) {
    //   updateContact.updateContact(
    //     phoneNumber: phoneNumber,
    //     bloodGroup: localState.editedBloodGroup,
    //     locationGeoHash: localState.editedlocationGeoHash,
    //   );
    emit(ContactViewReadOnly(
      currentBloodGroup: state.currentBloodGroup,
      currentLocationCoordinates: state.currentLocationCoordinates,
    ));
    // }
  }

  void callNumber(String number) {
    launchCall.callNumber(number: number);
  }
}
