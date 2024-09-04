import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../backend/schema/plan_model.dart';

class CreatePlanPage extends StatefulWidget {
  const CreatePlanPage({Key? key}) : super(key: key);

  @override
  _CreatePlanPageState createState() => _CreatePlanPageState();
}

class _CreatePlanPageState extends State<CreatePlanPage> {
  final TextEditingController _planNameController = TextEditingController();
  final TextEditingController _expenseNameController = TextEditingController();
  final TextEditingController _expenseAmountController = TextEditingController();
  List<Map<String, dynamic>> _expenses = [];
  double _totalExpenses = 0.0;
  PlanModel? _editingPlan; // To track if the page is in editing mode

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Check if an existing plan was passed as an argument for editing
    final PlanModel? plan = ModalRoute.of(context)?.settings.arguments as PlanModel?;
    if (plan != null) {
      _editingPlan = plan;
      _planNameController.text = plan.name;
      _totalExpenses = plan.totalExpenses;
      _expenses = List<Map<String, dynamic>>.from(plan.expenses); // Make a copy of the expenses
    }
  }

  // Function to add an expense to the list
  void _addExpense() {
    final String name = _expenseNameController.text;
    final double? amount = double.tryParse(_expenseAmountController.text);

    if (name.isNotEmpty && amount != null) {
      setState(() {
        _expenses.add({'name': name, 'amount': amount});
        _totalExpenses += amount;
      });
      _expenseNameController.clear();
      _expenseAmountController.clear();
    }
  }

  // Function to save or update the plan in Firestore
  Future<void> _savePlan() async {
    final String planName = _planNameController.text;
    final User? user = FirebaseAuth.instance.currentUser;

    if (planName.isNotEmpty && _expenses.isNotEmpty && user != null) {
      // Create a map for the plan data
      final planData = {
        'name': planName,
        'totalExpenses': _totalExpenses,
        'expenses': _expenses,
        'userId': user.uid, // Associate the plan with the logged-in user
        'createdAt': Timestamp.now(),
        'checked': _editingPlan?.checked ?? false, // Keep the checked state if editing
      };

      if (_editingPlan != null) {
        // If editing, update the existing plan in Firestore
        await FirebaseFirestore.instance.collection('plans').doc(_editingPlan!.id).update(planData);
      } else {
        // If creating a new plan, add a new document
        await FirebaseFirestore.instance.collection('plans').add(planData);
      }

      Navigator.pop(context);
    } else {
      // Handle error: show a message or alert the user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please ensure you are logged in and all fields are filled out.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_editingPlan == null ? 'Create New Plan' : 'Edit Plan'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Plan Name Input
            TextField(
              controller: _planNameController,
              decoration: const InputDecoration(
                labelText: 'Plan Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Expense Entry Section
            const Text(
              'Add Expense',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _expenseNameController,
                    decoration: const InputDecoration(
                      labelText: 'Expense Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _expenseAmountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Amount (in ₹)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _addExpense,
                  icon: const Icon(Icons.add),
                  color: Colors.blue,
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Displaying the List of Expenses
            const Text(
              'Expenses',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _expenses.length,
                itemBuilder: (context, index) {
                  final expense = _expenses[index];
                  return ListTile(
                    title: Text(expense['name']),
                    trailing: Text('₹${expense['amount'].toStringAsFixed(2)}'),
                  );
                },
              ),
            ),

            // Display Total Expenses
            const SizedBox(height: 20),
            Text(
              'Total Expenses: ₹${_totalExpenses.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            // Save or Update Plan Button
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _savePlan,
                child: Text(_editingPlan == null ? 'Save Plan' : 'Update Plan'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
