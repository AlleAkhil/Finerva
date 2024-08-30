import 'package:finerva/screens/create_plans.dart';
import 'package:finerva/screens/plans_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/pre_login.dart';
import 'screens/login_page.dart';
import 'screens/home_page.dart';
import 'screens/stats_page.dart';
import 'screens/cards_page.dart';
import 'screens/profile_page.dart'; // Import the ProfilePage
import 'app_navigator.dart'; // Import the AppNavigator

void main(){
  runApp(MyApp());
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
        '/plan': (context) => const PlanPage(),
        '/create-plan': (context) => const CreatePlanPage(),
        '/chart': (context) => const StatsPage(),
        '/cards': (context) => const CardsPage(),
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
