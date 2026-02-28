import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../../../../core/constants/api_constants.dart';

class UsersService {

  Future<List<UserModel>> fetchUsers({
    int limit = 10,
    int offset = 0,
  }) async {

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("access_token");

    final uri = Uri.parse(
      "${ApiConstants.baseUrl}${ApiConstants.usersEndpoint}"
    ).replace(queryParameters: {
      "limit": limit.toString(),
      "offset": offset.toString(),
    });

    final response = await http.get(
      uri,
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