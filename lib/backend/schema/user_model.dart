import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel with ChangeNotifier {
  String? _uid;
  String? _name;
  String? _email;
  int? _phone;
  String? _photoUrl;
  DateTime? _createdTime;

  // Getters
  String? get uid => _uid;
  String? get name => _name;
  String? get email => _email;
  int? get phone => _phone;
  String? get photoUrl => _photoUrl;
  DateTime? get createdTime => _createdTime;

  // Method to set the user data
  void setUser(User user, {String? phone, DateTime? createdTime, String? photoUrl}) {
    _uid = user.uid;
    _name = user.displayName ?? ''; // Fetch from FirebaseAuth or Firestore
    _email = user.email;
    _phone = int.tryParse(phone ?? '') ?? 0; // Ensure phone is an integer
    _photoUrl = photoUrl ?? user.photoURL ?? ''; // Use provided or fallback to FirebaseAuth photo URL
    _createdTime = createdTime ?? DateTime.now(); // Default to now if not provided

    notifyListeners();
  }

  // Fetch data from Firestore
  Future<void> fetchUserDataFromFirestore() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot<Map<String, dynamic>> doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (doc.exists) {
          _uid = doc.data()?['uid'];
          _name = doc.data()?['name'];
          _email = doc.data()?['email'];
          _phone = (doc.data()?['phone'] as num?)?.toInt(); // Ensure phone is an integer
          _photoUrl = doc.data()?['photo_url'];
          _createdTime = (doc.data()?['created_time'] as Timestamp?)?.toDate();

          notifyListeners();
        }
      } catch (e) {
        // Handle error
        print("Error fetching user data from Firestore: $e");
      }
    }
  }
}
