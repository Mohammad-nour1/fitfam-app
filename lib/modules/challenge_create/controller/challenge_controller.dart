

class ChallengeController {
  Future<void> submitChallenge({
    required String challengeType,
    required int duration,
    required String reward,
  }) async {
    
    await Future.delayed(const Duration(seconds: 2)); 
  }
}
