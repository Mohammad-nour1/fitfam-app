import 'package:pedometer/pedometer.dart';
import '../model/home_model.dart';

class HomeController {
  late Stream<StepCount> _stepCountStream;
  int _initialSteps = 0;

  void startListeningSteps(Function(TodayStats) onData) {
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen((event) {
      final int currentSteps = event.steps;

      if (_initialSteps == 0) {
        _initialSteps = currentSteps;
      }

      final int stepsToday = currentSteps - _initialSteps;

      final stats = TodayStats(
        steps: stepsToday,
        calories: calculateCalories(stepsToday),
        distance: calculateDistance(stepsToday),
      );

      onData(stats);
    });
  }

  double calculateCalories(int steps) {
    return steps * 0.04;
  }

  double calculateDistance(int steps) {
    return steps * 0.0008;
  }

  double calculateProgress(int steps, String challengeType, int challengeTarget) {
    if (challengeType == "مشي" || challengeType == "جري" || challengeType == "steps") {
      return (steps / challengeTarget).clamp(0.0, 1.0);
    }
    return 0.0;
  }

  
  Future<HomeData> fetchHomeData() async {
    await Future.delayed(const Duration(seconds: 1)); // محاكاة تحميل البيانات

    return HomeData(
      userName: "مستخدم",
      currentChallenge: "تحدي 10,000 خطوة",
      progress: 0.0,
      currentChallengeType: "مشي",
      challengeTarget: 10000,
      todayStats: TodayStats(steps: 0, calories: 0, distance: 0),
      familyActivity: [],
    );
  }
}
