import '../model/family_member.dart';

abstract class FamilyEvent {}

class AddFamilyMemberEvent extends FamilyEvent {
  final FamilyMember member;
  AddFamilyMemberEvent(this.member);
}

class RemoveFamilyMemberEvent extends FamilyEvent {
  final String id;
  RemoveFamilyMemberEvent(this.id);
}

class UpdateFamilyMemberStepsEvent extends FamilyEvent {
  final String id;
  final int steps;
  UpdateFamilyMemberStepsEvent(this.id, this.steps);
}
