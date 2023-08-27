import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kindblood/core/platform/launch_call_interface.dart';
import '../../../../../core/entities/blood_group.dart';
part 'contact_view_state.dart';

class ContactViewCubit extends Cubit<ContactViewState> {
  final LaunchCall launchCall;
  ContactViewCubit({
    required this.launchCall,
  }) : super(ContactViewReadOnly());

  void editDetail({
    required BloodGroup editedBloodGroup,
    String? editedLocationGeoHash,
  }) {
    emit(ContactViewEdit(
      editedBloodGroup: editedBloodGroup,
      editedlocationGeoHash: editedLocationGeoHash,
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
    emit(ContactViewReadOnly());
    // }
  }

  void callNumber(String number) {
    launchCall.callNumber(number: number);
  }
}
