import '../model/family_member.dart';

abstract class FamilyState {}

class FamilyInitial extends FamilyState {}

class FamilyLoaded extends FamilyState {
  final List<FamilyMember> members;
  FamilyLoaded(this.members);
}
