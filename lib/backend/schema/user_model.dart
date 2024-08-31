import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel with ChangeNotifier {
  String? _uid;
  String? _name;
  String? _email;
  String? _phone;
  String? _photoUrl;
  DateTime? _createdTime;

  // Getters
  String? get uid => _uid;
  String? get name => _name;
  String? get email => _email;
  String? get phone => _phone;
  String? get photoUrl => _photoUrl;
  DateTime? get createdTime => _createdTime;

  // Setters
  void setUser(User? user, {String? phone, DateTime? createdTime, String? photoUrl}) {
    if (user != null) {
      _uid = user.uid;
      _name = user.displayName;
      _email = user.email;
      _phone = phone;
      _createdTime = createdTime;
      _photoUrl = photoUrl ?? user.photoURL;
      notifyListeners();
    }
  }
}
