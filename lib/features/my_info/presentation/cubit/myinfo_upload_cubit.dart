import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kindblood_common/core_entities.dart';
import '../../domain/usecases/myinfo_usecase.dart';

part 'myinfo_upload_state.dart';

class MyInfoUploadCubit extends Cubit<MyInfoUploadState> {
  final MyInfoUsecase myInfoUsecase;
  Timer? tickToUploadIconTimer;
  MyInfoUploadCubit({required this.myInfoUsecase})
      : super(MyInfoUploadInitial());

  @override
  Future<void> close() async {
    await super.close();
    tickToUploadIconTimer?.cancel();
  }

  Future<void> uploadMyInfo({required MyInfo myInfo}) async {
    emit(MyInfoUploading());
    var result = await myInfoUsecase.uploadMyInfo(myInfo: myInfo);
    result.fold((l) => emit(MyInfoUploadError()), (r) {
      emit(MyInfoUploadComplete());
      tickToUploadIconTimer = Timer(const Duration(seconds: 3), setUploadable);
    });
  }

  void setUploadable() {
    emit(MyInfoUploadable());
  }
}
