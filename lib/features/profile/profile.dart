import 'package:flutter/material.dart';
import '../../core/routes/routes.dart';

//------- Profile Page -------//

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.logout); // routes to the logout 
          },
          child: const Text("Logout"),
        ),
      ),
    );
  }
} 