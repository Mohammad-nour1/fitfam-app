import 'dart:convert';
import 'package:http/http.dart' as http;

class UserSetupController {
  Future<void> submitUserSetup({
    required int familyMembers,
    required String ageGroup,
    required String activityType,
    required String goal,
    required int weight,
  }) async {
    const String url = 'https://fitfam-backend-production.up.railway.app/api/profile';

    final Map<String, dynamic> payload = {
      "user_id": 1,
      "family_members": familyMembers,
      "age_group": _translateAgeGroup(ageGroup),
      "preferred_activity": _translateActivity(activityType),
      "main_goal": _translateGoal(goal),
      "weight": weight,
    };

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(payload),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception("فشل إرسال البيانات: ${response.body}");
    }
  }

  // 🧠 تحويلات اللغة
  String _translateAgeGroup(String ar) {
    switch (ar) {
      case 'أقل من 18':
        return 'Under 18';
      case '18-30':
        return '18-30';
      case '31-50':
        return '31-50';
      case 'أكثر من 50':
        return 'Above 50';
      default:
        return ar;
    }
  }

  String _translateActivity(String ar) {
    switch (ar) {
      case 'مشي':
        return 'Walking';
      case 'جري':
        return 'Running';
      case 'رياضة منزلية':
        return 'Home Workout';
      default:
        return ar;
    }
  }

  String _translateGoal(String ar) {
    switch (ar) {
      case 'تحسين اللياقة':
        return 'Improve fitness';
      case 'فقدان الوزن':
        return 'Lose weight';
      case 'زيادة النشاط':
        return 'Increase activity';
      default:
        return ar;
    }
  }
}
