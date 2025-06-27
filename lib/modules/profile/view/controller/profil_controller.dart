import 'dart:convert';
import 'package:fitfam2/modules/profile/view/model/profilmodel.dart';
import 'package:http/http.dart' as http;

class ProfileController {
  Future<ProfileModel> fetchProfile() async {
    final response = await http.get(
      Uri.parse(
          "https://fitfam-backend-production.up.railway.app/api/profile/1"),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return ProfileModel.fromJson(data);
    } else {
      throw Exception("فشل في جلب البيانات");
    }
  }
}
