import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'GetX/UserController.dart';
import 'JollofVerificationSuccessScreen.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({Key? key, required String userController, required String email}) : super(key: key);

  @override
  _EmailVerificationScreenState createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final UserController userController = Get.find<UserController>();
  final List<TextEditingController> _controllers = List.generate(6, (_) => TextEditingController());
  bool _isLoading = false;
  String? _responseMessage;

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> verifyOtpCode(String otp) async {
    setState(() {
      _isLoading = true;
      _responseMessage = null;
    });

    final url = Uri.parse('https://jollof.tatspace.com/api/v1/auth/sign-up/otp/verify');
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    final body = jsonEncode({
      "email": userController.email,
      "code": otp,
    });
    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 201) {
        setState(() {
          _responseMessage = 'Verification successful.';
        });
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => EmailVerificationSuccessScreen(),
          ),
        );
      } else {
        setState(() {
          _responseMessage = 'Verification failed. Error: ${response.body}';
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

  void _verifyCode() {
    String code = _controllers.map((c) => c.text).join();

    if (code.length == 6) {
      verifyOtpCode(code);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid 6-digit code')),
      );
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
        title: Text('Verify Email',
            style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.email_outlined, size: 64, color: Color(0xFFFFC700)),
              const SizedBox(height: 24),
              const Text(
                "We've sent you an email",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Obx(() => Text(
                'Enter the code we\'ve sent by mail to\n${userController.email}',
                textAlign: TextAlign.start,
                style: const TextStyle(color: Colors.black),
              )),
              TextButton(
                onPressed: () {
                  // TODO: Implement change email functionality
                },
                child: const Text('Change email', style: TextStyle(color: Color(0xFFFFC700))),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  6,
                      (index) => SizedBox(
                    width: 50,
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amber.withOpacity(1),
                            spreadRadius: 2,
                            blurRadius: 0,
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _controllers[index],
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          counterText: '',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 2.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.amber,
                              width: 2.0,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty && index < 5) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Didn't get the email?", style: TextStyle(color: Colors.black)),
                  TextButton(
                    onPressed: () {
                      // TODO: Implement resend code functionality
                    },
                    child: const Text('Send again', style: TextStyle(color: Color(0xFFFFC700))),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              if (_isLoading)
                const Center(child: CircularProgressIndicator(color: Colors.amber))
              else
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _verifyCode,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFC700),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Verify', style: TextStyle(color: Colors.black)),
                  ),
                ),
              if (_responseMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Center(
                    child: Text(
                      _responseMessage!,
                      style: const TextStyle(color: Colors.red, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
