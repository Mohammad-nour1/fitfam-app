

class ChallengeController {
  Future<void> submitChallenge({
    required String challengeType,
    required int duration,
    required String reward,
  }) async {
    
    // await Dio().post('https://api.yourserver.com/challenges', data: {...});
    await Future.delayed(const Duration(seconds: 2)); 
  }
}
