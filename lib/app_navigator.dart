import 'package:flutter/material.dart';

class AppNavigator {
  // Create a GlobalKey for the Navigator
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // Define navigation methods
  static Future<dynamic> navigateTo(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!.pushNamed(routeName, arguments: arguments);
  }

  static Future<dynamic> navigateAndReplace(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!.pushReplacementNamed(routeName, arguments: arguments);
  }

  static void goBack() {
    return navigatorKey.currentState!.pop();
  }

  // Method to build the bottom navigation bar
  static Widget buildBottomNavigationBar(int selectedIndex, ValueChanged<int> onTap) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (index) {
        if (index != selectedIndex) {
          onTap(index);
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),    // Home icon for home page
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),  // Search icon for search functionality
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.attach_money),  // New icon for expenses page
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.pie_chart),  // Chart icon for statistics
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),  // Profile icon for user profile
          label: '',
        ),
      ],
      selectedItemColor: const Color(0xFF000000),
      unselectedItemColor: const Color(0xFF647987),
    );
  }
}
