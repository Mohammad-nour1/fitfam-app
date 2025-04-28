
import 'package:equatable/equatable.dart';

abstract class ChallengeDetailsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadChallengeDetailsEvent extends ChallengeDetailsEvent {
  final int challengeId;

  LoadChallengeDetailsEvent(this.challengeId);

  @override
  List<Object?> get props => [challengeId];
}

class UpdateUserProgressEvent extends ChallengeDetailsEvent {
  final int steps;

  UpdateUserProgressEvent(this.steps);

  @override
  List<Object?> get props => [steps];
}
