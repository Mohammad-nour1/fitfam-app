

import 'package:equatable/equatable.dart';

abstract class ChallengeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SubmitChallengeEvent extends ChallengeEvent {
  final String challengeType;
  final int duration;
  final String reward;

  SubmitChallengeEvent({
    required this.challengeType,
    required this.duration,
    required this.reward,
  });

  @override
  List<Object?> get props => [challengeType, duration, reward];
}
