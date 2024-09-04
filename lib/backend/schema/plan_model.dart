import 'package:cloud_firestore/cloud_firestore.dart';

class PlanModel {
  String id;
  String name;
  double totalExpenses;
  List<Map<String, dynamic>> expenses;
  bool checked;
  String userId;

  PlanModel({
    required this.id,
    required this.name,
    required this.totalExpenses,
    required this.expenses,
    this.checked = false, // default to false if not specified
    required this.userId,
  });

  // Factory method to create a PlanModel object from Firestore document
  factory PlanModel.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return PlanModel(
      id: doc.id,
      name: data['name'],
      totalExpenses: data['totalExpenses']?.toDouble() ?? 0.0,
      expenses: List<Map<String, dynamic>>.from(data['expenses'] ?? []),
      checked: data['checked'] ?? false, // Default to false if not present
      userId: data['userId'] ?? '',
    );
  }

  // Method to convert PlanModel object to Firestore-compatible Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'totalExpenses': totalExpenses,
      'expenses': expenses,
      'checked': checked,
      'userId': userId,
    };
  }
}
