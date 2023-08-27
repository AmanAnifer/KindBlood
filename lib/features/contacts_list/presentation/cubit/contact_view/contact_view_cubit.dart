import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kindblood_common/core_entities.dart';

import '../../../../../core/platform/launch_call_interface.dart';

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
    BloodGroup? editedBloodGroup,
    LatLong? editedLocationCoordinates,
  }) {
    emit(ContactViewEdit(
      currentBloodGroup: editedBloodGroup ?? state.currentBloodGroup,
      currentLocationCoordinates:
          editedLocationCoordinates ?? state.currentLocationCoordinates,
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
