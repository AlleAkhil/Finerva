import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'home_page.dart';  // Import the HomePage

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // SVG Image at the top
              SvgPicture.asset(
                'lib/assets/images/login.svg',  // Replace with your SVG image path
                width: double.infinity,
                height: 350, // Adjust the height as needed
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 20),
              // Email and Password fields
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    // Email TextField
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        labelText: 'Email',
                        fillColor: const Color(0xFFE4E6F2),  // Set background color to #E4E6F2
                        filled: true,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Password TextField
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        labelText: 'Password',
                        fillColor: const Color(0xFFE4E6F2),  // Set background color to #E4E6F2
                        filled: true,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Sign In Button (Match Width with Fields)
                    SizedBox(
                      width: double.infinity,  // Set the button width to match the container width
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to HomePage when sign-in is successful
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const HomePage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          backgroundColor: Colors.blue[800], // Set button color to blue[800]
                        ),
                        child: const Text(
                          'Sign In',
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
              // Forgot Password
              TextButton(
                onPressed: () {
                  // Handle forgot password
                },
                child: const Text('Forgot password?'),
              ),
              const SizedBox(height: 20),
              // Social Sign In Buttons (Icon-only buttons with larger icon size)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Container(
                      color: Colors.white,  // Set background color for better visibility of the icon
                      width: 60,
                      height: 60,  // Make the button a circle
                      child: Center(
                        child: SignInButton(
                          Buttons.Google,
                          text: '',  // Remove text, only show the icon
                          onPressed: () {
                            // Handle Google Sign-In
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ClipOval(
                    child: Container(
                      color: Colors.white,  // Set background color for better visibility of the icon
                      width: 60,
                      height: 60,  // Make the button a circle
                      child: Center(
                        child: SignInButton(
                          Buttons.Facebook,
                          text: '',  // Remove text, only show the icon
                          onPressed: () {
                            // Handle Facebook Sign-In
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Sign Up Text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? "),
                  TextButton(
                    onPressed: () {
                      // Navigate to sign-up screen
                    },
                    child: const Text('Sign Up'),
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
