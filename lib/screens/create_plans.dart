import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  Future<void> _savePlan() async {
    final String planName = _planNameController.text;

    if (planName.isNotEmpty && _expenses.isNotEmpty) {
      await FirebaseFirestore.instance.collection('plans').add({
        'name': planName,
        'totalExpenses': _totalExpenses,
        'expenses': _expenses,
      });

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Plan'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Plan Name
            TextField(
              controller: _planNameController,
              decoration: const InputDecoration(
                labelText: 'Plan Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Expense Entry
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
                      labelText: 'Amount',
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

            // Expenses List
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
                    trailing: Text('\$${expense['amount'].toStringAsFixed(2)}'),
                  );
                },
              ),
            ),

            // Total Expenses
            const SizedBox(height: 20),
            Text(
              'Total Expenses: \$${_totalExpenses.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            // Save Plan Button
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _savePlan,
                child: const Text('Save Plan'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
