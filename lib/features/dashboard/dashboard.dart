import 'package:flutter/material.dart';
import '../profile/profile.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<bool> _onWillPop() async {
    if (_selectedIndex != 0) {
      // If user is NOT on Dashboard tab
      setState(() {
        _selectedIndex = 0; // Go back to Dashboard tab
      });
      return false; // Don't exit app
    }
    return true; // Exit app if already on Dashboard
  }

  @override
  Widget build(BuildContext context) {
    Widget currentPage;

    if (_selectedIndex == 0) {
      currentPage = const Center(
        child: Text(
          "Dashboard Screen",
          style: TextStyle(fontSize: 22),
        ),
      );
    } else {
      currentPage = const ProfilePage();
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: currentPage,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: Colors.blue,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: "Dashboard",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}