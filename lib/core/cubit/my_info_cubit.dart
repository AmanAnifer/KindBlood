import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kindblood/core/entities/myinfo_entity.dart';
part 'my_info_states.dart';

MyInfoState getCorrectMyInfoState(MyInfo? myInfo) {
  return myInfo == null
      ? const MyInfoDoesNotExist()
      : MyInfoExists(myInfo: myInfo);
}

class MyInfoCubit extends Cubit<MyInfoState> {
  MyInfoCubit({MyInfo? myInfo}) : super(getCorrectMyInfoState(myInfo));

  void updateMyInfo({required MyInfo myInfo}) {
    emit(MyInfoExists(myInfo: myInfo));
  }
}
