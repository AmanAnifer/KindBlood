part of 'myinfo_page_cubit.dart';

sealed class MyInfoPageState {}

class MyInfoPageFirstTime implements MyInfoPageState {}

class MyInfoPageLoading implements MyInfoPageState {}

class MyInfoPageLoaded implements MyInfoPageState {
  final MyInfo myInfo;

  MyInfoPageLoaded({required this.myInfo});
}

class MyInfoPageEdit implements MyInfoPageState {
  final bool isFirstEdit;
  final MyInfo? previousMyInfo;

  MyInfoPageEdit({
    this.previousMyInfo,
    this.isFirstEdit = false,
  });
}
