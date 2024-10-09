import 'package:flutter/material.dart';

class VerifyOTPScreen extends StatefulWidget {
  final String email;

  const VerifyOTPScreen({Key? key, required this.email}) : super(key: key);

  @override
  _VerifyOTPScreenState createState() => _VerifyOTPScreenState();
}

class _VerifyOTPScreenState extends State<VerifyOTPScreen> {
  final List<TextEditingController> _controllers = List.generate(4, (_) => TextEditingController());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _verifyCode() {
    String code = _controllers.map((c) => c.text).join();
    // TODO: Implement actual verification logic
    print('Verifying code: $code');

    // For demonstration, we'll assume the code is correct if all fields are filled
    if (code.length == 4) {
      // Navigate to the success screen (you'll need to create this screen)
      // Navigator.of(context).push(
      //   MaterialPageRoute(
      //     builder: (context) => VerificationSuccessScreen(),
      //   ),
      // );
      print('Code verified successfully');
    } else {
      // Show an error message if the code is incomplete
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid 4-digit code')),
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
        title: const Text('Verify OTP', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.mail_outline, size: 64, color: Color(0xFFFFC700)),
            const SizedBox(height: 24),
            const Text(
              "Verify the OTP sent to you",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'Enter the code we\'ve sent by mail to\n${widget.email}',
              textAlign: TextAlign.start,
              style: const TextStyle(color: Colors.black),
            ),
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
                4,
                    (index) => SizedBox(
                  width: 50,
                  child: TextField(
                    controller: _controllers[index],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    decoration: InputDecoration(
                      counterText: '',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty && index < 3) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
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
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _verifyCode,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFFC700),
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Verify', style: TextStyle(color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}