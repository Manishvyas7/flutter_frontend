import 'package:flutter/material.dart';
import '../screens/profile_menu_screens.dart';
import '../../../event/presentation/screens/create_event_screen.dart';

class ProfileScreens extends StatelessWidget {
  const ProfileScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,

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

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            /// =========================
            /// Profile Header
            /// =========================
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                "https://i.pravatar.cc/300",
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              "Manish Vyas",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              "Love, Faith, Run",
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 15),

            OutlinedButton.icon(
              onPressed: () {},
              label: const Text("Edit Profile"),
              icon: const Icon(Icons.edit),
            ),

            const SizedBox(height: 25),

            /// =========================
            /// Stats Section
            /// =========================
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  _ProfileStat(title: "Events", value: "12"),
                  _ProfileStat(title: "Followers", value: "245"),
                  _ProfileStat(title: "Following", value: "180"),
                ],
              ),
            ),

            const SizedBox(height: 30),

            /// =========================
            /// Menu Options (Including Create Event)
            /// =========================
            _profileOption(
              icon: Icons.add_circle_outline,
              title: "Create Event",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CreateEventScreen(),
                  ),
                );
              },
            ),

            _profileOption(
              icon: Icons.event,
              title: "My Events",
              onTap: () {},
            ),    
          ],
        ),
      ),
    );
  }

  /// Reusable Profile Option Tile
  Widget _profileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}

/// ===============================
/// Profile Stat Widget
/// ===============================
class _ProfileStat extends StatelessWidget {
  final String title;
  final String value;

  const _ProfileStat({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: TextStyle(color: Colors.grey.shade600),
        ),
      ],
    );
  }
}