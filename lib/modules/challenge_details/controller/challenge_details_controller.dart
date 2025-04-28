
import '../model/challenge_details_model.dart';

class ChallengeDetailsController {
  Future<ChallengeDetailsModel> fetchDetails(int challengeId) async {
    await Future.delayed(const Duration(seconds: 2)); 

    return ChallengeDetailsModel(
      title: "تحدي 10,000 خطوة",
      description: "هدفك هو الوصول لـ 10,000 خطوة خلال 5 أيام!",
      progress: 0.4,
      remainingDays: 3,
      participants: [
        ParticipantProgress(name: "أحمد", steps: 4200),
        ParticipantProgress(name: "سارة", steps: 5100),
        ParticipantProgress(name: "ليان", steps: 2900),
      ],
    );
  }
}
