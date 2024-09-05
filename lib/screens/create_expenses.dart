import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateExpensePage extends StatefulWidget {
  const CreateExpensePage({super.key});

  @override
  _CreateExpensePageState createState() => _CreateExpensePageState();
}

class _CreateExpensePageState extends State<CreateExpensePage> {
  final TextEditingController _expenseNameController = TextEditingController();
  final TextEditingController _expenseAmountController = TextEditingController();
  String? _selectedPlanId; // Selected plan ID

  // Function to save the expense to Firestore
  Future<void> _saveExpense() async {
    final String name = _expenseNameController.text;
    final double? amount = double.tryParse(_expenseAmountController.text);

    if (name.isNotEmpty && amount != null && _selectedPlanId != null) {
      await FirebaseFirestore.instance.collection('expenses').add({
        'name': name,
        'amount': amount,
        'planId': _selectedPlanId, // Link the expense to the selected plan
        'createdAt': Timestamp.now(),
      });

      Navigator.pop(context); // Go back to the previous screen
    }
  }

  // Fetch available plans from Firestore
  Stream<List<Map<String, dynamic>>> _getPlansStream() {
    return FirebaseFirestore.instance.collection('plans').snapshots().map(
          (snapshot) => snapshot.docs
          .map((doc) => {
        'id': doc.id,
        'name': doc['name'],
      })
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Add Expense'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dropdown to select the plan
            StreamBuilder<List<Map<String, dynamic>>>(
              stream: _getPlansStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('No plans available');
                }
                final plans = snapshot.data!;
                return DropdownButton<String>(
                  hint: const Text('Select Plan'),
                  value: _selectedPlanId,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedPlanId = newValue;
                    });
                  },
                  items: plans.map<DropdownMenuItem<String>>((plan) {
                    return DropdownMenuItem<String>(
                      value: plan['id'],
                      child: Text(plan['name']),
                    );
                  }).toList(),
                );
              },
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _expenseNameController,
              decoration: const InputDecoration(
                labelText: 'Expense Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _expenseAmountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Amount (in ₹)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _saveExpense,
                child: const Text('Save Expense'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
