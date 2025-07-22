
import 'package:equatable/equatable.dart';

import 'package:fitfam2/modules/home/model/home_model.dart';



abstract class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadHomeDataEvent extends HomeEvent {}

class UpdateStepDataEvent extends HomeEvent {
  final TodayStats todayStats;

  UpdateStepDataEvent({required this.todayStats});

  @override
  List<Object?> get props => [todayStats];
}
