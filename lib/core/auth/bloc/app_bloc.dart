import 'package:flutter_bloc/flutter_bloc.dart';

enum AppEvent { splash, login, signup, logout, main }

class AppBloc extends Bloc<AppEvent, String> {
  AppBloc() : super("/SplashScreen") {
    on<AppEvent>((event, emit) {
      switch (event) {
        case AppEvent.splash:
          emit("/SplashScreen");
          break;
        case AppEvent.login:
          emit("/LoginScreen");
          break;
        case AppEvent.signup:
          emit("/SignUpScreen");
          break;
        case AppEvent.logout:
          emit("/LogoutScreen");
          break;
        case AppEvent.main:
          emit("/main");
          break;
      }
    });
  }
}
