import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../app_navigator.dart';
import '../backend/schema/plan_model.dart';

class PlanPage extends StatefulWidget {
  const PlanPage({Key? key}) : super(key: key);

  @override
  _PlanPageState createState() => _PlanPageState();
}

class _PlanPageState extends State<PlanPage> {
  int _selectedIndex = 1; // Set the initial selected index for the plan tab
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Fetch plans from Firestore
  Stream<List<PlanModel>> _getPlansStream() {
    final User? user = _auth.currentUser;
    if (user != null) {
      return FirebaseFirestore.instance
          .collection('plans')
          .where('userId', isEqualTo: user.uid)
          .snapshots()
          .map((snapshot) => snapshot.docs
          .map((doc) => PlanModel.fromDocument(doc))
          .toList());
    } else {
      return const Stream.empty();
    }
  }

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
    // Navigate to the plan creation page
    Navigator.pushNamed(context, '/create-plan');
  }

  // Method to toggle the checked state of a plan
  void _toggleChecked(PlanModel plan) async {
    await FirebaseFirestore.instance.collection('plans').doc(plan.id).update({
      'checked': !plan.checked, // Toggle the checked field
    });
  }

  // Method to delete a plan
  void _deletePlan(String planId) async {
    await FirebaseFirestore.instance.collection('plans').doc(planId).delete();
  }

  // Method to edit a plan
  void _editPlan(PlanModel plan) {
    // Navigate to the create plan page with the plan details
    Navigator.pushNamed(
      context,
      '/create-plan',
      arguments: plan, // Pass the plan object as an argument
    );
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
      body: StreamBuilder<List<PlanModel>>(
        stream: _getPlansStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No Plans'));
          }

          final List<PlanModel> plans = snapshot.data!;

          return ListView.builder(
            itemCount: plans.length,
            itemBuilder: (context, index) {
              final plan = plans[index];
              final isChecked = plan.checked;

              return Container(
                color: isChecked ? Colors.green.shade100 : null, // Highlight the checked plan
                child: ListTile(
                  leading: Checkbox(
                    value: isChecked,
                    onChanged: (bool? newValue) {
                      _toggleChecked(plan); // Toggle the checked status
                    },
                  ),
                  title: Text(plan.name),
                  subtitle: Text('Total Expenses: ₹${plan.totalExpenses.toStringAsFixed(2)}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          _editPlan(plan); // Navigate to the edit plan functionality
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          _deletePlan(plan.id);
                        },
                      ),
                    ],
                  ),
                  onTap: () {
                    // Show plan details in a dialog (if needed)
                  },
                ),
              );
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
