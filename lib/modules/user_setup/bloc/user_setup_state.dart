
import 'package:equatable/equatable.dart';

abstract class UserSetupState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserSetupInitial extends UserSetupState {}

class UserSetupLoading extends UserSetupState {}

class UserSetupSuccess extends UserSetupState {}

class UserSetupFailure extends UserSetupState {
  final String error;

  UserSetupFailure(this.error);

  @override
  List<Object?> get props => [error];
}
