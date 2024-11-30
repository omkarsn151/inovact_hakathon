import 'package:flutter/material.dart';
import 'package:inovact_social/screens/news_screen.dart';

import '../screens/feed_screen.dart';
import '../screens/profile_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
     const FeedScreen(),    // Replace with actual FeedScreen
    const NewsScreen(), // Replace with actual ExploreScreen
    const ProfileScreen(), // Replace with actual ProfileScreen
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Show the respective page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blueAccent,  // Highlight selected item
        unselectedItemColor: Colors.grey,  // Color for unselected items
        backgroundColor: Colors.white,  // Background color of the nav bar
        // showUnselectedLabels: false,  // Disable unselected labels for clean UI
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),  // Feed icon
            label: 'Feed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper_rounded),  // Explore icon
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),  // Profile icon
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}


