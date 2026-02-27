import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/services/api_service.dart';

class AuthRepository {
  final ApiService _apiService = ApiService();

  // ----------- Login Method --------------- //
  Future<bool> login(String email, String password) async {
    final response = await _apiService.login(
      identifier: email,
      password: password,
    );

    if (response["code"] == 200) {
      final prefs = await SharedPreferences.getInstance();

      await prefs.setString(
          "access_token", response["data"]["access_token"]);
      await prefs.setString(
          "refresh_token", response["data"]["refresh_token"]);
      await prefs.setString(
          "email", response["data"]["email"]);

      return true;
    }

    return false;
  }

  // ----------- Logout Method --------------- //
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("access_token");

    if (token == null) {
      throw Exception("Token missing");
    }

    await _apiService.logout(token);

    await prefs.clear();
  }
}