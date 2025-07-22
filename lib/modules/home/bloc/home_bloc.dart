
import 'package:bloc/bloc.dart';
import 'package:fitfam2/modules/home/bloc/home_event.dart';
import 'package:fitfam2/modules/home/bloc/home_state.dart';
import '../model/home_model.dart';
import '../controller/home_controller.dart';



class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeController _controller = HomeController();

  HomeBloc() : super(HomeInitial()) {
    on<LoadHomeDataEvent>(_onLoadHomeData);
    on<UpdateStepDataEvent>(_onUpdateStepData);
  }

  Future<void> _onLoadHomeData(
      LoadHomeDataEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      final rawData = await _controller.fetchHomeData();

      final familyModels = rawData.familyActivity.map((jsonMember) {
        return FamilyActivityModel(
          id: jsonMember.id,
          name: jsonMember.name,
          steps: jsonMember.steps,
          distance: jsonMember.distance,
          avatar: jsonMember.avatar ?? 'assets/images/user.png',
        );
      }).toList();

      final homeData = HomeData(
        userName: rawData.userName,
        currentChallenge: rawData.currentChallenge,
        currentChallengeType: rawData.currentChallengeType,
        challengeTarget: rawData.challengeTarget,
        progress: rawData.progress,
        todayStats: rawData.todayStats,
        familyActivity: familyModels,
      );

      emit(HomeLoaded(homeData));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  void _onUpdateStepData(
      UpdateStepDataEvent event, Emitter<HomeState> emit) {
    if (state is HomeLoaded) {
      final current = (state as HomeLoaded).data;
      final updated = current.copyWith(
        todayStats: event.todayStats,
        progress: _controller.calculateProgress(
          event.todayStats.steps,
          current.currentChallengeType,
          current.challengeTarget,
        ),
      );
      emit(HomeLoaded(updated));
    }
  }
}
