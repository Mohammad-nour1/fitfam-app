
import 'package:flutter_bloc/flutter_bloc.dart';
import 'user_setup_event.dart';
import 'user_setup_state.dart';
import '../controller/user_setup_controller.dart';

class UserSetupBloc extends Bloc<UserSetupEvent, UserSetupState> {
  final _controller = UserSetupController();

  UserSetupBloc() : super(UserSetupInitial()) {
    on<SubmitUserSetupEvent>((event, emit) async {
      emit(UserSetupLoading());
      try {
        await _controller.submitUserSetup(
          familyMembers: event.familyMembers,
          ageGroup: event.ageGroup,
          activityType: event.activityType,
          goal: event.goal,
        );
        emit(UserSetupSuccess());
      } catch (e) {
        emit(UserSetupFailure(e.toString()));
      }
    });
  }
}
