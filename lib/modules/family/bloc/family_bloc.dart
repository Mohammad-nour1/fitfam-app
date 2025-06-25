import 'package:flutter_bloc/flutter_bloc.dart';
import 'family_event.dart';
import 'family_state.dart';
import '../model/family_member.dart';

class FamilyBloc extends Bloc<FamilyEvent, FamilyState> {
  FamilyBloc() : super(FamilyLoaded([])) {
    on<AddFamilyMemberEvent>((event, emit) {
      final currentState = state;
      if (currentState is FamilyLoaded) {
        emit(FamilyLoaded([...currentState.members, event.member]));
      }
    });

    on<RemoveFamilyMemberEvent>((event, emit) {
      final currentState = state;
      if (currentState is FamilyLoaded) {
        final updatedList =
            currentState.members.where((m) => m.id != event.id).toList();
        emit(FamilyLoaded(updatedList));
      }
    });

    on<UpdateFamilyMemberStepsEvent>((event, emit) {
      final currentState = state;
      if (currentState is FamilyLoaded) {
        final updatedList = currentState.members.map((member) {
          if (member.id == event.id) {
            return FamilyMember(
              id: member.id,
              name: member.name,
              avatar: member.avatar,
              steps: event.steps,
              progress: event.steps / 10000,
            );
          }
          return member;
        }).toList();
        emit(FamilyLoaded(updatedList));
      }
    });

    on<EditFamilyMemberEvent>((event, emit) {
      final currentState = state;
      if (currentState is FamilyLoaded) {
        final updatedList = currentState.members.map((member) {
          if (member.id == event.id) {
            return FamilyMember(
              id: member.id,
              name: event.newName,
              avatar: event.newAvatar ?? member.avatar,
              steps: member.steps,
              progress: member.progress,
            );
          }
          return member;
        }).toList();
        emit(FamilyLoaded(updatedList));
      }
    });
  }
}
