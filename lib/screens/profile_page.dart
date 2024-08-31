import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../app_navigator.dart'; // Import the AppNavigator
import '../backend/schema/user_model.dart'; // Import the UserModel

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

  Future<bool> _onWillPop() async {
    // Disable the back button functionality
    return false;
  }

  void _signOut() async {
    // Sign out the user
    await FirebaseAuth.instance.signOut();

    // Navigate to the login screen
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    // Assuming UserModel has individual getters for name, photoUrl, etc.
    final userModel = Provider.of<UserModel>(context);
    final userName = userModel.name ?? 'User';
    final userEmail = userModel.email ?? '';
    final userPhotoUrl = userModel.photoUrl;

    return WillPopScope(
      onWillPop: _onWillPop, // Disable back button
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // Prevent back navigation after sign out
              AppNavigator.navigateTo('/home');
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
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: userPhotoUrl != null && userPhotoUrl.isNotEmpty
                        ? NetworkImage(userPhotoUrl)
                        : const AssetImage('lib/assets/images/default_avatar.png')
                    as ImageProvider,
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF111517),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        userEmail,
                        style: const TextStyle(
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
                child: SizedBox(
                  width: double.infinity, // Make the button fill the width of the screen
                  child: TextButton(
                    onPressed: _signOut, // Implement sign-out functionality
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
              ),
            ],
          ),
        ),
        bottomNavigationBar: AppNavigator.buildBottomNavigationBar(_selectedIndex, _onItemTapped),
      ),
    );
  }
}
