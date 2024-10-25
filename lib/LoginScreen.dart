import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  bool _isLoading = false;
  String? _deviceToken;
  final _storage = FlutterSecureStorage();
  final _uuid = Uuid();

  @override
  void initState() {
    super.initState();
    _getOrCreateDeviceToken();
  }

  Future<void> _getOrCreateDeviceToken() async {
    String? token = await _storage.read(key: 'device_token');
    if (token == null) {
      token = _uuid.v4(); // Generate a new UUID
      await _storage.write(key: 'device_token', value: token);
    }
    setState(() {
      _deviceToken = token;
    });
  }

  Future<void> _signIn() async {
    if (_deviceToken == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Device token not available. Please try again.')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final String apiUrl = 'https://jollof.tatspace.com/api/v1/auth/sign-in';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': _emailController.text,
          'pin': _pinController.text,
          'deviceToken': _deviceToken!,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        // Assuming the token is in the 'token' field of the response
        if (responseData['token'] != null) {
          await _saveAuthToken(responseData['token']);
          print('Login successful. Token saved.');

          // Navigate to the home screen or next appropriate screen
          Navigator.of(context).pushReplacementNamed('/home');
        } else {
          throw Exception('Token not found in the response');
        }
      } else {
        print('Login failed: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed. Please check your credentials and try again.')),
        );
      }
    } catch (e) {
      print('Error during login: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred. Please try again later.')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _saveAuthToken(String token) async {
    await _storage.write(key: 'auth_token', value: token);
  }

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
        child: ListView(
          children: [
            Text(
              'Welcome 👋',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 32),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber)
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber)
                  )
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _pinController,
              obscureText: true,
              keyboardType: TextInputType.number,
              maxLength: 4,
              decoration: InputDecoration(
                labelText: 'PIN',
                labelStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber),
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.amber)
                ),
                counterText: "",
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/reset_pin');
                },
                child: Text('Forgot your PIN?',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isLoading ? null : _signIn,
              child: _isLoading
                  ? CircularProgressIndicator(color: Colors.black)
                  : Text('Log in'),
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
                Navigator.pushNamed(context, '/register');
              },
              child: Text("Don't have an account? Register",
                style: TextStyle(color: Colors.black),),
            ),
            SizedBox(height: 16),
            Text('OR', textAlign: TextAlign.center),
            SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () {
                // TODO: Implement Facebook sign in
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
                // TODO: Implement Google sign in
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