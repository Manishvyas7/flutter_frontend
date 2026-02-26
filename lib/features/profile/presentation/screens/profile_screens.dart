import 'package:flutter/material.dart';
import '../screens/profile_menu_screens.dart';

class ProfileScreens extends StatelessWidget {
  const ProfileScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,

        // 👈 Drawer/Menu icon on LEFT
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ProfileMenuScreen(),
              ),
            );
          },
        ),
      ),

      body: const Center(
        child: Text(
          "Profile Content",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}