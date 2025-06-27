import 'package:fitfam2/modules/family/bloc/family_repos.dart';
import 'package:fitfam2/modules/family/model/searched_user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'family_event.dart';
import 'family_state.dart';
import '../model/family_member.dart';

class FamilyBloc extends Bloc<FamilyEvent, FamilyState> {
  final List<FamilyMember> _members = [];
  final FamilyRepository _repo = FamilyRepository();

  FamilyBloc() : super(FamilyInitial()) {
    on<AddFamilyMemberEvent>((event, emit) {
      _members.add(event.member);
      emit(FamilyLoaded(List.from(_members)));
    });

    on<RemoveFamilyMemberEvent>((event, emit) {
      _members.removeWhere((member) => member.id == event.id);
      emit(FamilyLoaded(List.from(_members)));
    });

    on<AddFriendEvent>((event, emit) {
      final member = FamilyMember(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: event.name,
        avatar: 'assets/images/user.png',
        steps: 0,
        progress: 0,
      );
      _members.add(member);
      emit(FamilyLoaded(List.from(_members)));
    });

    on<SearchUserEvent>((event, emit) async {
      try {
        emit(FamilyLoading());
        final response = await _repo.fetchSearchResults(event.query);
        emit(SearchSuccess(response.cast<SearchedUserModel>()));
      } catch (e) {
        emit(FamilyError(e.toString()));
      }
    });
  }
}
