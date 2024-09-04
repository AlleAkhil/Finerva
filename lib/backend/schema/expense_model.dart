import 'package:cloud_firestore/cloud_firestore.dart';

class Expense {
  String id;
  String name;
  double amount;
  DateTime date;
  String planId; // To associate the expense with a specific plan

  Expense({
    required this.id,
    required this.name,
    required this.amount,
    required this.date,
    required this.planId,
  });

  // Factory method to create an Expense object from Firestore document
  factory Expense.fromDocument(Map<String, dynamic> docData, String docId) {
    return Expense(
      id: docId,
      name: docData['name'] ?? '',
      amount: (docData['amount'] ?? 0).toDouble(),
      date: (docData['date'] as Timestamp).toDate(),
      planId: docData['planId'] ?? '',
    );
  }

  // Method to convert an Expense object to Firestore-compatible map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'amount': amount,
      'date': date,
      'planId': planId,
    };
  }
}

