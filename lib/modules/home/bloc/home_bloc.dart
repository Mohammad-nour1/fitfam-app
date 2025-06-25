import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_event.dart';
import 'home_state.dart';
import '../controller/home_controller.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeController controller = HomeController();

  HomeBloc() : super(HomeInitial()) {
    on<LoadHomeDataEvent>((event, emit) async {
      emit(HomeLoading());
      try {
        final data = await controller.fetchHomeData();
        emit(HomeLoaded(data));
      } catch (e) {
        emit(HomeError(e.toString()));
      }
    });

    on<UpdateStepDataEvent>((event, emit) async {
      if (state is HomeLoaded) {
        final current = (state as HomeLoaded).data;

        final updated = current.copyWith(
          todayStats: event.todayStats,
          progress: controller.calculateProgress(
            event.todayStats.steps,
            current.currentChallengeType,
            current.challengeTarget,
          ),
        );

        emit(HomeLoaded(updated));
      }
    });
  }
}
