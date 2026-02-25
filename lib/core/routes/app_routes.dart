import 'package:flutter/material.dart';

import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/logout_screen.dart';
import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../../features/profile/presentation/screens/profile_screens.dart';

class AppRoutes {
  static const String login = '/login';
  static const String dashboard = '/dashboard';
  static const String profile = '/profile';
  static const String logout = '/logout';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return _buildRoute(const LoginScreen());

      case dashboard:
        return _buildRoute(const DashboardScreen());

      case profile:
        return _buildRoute(const ProfileScreens());

      case logout:
        return _buildRoute(const LogoutScreen());

      default:
        return _errorRoute(settings.name);
    }
  }

  // Reusable route builder
  static MaterialPageRoute _buildRoute(Widget child) {
    return MaterialPageRoute(
      builder: (_) => child,
    );
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