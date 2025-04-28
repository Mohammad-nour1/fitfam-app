
import 'package:equatable/equatable.dart';

abstract class UserSetupEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SubmitUserSetupEvent extends UserSetupEvent {
  final int familyMembers;
  final String ageGroup;
  final String activityType;
  final String goal;

  SubmitUserSetupEvent({
    required this.familyMembers,
    required this.ageGroup,
    required this.activityType,
    required this.goal,
  });

  @override
  List<Object?> get props => [familyMembers, ageGroup, activityType, goal];
}
