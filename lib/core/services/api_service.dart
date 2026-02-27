import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/api_constants.dart';

class ApiService {
  Future<Map<String, dynamic>> login({
    required String identifier,
    required String password,
  }) async {
    final url = Uri.parse(
        ApiConstants.baseUrl + ApiConstants.loginEndpoint);

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
      },
      body: jsonEncode({
        "identifier": identifier,
        "password": password,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return data;
    } else {
      throw Exception(data["message"] ?? "Login failed");
    }
  }
}