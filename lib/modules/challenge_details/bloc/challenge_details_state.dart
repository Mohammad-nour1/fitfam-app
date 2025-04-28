
import 'package:equatable/equatable.dart';
import '../model/challenge_details_model.dart';

abstract class ChallengeDetailsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChallengeDetailsInitial extends ChallengeDetailsState {}

class ChallengeDetailsLoading extends ChallengeDetailsState {}

class ChallengeDetailsLoaded extends ChallengeDetailsState {
  final ChallengeDetailsModel details;

  ChallengeDetailsLoaded(this.details);

  @override
  List<Object?> get props => [details];
}

class ChallengeDetailsError extends ChallengeDetailsState {
  final String message;

  ChallengeDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}
