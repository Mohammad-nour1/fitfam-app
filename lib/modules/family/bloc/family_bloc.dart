import 'package:flutter_bloc/flutter_bloc.dart';
import 'family_event.dart';
import 'family_state.dart';
import '../model/family_member.dart';
import 'family_repos.dart';

class FamilyBloc extends Bloc<FamilyEvent, FamilyState> {
  final FamilyRepository _repo = FamilyRepository();
  List<FamilyMember> _members = [];

  FamilyBloc() : super(FamilyInitial()) {
    on<LoadFamilyEvent>((event, emit) async {
      emit(FamilyLoading());
      _members = await _repo.loadFamilyMembers();
      emit(FamilyLoaded(List.from(_members)));
    });

    on<AddFamilyMemberEvent>((event, emit) async {
      _members.add(event.member);
      await _repo.saveFamilyMembers(_members);
      emit(FamilyLoaded(List.from(_members)));
    });

    on<RemoveFamilyMemberEvent>((event, emit) async {
      _members.removeWhere((m) => m.id == event.id);
      await _repo.saveFamilyMembers(_members);
      emit(FamilyLoaded(List.from(_members)));
    });

    on<SearchUserEvent>((event, emit) async {
      emit(FamilyLoading());
      try {
        final results = await _repo.fetchSearchResults(event.query);
        emit(SearchSuccess(results));
      } catch (e) {
        emit(FamilyError(e.toString()));
      }
    });

    on<AddFriendEvent>((event, emit) async {
      final member = FamilyMember(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: event.name,
        avatar: 'assets/images/add.png',
        steps: 0,
        progress: 0,
      );
      _members.add(member);
      await _repo.saveFamilyMembers(_members);
      emit(FamilyLoaded(List.from(_members)));
    });
  }
}
