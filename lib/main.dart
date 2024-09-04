import 'package:finerva/screens/create_plans.dart';
import 'package:finerva/screens/plans_page.dart';
import 'package:finerva/screens/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';  // Import the provider package
import 'backend/schema/user_model.dart';
import 'firebase_options.dart';
import 'screens/pre_login.dart';
import 'screens/login_page.dart';
import 'screens/home_page.dart';
import 'screens/stats_page.dart';
import 'screens/cards_page.dart';
import 'screens/profile_page.dart';
import 'screens/plans_page.dart';

import 'app_navigator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserModel()),  // Provide UserModel here
      ],
      child: const MyApp(),
    ),
  );
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
      navigatorKey: AppNavigator.navigatorKey,
      initialRoute: FirebaseAuth.instance.currentUser == null ? '/' : '/home',
      routes: {
        '/': (context) => const PreLoginScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/home': (context) => const HomePage(),
        '/plan': (context) => const PlanPage(),
        '/create-plan': (context) => const CreatePlanPage(),
        '/chart': (context) => const StatsPage(),
        '/cards': (context) => const CardsPage(),
        '/profile': (context) => const ProfilePage(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(child: Text('Page not found')),
          ),
        );
      },
    );
  }
}
