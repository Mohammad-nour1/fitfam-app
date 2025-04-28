
import 'package:flutter_bloc/flutter_bloc.dart';
import 'challenge_details_event.dart';
import 'challenge_details_state.dart';
import '../controller/challenge_details_controller.dart';

class ChallengeDetailsBloc extends Bloc<ChallengeDetailsEvent, ChallengeDetailsState> {
  final ChallengeDetailsController _controller = ChallengeDetailsController();

  ChallengeDetailsBloc() : super(ChallengeDetailsInitial()) {
    on<LoadChallengeDetailsEvent>((event, emit) async {
      emit(ChallengeDetailsLoading());
      try {
        final details = await _controller.fetchDetails(event.challengeId);
        emit(ChallengeDetailsLoaded(details));
      } catch (e) {
        emit(ChallengeDetailsError(e.toString()));
      }
    });
  }
}
