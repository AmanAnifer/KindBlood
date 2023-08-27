import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kindblood_common/core_entities.dart';
import 'package:equatable/equatable.dart';
part 'my_info_states.dart';

MyInfoState getCorrectMyInfoState(MyInfo? myInfo) {
  return myInfo == null
      ? const MyInfoDoesNotExist()
      : MyInfoExists(myInfo: myInfo);
}

// This is only for globally accessing MyInfo, no saving or connection to persistant storage

class MyInfoCubit extends Cubit<MyInfoState> {
  MyInfoCubit({MyInfo? myInfo}) : super(getCorrectMyInfoState(myInfo));

  void updateMyInfo({required MyInfo myInfo}) {
    emit(MyInfoExists(myInfo: myInfo));
  }
}
