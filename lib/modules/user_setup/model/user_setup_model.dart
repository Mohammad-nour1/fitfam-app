

class UserSetupModel {
  final int familyMembers;
  final String ageGroup;
  final String activityType;
  final String goal;
  
  final int weight;
  UserSetupModel({
    required this.familyMembers,
    required this.ageGroup,
    required this.activityType,
    required this.goal,
 
  required this.weight,
  });

  Map<String, dynamic> toJson() {
    return {
      'family_members': familyMembers,
      'age_group': ageGroup,
      'activity_type': activityType,
      'goal': goal,
      
      'weight': weight,
    };
  }
}
