

class ChallengeModel {
  final String challengeType;
  final int duration;
  final String reward;

  ChallengeModel({
    required this.challengeType,
    required this.duration,
    required this.reward,
  });

  Map<String, dynamic> toJson() => {
        'challenge_type': challengeType,
        'duration': duration,
        'reward': reward,
      };
}
