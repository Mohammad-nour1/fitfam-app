
class HomeData {
  final String userName;
  final String currentChallenge;
  final double progress;
  final List<FamilyMember> familyActivity;

  HomeData({
    required this.userName,
    required this.currentChallenge,
    required this.progress,
    required this.familyActivity,
  });
}

class FamilyMember {
  final String name;
  final int steps;

  FamilyMember({required this.name, required this.steps});
}
