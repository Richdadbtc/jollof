import 'package:flutter/material.dart';
import 'package:jollof/JollofWelcomeScreen.dart';
import 'package:jollof/JollofOnboardingScreen.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/en_flag.png', width: 24, height: 24),
            SizedBox(width: 8),
            Text('EN'),
          ],
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView( // Wrap Column with ListView
          children: [
            Text(
              'Welcome 👋',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 32),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                suffixText: 'Show',
                suffixStyle: TextStyle(color: Colors.amber),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/reset_password');
                  // Handle forgot password
                },
                child: Text('Forgot your password'),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Handle login
              },
              child: Text('Log in'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Color(0xFFFFC700),
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextButton(
              onPressed: () {
                // Handle registration
              },
              child: Text("Don't have an account ? Register",
              style: TextStyle(color: Colors.black),),
            ),
            SizedBox(height: 16),
            Text('OR', textAlign: TextAlign.center),
            SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => OnboardingScreen()));
                // Handle Facebook sign in
              },
              icon: Image.asset('assets/facebook_logo.png', width: 24, height: 24),
              label: Text('Sign in with Facebook',
              style: TextStyle(color: Colors.black),),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: () {
                // Handle Google sign in
              },
              icon: Image.asset('assets/google_logo.png', width: 24, height: 24),
              label: Text('Sign in with Google',
              style: TextStyle(color: Colors.black),),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 32),
            Text(
              'By continuing you agree to our Privacy Policy and Terms and Conditions',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
