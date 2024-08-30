import 'package:flutter/material.dart';
import '../app_navigator.dart';

class PlanPage extends StatefulWidget {
  const PlanPage({Key? key}) : super(key: key);

  @override
  _PlanPageState createState() => _PlanPageState();
}

class _PlanPageState extends State<PlanPage> {
  int _selectedIndex = 1; // Set the initial selected index for the plan tab

  // Replace Firebase with a local list to store plans temporarily
  List<Map<String, dynamic>> _plans = [];

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });

      // Navigate to different pages based on index
      switch (index) {
        case 0:
          AppNavigator.navigateAndReplace('/home');
          break;
        case 1:
          AppNavigator.navigateAndReplace('/plan');
          break;
        case 2:
          AppNavigator.navigateAndReplace('/chart');
          break;
        case 3:
          AppNavigator.navigateAndReplace('/cards');
          break;
        case 4:
          AppNavigator.navigateAndReplace('/profile');
          break;
      }
    }
  }

  void _navigateToCreatePlan() {
    // Add logic to navigate to the plan creation page
    // This is where you'd pass the callback to add new plans to the local list
    Navigator.pushNamed(context, '/create-plan');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Plans'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            AppNavigator.navigateTo('/home'); // Navigate to the home page when back icon is pressed
          },
        ),
      ),
      body: _plans.isEmpty
          ? const Center(child: Text('No Plans'))
          : ListView.builder(
        itemCount: _plans.length,
        itemBuilder: (context, index) {
          final plan = _plans[index];
          return ListTile(
            title: Text(plan['name']),
            subtitle: Text('Total Expenses: \$${plan['totalExpenses'].toStringAsFixed(2)}'),
            onTap: () {
              // Navigate to detailed plan view (if needed)
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToCreatePlan,
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
      bottomNavigationBar: AppNavigator.buildBottomNavigationBar(_selectedIndex, _onItemTapped),
    );
  }
}
