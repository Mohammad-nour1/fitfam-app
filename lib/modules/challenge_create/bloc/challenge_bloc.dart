

import 'package:flutter_bloc/flutter_bloc.dart';
import '../controller/challenge_controller.dart';
import 'challenge_event.dart';
import 'challenge_state.dart';

class ChallengeBloc extends Bloc<ChallengeEvent, ChallengeState> {
  final ChallengeController _controller = ChallengeController();

  ChallengeBloc() : super(ChallengeInitial()) {
    on<SubmitChallengeEvent>((event, emit) async {
      emit(ChallengeLoading());
      try {
        await _controller.submitChallenge(
          challengeType: event.challengeType,
          duration: event.duration,
          reward: event.reward,
        );
        emit(ChallengeSuccess());
      } catch (e) {
        emit(ChallengeFailure(e.toString()));
      }
    });
  }
}
