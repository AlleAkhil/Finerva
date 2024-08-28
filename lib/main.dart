import 'package:flutter/material.dart';
import 'screens/pre_login.dart';
import 'screens/login_page.dart';
import 'screens/home_page.dart';
import 'screens/profile_page.dart'; // Import the ProfilePage
import 'app_navigator.dart'; // Import the AppNavigator

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finerva',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      navigatorKey: AppNavigator.navigatorKey, // Set the global navigator key
      initialRoute: '/', // Set the PreLoginScreen as the initial route
      routes: {
        '/': (context) => const PreLoginScreen(), // PreLoginScreen as the start
        '/login': (context) => const LoginScreen(), // Define the login route
        '/home': (context) => const HomePage(), // Home Page route
        '/profile': (context) => const ProfilePage(), // Profile Page route
        // Add other routes as needed (e.g., signup screen)
      },
      onUnknownRoute: (settings) {
        // Handle undefined routes
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(child: Text('Page not found')),
          ),
        );
      },
    );
  }
}
