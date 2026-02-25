import 'package:flutter/material.dart';
import '../../../../core/routes/app_routes.dart';

//------- Profile Page -------//

class ProfileScreens extends StatelessWidget {
  const ProfileScreens({super.key});

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