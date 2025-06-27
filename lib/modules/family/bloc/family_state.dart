import 'package:equatable/equatable.dart';
import 'package:fitfam2/modules/family/model/family_member.dart';
import '../model/searched_user_model.dart';

abstract class FamilyState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FamilyInitial extends FamilyState {}

class FamilyLoading extends FamilyState {}

class FamilyLoaded extends FamilyState {
  final List<FamilyMember> members;

  FamilyLoaded(this.members);

  @override
  List<Object?> get props => [members];
}

class SearchSuccess extends FamilyState {
  final List<SearchedUserModel> suggestions;

  SearchSuccess(this.suggestions);

  @override
  List<Object?> get props => [suggestions];
}

class FamilyError extends FamilyState {
  final String message;

  FamilyError(this.message);

  @override
  List<Object?> get props => [message];
}
