import '../model/home_model.dart';

class HomeController {
  Future<HomeData> fetchHomeData() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return HomeData(
      userName: 'عادل',
      currentChallenge: 'تحدي 10,000 خطوة',
      currentChallengeType: 'steps',
      challengeTarget: 10000,
      progress: 0.0,
      todayStats: TodayStats(steps: 0, calories: 0, distance: 0),
      familyActivity: [
        FamilyActivityModel(
          id: '1',
          name: 'nour',
          steps: 1200,
          distance: 0.9,
          avatar: 'assets/images/user2.png',
        ),
        FamilyActivityModel(
          id: '2',
          name: 'ali',
          steps: 800,
          distance: 0.6,
          avatar: 'assets/images/user1.png',
        ),
      ],
    );
  }

  double calculateProgress(int steps, String type, int target) {
    if (type == 'steps') {
      return (steps / target).clamp(0.0, 1.0);
    }
    return 0.0;
  }
}
