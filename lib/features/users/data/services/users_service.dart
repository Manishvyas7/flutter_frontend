import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';
import '../../../../core/constants/api_constants.dart';

class UsersService {

  /// ===============================
  /// FETCH USERS API
  /// ===============================
  Future<List<UserModel>> fetchUsers({
    int limit = 10,
    int offset = 0,
  }) async {

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("access_token");

    final uri = Uri.parse(
      "${ApiConstants.baseUrl}${ApiConstants.usersEndpoint}",
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

// Get ROLES //

  Future<List<Map<String, dynamic>>> fetchRoles({
  int limit = 10,
  int offset = 0,
}) async {

  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString("access_token");

  final uri = Uri.parse(
    "${ApiConstants.baseUrl}/roles",
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

    final rolesJson = data["data"]["roles"] as List;

    return rolesJson.cast<Map<String, dynamic>>();

  } else {

    throw Exception("Failed to load roles");

  }
}

  /// ===============================
  /// CREATE USER API
  /// ===============================
  Future<bool> createUser({
    required String name,
    required String email,
    required String phoneNumber,
    required int roleId,
    required String password,
    required bool isActive,
  }) async {

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("access_token");

    final uri = Uri.parse(
      "${ApiConstants.baseUrl}${ApiConstants.usersEndpoint}",
    );

    final response = await http.post(
      uri,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },

      body: jsonEncode({
        "name": name,
        "email": email,
        "phone_number": phoneNumber,
        "role_id": roleId,
        "password": password,
        "is_active": isActive,
      }),
    );

    /// SUCCESS
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    }

    /// VALIDATION ERROR
    if (response.statusCode == 422) {

      final errorData = jsonDecode(response.body);

      throw Exception(
        errorData["detail"] ?? "Validation error occurred",
      );

    }

    /// OTHER ERRORS
    throw Exception("Failed to create user");
  }
}