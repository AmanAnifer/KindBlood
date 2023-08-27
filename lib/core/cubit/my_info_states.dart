part of 'my_info_cubit.dart';

sealed class MyInfoState {
  const MyInfoState();
}

class MyInfoExists implements MyInfoState {
  final MyInfo myInfo;
  const MyInfoExists({required this.myInfo});
}

class MyInfoDoesNotExist implements MyInfoState {
  const MyInfoDoesNotExist();
}
