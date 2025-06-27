class ProfileModel {
  final int id;
  final int userId;
  final int familyMembers;
  final String ageGroup;
  final String preferredActivity;
  final String mainGoal;
  final int weight;

  ProfileModel({
    required this.id,
    required this.userId,
    required this.familyMembers,
    required this.ageGroup,
    required this.preferredActivity,
    required this.mainGoal,
    required this.weight,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'],
      userId: json['user_id'],
      familyMembers: json['family_members'],
      ageGroup: json['age_group'],
      preferredActivity: json['preferred_activity'],
      mainGoal: json['main_goal'],
      weight: json['weight'],
    );
  }
}
