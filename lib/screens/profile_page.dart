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
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });

      // Use AppNavigator for navigation
      switch (index) {
        case 0:
          AppNavigator.navigateTo('/home');
          break;
        case 1:
          AppNavigator.navigateTo('/plan');
          break;
        case 2:
          AppNavigator.navigateTo('/chart');
          break;
        case 3:
          AppNavigator.navigateTo('/cards');
          break;
        case 4:
          AppNavigator.navigateTo('/profile'); // Redundant but ensures consistency
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            AppNavigator.navigateTo('/home'); // Navigate to the home page when back icon is pressed
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Image and User Name
            Row(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/images/profile_picture.png'), // Replace with actual image path
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Financial Overview',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF111517),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '@financial_overview',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF647987),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Settings Options
            ListTile(
              leading: const Icon(Icons.attach_money, color: Color(0xFF111517)),
              title: const Text('Expense Tracker'),
              trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFF647987)),
              onTap: () {
                // Navigate to Expense Tracker
              },
            ),
            ListTile(
              leading: const Icon(Icons.savings, color: Color(0xFF111517)),
              title: const Text('Savings Plan'),
              trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFF647987)),
              onTap: () {
                // Navigate to Savings Plan
              },
            ),
            ListTile(
              leading: const Icon(Icons.lock, color: Color(0xFF111517)),
              title: const Text('Privacy'),
              trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFF647987)),
              onTap: () {
                // Navigate to Privacy
              },
            ),
            ListTile(
              leading: const Icon(Icons.help_outline, color: Color(0xFF111517)),
              title: const Text('FAQs'),
              trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFF647987)),
              onTap: () {
                // Navigate to FAQs
              },
            ),
            const Spacer(),
            // Sign out button
            Center(
              child: TextButton(
                onPressed: () {
                  // Handle Sign Out
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  backgroundColor: Colors.grey[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Sign out',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF111517),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppNavigator.buildBottomNavigationBar(_selectedIndex, _onItemTapped),
    );
  }
}
