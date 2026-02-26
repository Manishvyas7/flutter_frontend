import 'package:flutter/material.dart';
import 'package:flutter_frontend/features/profile/presentation/screens/profile_screens.dart';
import 'package:flutter_frontend/features/event/presentation/screens/create_event_screen.dart';
import '../screens/widgets/stats_card.dart';
import '../screens/widgets/event_card.dart';
import '../screens/widgets/upcoming_event_card.dart';
import '../screens/widgets/welcome_section.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

// ------ array for changing the page on the click ------- //

  void _onItemTapped(int index) {
    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const ProfileScreens(),
        ),
      );
      return;
    }

    setState(() => _selectedIndex = index);
  }

  // ------- Used toget out of the application when clicked Back Button ------ //

  Future<bool> _onWillPop() async {
    if (_selectedIndex != 0) {
      setState(() => _selectedIndex = 0);
      return false;
    }
    return true;
  }

// -------- Logic for switching to the different pages on click ------- //

  @override
  Widget build(BuildContext context) {
    Widget currentPage;

    switch (_selectedIndex) {
      case 0:
        currentPage = _buildDashboardContent();
        break;
      case 1:
        currentPage = const CreateEventScreen();
        break;
      default:
        currentPage = _buildDashboardContent();
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Event Manager"),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_none),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("No Notification "),
                  ),
                );
              },
            ),
          ],
        ),

        // ------ BOTTOM NAVIGATION BAR ------ //

        body: currentPage,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: "Dashboard",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: "New",
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

// ------ Calling the different widgets and arranging them ------ //

  Widget _buildDashboardContent() {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WelcomeSection(),
          SizedBox(height: 20),
          UpcomingEventCard(),
          SizedBox(height: 20),
          StatsCard(),
          SizedBox(height: 20),
          EventCard(),
        ],
      ),
    );
  }
}
