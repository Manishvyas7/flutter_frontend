import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/role_model.dart';
import '../../../../core/constants/api_constants.dart';

class RolesService {

  Future<List<RoleModel>> fetchRoles() async {

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("access_token");

    final uri = Uri.parse(
      "${ApiConstants.baseUrl}/roles",
    ).replace(queryParameters: {
      "limit": "10",
      "offset": "0",
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

      return rolesJson
          .map((role) => RoleModel.fromJson(role))
          .toList();

    } else {

      throw Exception("Failed to load roles");

    }
  }
}