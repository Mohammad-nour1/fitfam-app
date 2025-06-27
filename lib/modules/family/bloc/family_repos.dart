import 'dart:convert';
import 'package:http/http.dart' as http;

class FamilyRepository {
  Future<List<String>> fetchSearchResults(String query) async {
    final response = await http.get(Uri.parse(
        'https://fitfam-backend-production.up.railway.app/api/search-user?query=$query'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => e['name'] as String).toList();
    } else {
      throw Exception('فشل في جلب النتائج');
    }
  }
}
