import 'package:flutter/material.dart';

import '../../features/dashboard/dashboard.dart';
import '../../features/profile/profile.dart';
import '../../features/auth/login.dart';
import '../../features/auth/logout.dart';

class AppRoutes {
  static const String login = '/login';
  static const String dashboard = '/dashboard';
  static const String profile = '/profile';
  static const String logout = '/logout';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return _buildRoute(const LoginPage());

      case dashboard:
        return _buildRoute(const Dashboard());

      case profile:
        return _buildRoute(const ProfilePage());

      case logout:
        return _buildRoute(const LogoutPage());

      default:
        return _errorRoute(settings.name);
    }
  }

  // Safe reusable route builder
  static MaterialPageRoute _buildRoute(Widget child) {
    return MaterialPageRoute(builder: (_) => child);
  }

  // Error page instead of crash
  static MaterialPageRoute _errorRoute(String? routeName) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(
          child: Text(
            'Route not found: $routeName',
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ), 
    );
  }
}