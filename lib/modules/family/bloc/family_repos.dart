import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fitfam2/modules/family/model/family_member.dart';
import 'package:fitfam2/modules/family/model/searched_user_model.dart';
import 'package:http/http.dart' as http;

class FamilyRepository {
  static const _key = 'family_members';

  Future<List<FamilyMember>> loadFamilyMembers() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(_key);
    if (jsonStr == null) return [];
    final List decoded = jsonDecode(jsonStr);
    return decoded.map((e) => FamilyMember.fromJson(e)).toList();
  }

  Future<void> saveFamilyMembers(List<FamilyMember> list) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = jsonEncode(list.map((e) => e.toJson()).toList());
    await prefs.setString(_key, jsonStr);
  }

  Future<List<SearchedUserModel>> fetchSearchResults(String query) async {
    final url = Uri.parse(
      'https://fitfam-backend-production.up.railway.app/api/search-user?query=$query'
    );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['results'] as List;
      return data.map((e) => SearchedUserModel.fromJson(e)).toList();
    } else {
      throw Exception('فشل في جلب نتائج البحث');
    }
  }
}
