import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../app_navigator.dart';
import 'create_expenses.dart'; // Import CreateExpensePage

class ExpensesPage extends StatefulWidget {
  const ExpensesPage({super.key});

  @override
  _ExpensesPageState createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  int _selectedIndex = 2;

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
          AppNavigator.navigateTo('/expenses');
          break;
        case 3:
          AppNavigator.navigateTo('/stats');
          break;
        case 4:
          AppNavigator.navigateTo('/profile');
          break;
      }
    }
  }

  // Fetch expenses from Firestore
  Stream<List<Map<String, dynamic>>> _getExpensesStream() {
    return FirebaseFirestore.instance.collection('expenses').snapshots().map(
          (snapshot) => snapshot.docs.map((doc) {
        final data = doc.data();
        return {
          'name': data['name'],
          'amount': data['amount'],
          'planId': data['planId'],
          'createdAt': data['createdAt'],
        };
      }).toList(),
    );
  }

  // Fetch plan name using planId
  Future<String> _getPlanName(String planId) async {
    final planDoc = await FirebaseFirestore.instance.collection('plans').doc(planId).get();
    return planDoc.data()?['name'] ?? 'Unknown Plan';
  }

  // Format timestamp to readable date
  String _formatDate(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    return "${dateTime.day}-${dateTime.month}-${dateTime.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Expenses'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            AppNavigator.goBack();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<List<Map<String, dynamic>>>(
          stream: _getExpensesStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No Expenses Found'));
            }
            final expenses = snapshot.data!;
            return ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                final expense = expenses[index];
                return FutureBuilder<String>(
                  future: _getPlanName(expense['planId']),
                  builder: (context, planSnapshot) {
                    if (planSnapshot.connectionState == ConnectionState.waiting) {
                      return const ListTile(
                        title: Text('Loading Plan...'),
                      );
                    }
                    final planName = planSnapshot.data ?? 'Unknown Plan';
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 2.0,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  expense['name'],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87, // Darker text color for better visibility
                                  ),
                                ),
                                Text(
                                  '₹${expense['amount'].toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Plan: $planName',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black87, // Darker text color for better visibility
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Date: ${_formatDate(expense['createdAt'])}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87, // Darker text color for better visibility
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the create expense page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateExpensePage()),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
      bottomNavigationBar: AppNavigator.buildBottomNavigationBar(_selectedIndex, _onItemTapped),
    );
  }
}
