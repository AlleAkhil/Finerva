import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../app_navigator.dart';
import '../backend/schema/user_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 4;

  @override
  void initState() {
    super.initState();
    _fetchUserData(); // Fetch user data from Firestore on page load
  }

  void _fetchUserData() async {
    await Provider.of<UserModel>(context, listen: false).fetchUserDataFromFirestore();
  }

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });

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
          AppNavigator.navigateTo('/profile');
          break;
      }
    }
  }

  Future<bool> _onWillPop() async {
    return false;
  }

  void _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<UserModel>(context);
    final userName = userModel.name ?? 'User';
    final userEmail = userModel.email ?? 'No email available';
    final userPhotoUrl = userModel.photoUrl;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              AppNavigator.navigateTo('/home');
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Image and User Details
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
                  width: double.infinity,
                  child: TextButton(
                    onPressed: _signOut,
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
