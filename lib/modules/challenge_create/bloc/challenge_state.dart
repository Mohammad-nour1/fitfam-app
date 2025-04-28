

import 'package:equatable/equatable.dart';

abstract class ChallengeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChallengeInitial extends ChallengeState {}

class ChallengeLoading extends ChallengeState {}

class ChallengeSuccess extends ChallengeState {}

class ChallengeFailure extends ChallengeState {
  final String error;

  ChallengeFailure(this.error);

  @override
  List<Object?> get props => [error];
}
