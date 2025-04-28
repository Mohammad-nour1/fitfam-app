
class ChallengeDetailsModel {
  final String title;
  final String description;
  final double progress;
  final int remainingDays;
  final List<ParticipantProgress> participants;

  ChallengeDetailsModel({
    required this.title,
    required this.description,
    required this.progress,
    required this.remainingDays,
    required this.participants,
  });
}

class ParticipantProgress {
  final String name;
  final int steps;

  ParticipantProgress({
    required this.name,
    required this.steps,
  });
}
