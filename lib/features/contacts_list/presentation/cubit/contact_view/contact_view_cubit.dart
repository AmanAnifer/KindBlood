import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kindblood/core/platform/launch_call_interface.dart';
import '../../../domain/entities/blood_group.dart';
part 'contact_view_state.dart';

class ContactViewCubit extends Cubit<ContactViewState> {
  final LaunchCall launchCall;
  ContactViewCubit({required this.launchCall}) : super(ContactViewReadOnly());

  void editDetail({
    required BloodGroup editedBloodGroup,
    double? editedDistanceInKm,
  }) {
    emit(ContactViewEdit(
      editedBloodGroup: editedBloodGroup,
      editedDistanceInKm: editedDistanceInKm,
    ));
  }

  void endEdit() {
    emit(ContactViewReadOnly());
  }

  void callNumber(String number) {
    launchCall.callNumber(number: number);
  }
}
