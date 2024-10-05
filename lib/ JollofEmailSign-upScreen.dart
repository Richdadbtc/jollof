import 'package:flutter/material.dart';

import 'JollofEmailVerificationScreen.dart';

class EmailSignUpScreen extends StatefulWidget {
  const EmailSignUpScreen({Key? key}) : super(key: key);

  @override
  _EmailSignUpScreenState createState() => _EmailSignUpScreenState();
}

class _EmailSignUpScreenState extends State<EmailSignUpScreen> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/en_flag.png', width: 30, height: 20),
          ),
          const Center(child: Text('EN', style: TextStyle(color: Colors.black))),
          const SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Please type in your email address',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'We would be verifying your email.',
              style: TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 32),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email address',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  String email = _emailController.text.trim();

                  if (email.isNotEmpty && email.contains('@')) {
                    // Navigate to EmailVerificationScreen with email
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => EmailVerificationScreen(email: email),
                      ),
                    );
                  } else {
                    // Show an error if email is invalid
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please enter a valid email address')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFC700),
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Confirm Email'),
              ),
            ),
            const Spacer(),
            Center(
              child: TextButton(
                onPressed: () {
                  // Navigate to login screen
                  print('Navigating to login screen');
                },
                child: const Text(
                  'Already have an account? Log in',
                  style: TextStyle(color: Color(0xFFFFC700)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Center(
              child: Text.rich(
                TextSpan(
                  text: 'By continuing you agree to our ',
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: 'Privacy Policy',
                      style: TextStyle(color: Color(0xFFFFC700)),
                    ),
                    TextSpan(text: ' and '),
                    TextSpan(
                      text: 'Terms and Conditions',
                      style: TextStyle(color: Color(0xFFFFC700)),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


