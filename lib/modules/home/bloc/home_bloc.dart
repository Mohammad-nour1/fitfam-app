
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_event.dart';
import 'home_state.dart';
import '../controller/home_controller.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeController _controller = HomeController();

  HomeBloc() : super(HomeInitial()) {
    on<LoadHomeDataEvent>((event, emit) async {
      emit(HomeLoading());
      try {
        final data = await _controller.fetchHomeData();
        emit(HomeLoaded(data));
      } catch (e) {
        emit(HomeError(e.toString()));
      }
    });
  }
}
