import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

class PermissionDeniedFailure extends Failure {}

class NoExistingMyInfoFailure extends Failure {}

class NoCachedContactsFailure extends Failure {}

class NetworkFailure extends Failure {}
