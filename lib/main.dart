import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString("access_token");

  runApp(MyApp(isLoggedIn: token != null));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // Decide initial screen based on token
      initialRoute:
          isLoggedIn ? AppRoutes.dashboard : AppRoutes.login,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}