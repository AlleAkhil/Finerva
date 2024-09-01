import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../app_navigator.dart';
import '../backend/schema/user_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // Schedule the _loadUserData function to run after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUserData();
    });
  }

  Future<void> _loadUserData() async {
    await Provider.of<UserModel>(context, listen: false).fetchUserDataFromFirestore();
  }

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
          AppNavigator.navigateTo('/profile');
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<UserModel>(context);  // Access UserModel from Provider
    final userName = userModel.name ?? 'User';  // Fetched name or fallback

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer(); // Open the side navigation bar
          },
        ),
        title: Text(
          'Hello, $userName', // Display the username from UserModel
          style: const TextStyle(
            color: Color(0xFF111517),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF111517)),
        actions: [
          CircleAvatar(
            backgroundImage: userModel.photoUrl != null && userModel.photoUrl!.isNotEmpty
                ? NetworkImage(userModel.photoUrl!)
                : const AssetImage('lib/assets/images/default_avatar.png')
            as ImageProvider,
          ),
        ],
      ),
      drawer: _buildDrawer(context), // Side navigation bar
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome to Finerva!',
                style: TextStyle(
                  color: Color(0xFF111517),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Net worth',
                      style: TextStyle(
                        color: Color(0xFF111517),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '\$222,358',
                      style: TextStyle(
                        color: Color(0xFF111517),
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '**** **** **** 0322',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Switch(
                          value: true,
                          onChanged: (bool value) {
                            // Handle switch action
                          },
                          activeColor: Colors.black,
                          activeTrackColor: Colors.grey,
                          inactiveThumbColor: Colors.black,
                          inactiveTrackColor: Colors.grey,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: _buildEarningsOutgoingsCard(
                      icon: Icons.arrow_upward,
                      label: 'Earnings',
                      amount: '\$20,850',
                      color: Colors.grey[200]!,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildEarningsOutgoingsCard(
                      icon: Icons.arrow_downward,
                      label: 'Outgoings',
                      amount: '\$12,850',
                      color: Colors.grey[200]!,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildSectionCard(
                    label: 'Targets',
                    icon: Icons.flag,
                    value: '6',
                    backgroundColor: Colors.grey[800]!,
                    textColor: Colors.white,
                  ),
                  _buildSectionCard(
                    label: 'Financial',
                    icon: Icons.account_balance,
                    value: '4',
                    backgroundColor: Colors.grey[800]!,
                    textColor: Colors.white,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildSectionCard(
                    label: 'Savings progress',
                    icon: Icons.savings,
                    value: '35%',
                    backgroundColor: Colors.grey[800]!,
                    textColor: Colors.white,
                  ),
                  _buildSectionCard(
                    label: 'Recent transactions',
                    icon: Icons.receipt,
                    value: '26',
                    backgroundColor: Colors.grey[800]!,
                    textColor: Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppNavigator.buildBottomNavigationBar(
          _selectedIndex, _onItemTapped),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    final userModel = Provider.of<UserModel>(context);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(userModel.name ?? "User"), // Set the username here
            accountEmail: Text(userModel.email ?? ""),
            currentAccountPicture: CircleAvatar(
              backgroundImage: userModel.photoUrl != null && userModel.photoUrl!.isNotEmpty
                  ? NetworkImage(userModel.photoUrl!)
                  : const AssetImage('assets/images/default_avatar.png')
              as ImageProvider,
            ),
            decoration: BoxDecoration(
              color: Colors.grey[800],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              AppNavigator.navigateTo('/home');
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              // Handle navigation to Settings
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              FirebaseAuth.instance.signOut().then((value) {
                AppNavigator.navigateTo('/login');
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEarningsOutgoingsCard({
    required IconData icon,
    required String label,
    required String amount,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Color(0xFF111517), size: 24),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF111517),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            amount,
            style: const TextStyle(
              color: Color(0xFF111517),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({
    required String label,
    required IconData icon,
    required String value,
    required Color backgroundColor,
    required Color textColor,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.42, // Adjust the width as needed
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: textColor, size: 24),
              const Spacer(),
              Text(
                value,
                style: TextStyle(
                  color: textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: textColor,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
