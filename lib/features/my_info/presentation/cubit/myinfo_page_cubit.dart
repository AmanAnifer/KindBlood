import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/entities/myinfo_entity.dart';
import '../../domain/usecases/myinfo_usecase.dart';

part 'myinfo_page_states.dart';

class MyInfoPageCubit extends Cubit<MyInfoPageState> {
  final MyInfoUsecase myInfoUsecase;
  MyInfoPageCubit({required this.myInfoUsecase})
      : super(MyInfoPageFirstTime()) {
    checkIfExistAndDisplay();
  }
  void checkIfExistAndDisplay() async {
    emit(MyInfoPageLoading());
    (await myInfoUsecase.getMyInfo()).fold(
      (left) {
        emit(MyInfoPageFirstTime());
      },
      (right) {
        emit(MyInfoPageLoaded(myInfo: right));
      },
    );
  }

  void startEditing() {
    var localState = state;
    if (localState is MyInfoPageFirstTime) {
      emit(MyInfoPageEdit(isFirstEdit: true));
    } else if (localState is MyInfoPageLoaded) {
      emit(MyInfoPageEdit(previousMyInfo: localState.myInfo));
    }
  }

  void updateMyInfo({required MyInfo myInfo}) {
    myInfoUsecase.saveMyInfo(myInfo: myInfo);
    // TODO: is this the best way?
    checkIfExistAndDisplay();
  }
}
