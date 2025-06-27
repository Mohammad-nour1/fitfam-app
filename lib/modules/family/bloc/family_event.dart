import 'package:equatable/equatable.dart';
import 'package:fitfam2/modules/family/model/family_member.dart';

abstract class FamilyEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddFamilyMemberEvent extends FamilyEvent {
  final FamilyMember member;

  AddFamilyMemberEvent(this.member);

  @override
  List<Object?> get props => [member];
}

class RemoveFamilyMemberEvent extends FamilyEvent {
  final String id;

  RemoveFamilyMemberEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class AddFriendEvent extends FamilyEvent {
  final String name;

  AddFriendEvent(this.name);

  @override
  List<Object?> get props => [name];
}

class SearchUserEvent extends FamilyEvent {
  final String query;

  SearchUserEvent(this.query);

  @override
  List<Object?> get props => [query];
}
