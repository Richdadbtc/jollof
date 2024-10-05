import 'package:flutter/material.dart';

import 'JollofOnboardingScreen.dart';

class JollofSplashScreen extends StatefulWidget {
  const JollofSplashScreen({Key? key}) : super(key: key);

  @override
  _JollofSplashScreenState createState() => _JollofSplashScreenState();
}

class _JollofSplashScreenState extends State<JollofSplashScreen> {
  @override
  void initState() {
    super.initState();

    // Add a delay before navigating to the OnboardingScreen
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFC700), // Bright yellow background
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFFFC700),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Image.asset(
                  'assets/jollof_logo.png', // Make sure this path is correct
                  width: 140,
                  height: 140,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 20), // Adjusted space between logo and text
            Text(
              'Jollof',
              style: TextStyle(
                fontFamily: 'PoetsenOne',
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.black.withOpacity(0.1),
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


