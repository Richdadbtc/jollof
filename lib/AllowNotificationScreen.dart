import 'package:flutter/material.dart';
import 'package:jollof/LoginScreen.dart';
import 'package:permission_handler/permission_handler.dart';

import 'CreatePinScreen.dart';
import 'JollofWelcomeScreen.dart';

class AllowNotificationScreen extends StatelessWidget {
  const AllowNotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Allow Notification',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Stay up-to-date with the latest updates on your investment anytime.',
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            Expanded(
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/bell.png',
                      width: 170,
                      height: 170,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                PermissionStatus status = await Permission.notification.request();
                if (status.isGranted) {
                  print('Notification permission granted');
                  Navigator.pushReplacementNamed(context, '/login');
                } else {
                  print('Notification permission denied');
                  // You might want to show a dialog explaining why notifications are important
                }
              },
              child: Text(
                'Allow Notification',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: TextButton(
                onPressed: () {
                  // Navigate to login screen when skipped
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => LoginScreen()));
                },

                child: Text(
                  'Skip for now',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
