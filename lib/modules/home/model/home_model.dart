class TodayStats {
  final int steps;
  final double calories;
  final double distance;

  TodayStats({
    required this.steps,
    required this.calories,
    required this.distance,
  });

  TodayStats copyWith({
    int? steps,
    double? calories,
    double? distance,
  }) {
    return TodayStats(
      steps: steps ?? this.steps,
      calories: calories ?? this.calories,
      distance: distance ?? this.distance,
    );
  }
}

class FamilyActivityModel {
  final String id;
  final String name;
  final int steps;
  final double distance;
  FamilyActivityModel({
    required this.id,
    required this.name,
    required this.steps,
    required this.distance,
  });

  FamilyActivityModel copyWith({
    String? id,
    String? name,
    int? steps,
    double? distance,
  }) {
    return FamilyActivityModel(
      id: id ?? this.id,
      name: name ?? this.name,
      steps: steps ?? this.steps,
      distance: distance ?? this.distance,
    );
  }

  factory FamilyActivityModel.fromJson(Map<String, dynamic> json) {
    return FamilyActivityModel(
      id: json['id'].toString(),
      name: json['name'],
      steps: json['steps'] ?? 0,
      distance: (json['distance'] ?? 0).toDouble(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'steps': steps,
      'distance': distance,
    };
  }
}

class HomeData {
  final String userName;
  final String currentChallenge;
  final String currentChallengeType;
  final int challengeTarget;
  final double progress;
  final TodayStats todayStats;
  final List<FamilyActivityModel> familyActivity;

  HomeData({
    required this.userName,
    required this.currentChallenge,
    required this.currentChallengeType,
    required this.challengeTarget,
    required this.progress,
    required this.todayStats,
    required this.familyActivity,
  });

  HomeData copyWith({
    String? userName,
    String? currentChallenge,
    String? currentChallengeType,
    int? challengeTarget,
    double? progress,
    TodayStats? todayStats,
    List<FamilyActivityModel>? familyActivity,
  }) {
    return HomeData(
      userName: userName ?? this.userName,
      currentChallenge: currentChallenge ?? this.currentChallenge,
      currentChallengeType: currentChallengeType ?? this.currentChallengeType,
      challengeTarget: challengeTarget ?? this.challengeTarget,
      progress: progress ?? this.progress,
      todayStats: todayStats ?? this.todayStats,
      familyActivity: familyActivity ?? this.familyActivity,
    );
  }
}
