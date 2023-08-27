part of 'my_info_cubit.dart';

sealed class MyInfoState extends Equatable {
  const MyInfoState();
}

class MyInfoExists extends MyInfoState with EquatableMixin {
  final MyInfo myInfo;
  const MyInfoExists({required this.myInfo});
  @override
  List<Object?> get props => [myInfo];
}

class MyInfoDoesNotExist extends MyInfoState with EquatableMixin {
  const MyInfoDoesNotExist();
  @override
  List<Object?> get props => [];
}
