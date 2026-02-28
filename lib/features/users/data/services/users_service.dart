import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class UsersService {
  static const String baseUrl =
      "https://apifitsip.codepranetra.in/users?limit=10&offset=0";

  Future<List<UserModel>> fetchUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("access_token");

    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final usersJson = data['data']['users'] as List;

      return usersJson
          .map((user) => UserModel.fromJson(user))
          .toList();
    } else {
      throw Exception("Failed to fetch users");
    }
  }
}