import 'package:flutter/material.dart';
import '../../core/routes/routes.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
           Navigator.pushNamedAndRemoveUntil(
  context,
  AppRoutes.dashboard,
  (route) => false, 
            );
          },
          child: const Text("Login"),
        ),
      ),
    );
  }
}