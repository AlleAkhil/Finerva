import 'package:flutter/material.dart';
import '../app_navigator.dart'; // Import the AppNavigator

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 4; // Set the initial selected index for the profile tab

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Use AppNavigator for navigation
    switch (index) {
      case 0:
        AppNavigator.navigateTo('/home');
        break;
      case 1:
        AppNavigator.navigateTo('/search');
        break;
      case 2:
        AppNavigator.navigateTo('/chart');
        break;
      case 3:
        AppNavigator.navigateTo('/cards');
        break;
      case 4:
      // We're already on the profile page, no need to navigate
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile Image and User Name
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/profile_picture.png'), // Replace with actual image path
            ),
            const SizedBox(height: 16),
            const Text(
              'Chris Johnson',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF111517),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'chris.johnson@example.com',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF647987),
              ),
            ),
            const SizedBox(height: 32),

            // Edit Profile Button
            ElevatedButton(
              onPressed: () {
                // Navigate to Edit Profile screen
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                backgroundColor: Colors.blue[800],
              ),
              child: const Text(
                'Edit Profile',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),

            // Settings Button
            ElevatedButton(
              onPressed: () {
                // Navigate to Settings screen
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                backgroundColor: Colors.blue[800],
              ),
              child: const Text(
                'Settings',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),

            // Logout Button
            ElevatedButton(
              onPressed: () {
                // Handle Logout
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                backgroundColor: Colors.redAccent,
              ),
              child: const Text(
                'Logout',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Color(0xFF111517)),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: Color(0xFF647987)),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart, color: Color(0xFF647987)),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card, color: Color(0xFF647987)),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Color(0xFF111517)),
            label: '',
          ),
        ],
        selectedItemColor: const Color(0xFF1d8cd7),
      ),
    );
  }
}
