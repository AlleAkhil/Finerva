import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart'; // Import Firebase Storage
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart'; // Import Image Picker
import 'dart:io'; // Import Dart IO for File
import 'package:flutter/services.dart'; // Import for TextInputFormatter
import 'home_page.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  bool _isEmailValid(String email) {
    // Basic email format validation using a regular expression
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  bool _isPhoneNumberValid(String phone) {
    // Check if the phone number is exactly 10 digits
    return phone.length == 10 && RegExp(r'^[0-9]+$').hasMatch(phone);
  }

  void _validateAndProceed() {
    if (!_isEmailValid(_emailController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid email address.')),
      );
      return;
    }

    if (!_isPhoneNumberValid(_phoneController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid 10-digit phone number.')),
      );
      return;
    }

    // If validation passes, proceed with signup
    _signup();
  }

  void _signup() async {
    try {
      // Create a new user
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Get the current time
      Timestamp createdTime = Timestamp.now();

      // Upload the selected image to Firebase Storage and get the download URL
      String? downloadUrl;
      if (_selectedImage != null) {
        downloadUrl = await _uploadImageToFirebase(_selectedImage!, userCredential.user!.uid);
      }

      // Save user details to Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'name': _nameController.text,
        'email': _emailController.text,
        'phone': int.parse(_phoneController.text), // Convert phone to number
        'photo_url': downloadUrl ?? '', // Store the download URL or empty string if null
        'created_time': createdTime, // Store as Firestore timestamp
      });

      // Navigate to HomePage after successful signup
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } catch (e) {
      // Show error message if signup fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  Future<String?> _uploadImageToFirebase(File imageFile, String uid) async {
    try {
      // Create a reference to Firebase Storage
      final storageRef = FirebaseStorage.instance.ref().child('profile_images/$uid.jpg');

      // Upload the file to Firebase Storage
      final uploadTask = storageRef.putFile(imageFile);

      // Wait for the upload to complete and get the download URL
      final snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // SVG Image at the top (Reuse the one from LoginScreen)
              SvgPicture.asset(
                'lib/assets/images/signup.svg', // Replace with your SVG image path
                width: double.infinity,
                height: 350, // Adjust the height as needed
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 20),
              // Name, Email, Password, and Phone fields
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    // Display selected image
                    if (_selectedImage != null)
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: FileImage(_selectedImage!),
                      ),
                    TextButton.icon(
                      onPressed: _pickImage,
                      icon: const Icon(Icons.camera_alt),
                      label: const Text("Pick Profile Image"),
                    ),
                    const SizedBox(height: 20),
                    // Name TextField
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        labelText: 'Name',
                        fillColor: const Color(0xFFE4E6F2), // Set background color to #E4E6F2
                        filled: true,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Email TextField
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        labelText: 'Email',
                        fillColor: const Color(0xFFE4E6F2), // Set background color to #E4E6F2
                        filled: true,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Password TextField
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        labelText: 'Password',
                        fillColor: const Color(0xFFE4E6F2), // Set background color to #E4E6F2
                        filled: true,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Phone TextField
                    TextField(
                      controller: _phoneController,
                      keyboardType: TextInputType.number, // Ensure number keyboard
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly, // Allow only digits
                        LengthLimitingTextInputFormatter(10),   // Limit to 10 digits
                      ],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        labelText: 'Phone',
                        fillColor: const Color(0xFFE4E6F2), // Set background color to #E4E6F2
                        filled: true,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Sign Up Button (Match Width with Fields)
                    SizedBox(
                      width: double.infinity, // Set the button width to match the container width
                      child: ElevatedButton(
                        onPressed: _validateAndProceed,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          backgroundColor: Colors.blue[800], // Set button color to blue[800]
                        ),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              // Already have an account? Login
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? "),
                  TextButton(
                    onPressed: () {
                      // Navigate back to login screen
                      Navigator.pop(context);
                    },
                    child: const Text('Login'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
