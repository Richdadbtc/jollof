import 'dart:convert'; // For encoding JSON
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'JollofEmailVerificationScreen.dart';

class EmailSignUpScreen extends StatefulWidget {
  const EmailSignUpScreen({Key? key}) : super(key: key);

  @override
  _EmailSignUpScreenState createState() => _EmailSignUpScreenState();
}

class _EmailSignUpScreenState extends State<EmailSignUpScreen> {
  final _emailController = TextEditingController();
  bool _isLoading = false; // To show a loading indicator
  String? _responseMessage; // To display any error or success messages

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  // Function to handle Sign-Up Request
  Future<void> signUpUser(String email) async {
    setState(() {
      _isLoading = true;
      _responseMessage = null;
    });

    final url = Uri.parse('https://jollof.tatspace.com/api/v1/auth/sign-up');
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    final body = jsonEncode({
      "email": email,
      "deviceToken": "7t8y88trf"
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200|| response.statusCode==201) {
        print(response.body);
        // If sign-up is successful
        setState(() {
          _responseMessage = 'Sign-up successful. OTP sent to your email.';
          // Navigate to EmailVerificationScreen with email

        });
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => EmailVerificationScreen(email: email),
          ),
        );
      } else {
        print(response.statusCode);
        setState(() {
          _responseMessage = 'Sign-up failed. Error: ${response.body}';
        });
      }
    } catch (error) {
      setState(() {
        _responseMessage = 'An error occurred: $error';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
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
              decoration: InputDecoration(
                labelText: 'Email address',
                labelStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber)
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber)
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber)
                )
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 24),
            _isLoading
                ? Center(child: CircularProgressIndicator(color: Colors.amber,)) // Show loading indicator while requesting OTP
                : SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  String email = _emailController.text.trim();

                  if (email.isNotEmpty && email.contains('@')) {
                    // Call the sign-up function when email is valid
                    signUpUser(email);
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
            if (_responseMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Center(
                  child: Text(
                    _responseMessage!,
                    style: TextStyle(color: Colors.red, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
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
