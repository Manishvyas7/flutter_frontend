import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter_frontend/features/profile/presentation/screens/profile_screens.dart';
import '../screens/widgets/stats_card.dart';
import '../screens/widgets/event_card.dart';
import '../screens/widgets/upcoming_event_card.dart';
import '../screens/widgets/welcome_section.dart';
import '../../../../features/users/presentation/screens/users_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    DashboardHomePage(),
    UsersScreen(),
    ProfileScreens(),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  Future<bool> _onWillPop() async {
    if (_selectedIndex != 0) {
      setState(() => _selectedIndex = 0);
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: "Dashboard",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.app_registration),
              label: "User Table",
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

//
// Dashboard Home Page
//

class DashboardHomePage extends StatelessWidget {
  const DashboardHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Event Manager"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("No Notification"),
                ),
              );
            },
          ),
        ],
      ),
      body: const SingleChildScrollView(
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
            SizedBox(height: 20),

            // 📍 Google Map Section
            EventLocationMap(),
          ],
        ),
      ),
    );
  }
}

//
// Google Map Widget
//

class EventLocationMap extends StatelessWidget {
  const EventLocationMap({super.key});

  @override
  Widget build(BuildContext context) {

    const LatLng eventLocation = LatLng(28.6139, 77.2090); // Example Delhi

    final Marker eventMarker = const Marker(
      markerId: MarkerId("event_location"),
      position: eventLocation,
      infoWindow: InfoWindow(
        title: "Event Location",
        snippet: "Tap to view",
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Event Location",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 10),

        SizedBox(
          height: 250,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: eventLocation,
                zoom: 14,
              ),
              markers: {eventMarker},
              zoomControlsEnabled: true,
              mapType: MapType.normal,
            ),
          ),
        ),
      ],
    );
  }
}