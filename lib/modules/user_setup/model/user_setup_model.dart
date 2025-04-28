

class UserSetupModel {
  final int familyMembers;
  final String ageGroup;
  final String activityType;
  final String goal;

  UserSetupModel({
    required this.familyMembers,
    required this.ageGroup,
    required this.activityType,
    required this.goal,
  });

  Map<String, dynamic> toJson() {
    return {
      'family_members': familyMembers,
      'age_group': ageGroup,
      'activity_type': activityType,
      'goal': goal,
    };
  }
}
