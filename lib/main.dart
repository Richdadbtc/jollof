import 'package:flutter/material.dart';
import 'package:jollof/QuestionnaireScreen.dart';
import 'JollofSplashScreen.dart';
import 'AllowNotificationScreen.dart';
import 'LoginScreen.dart';
import 'ResetPasswordScreenwithOTPPopup.dart';
import 'verify_otp_screen.dart';
import 'New_Password_Screen.dart';
import 'Homepage/JollofHomeScreen.dart';
import 'QuestionnaireScreen.dart';
import 'ExplainerScreen.dart';
import 'WelcomeScreen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jollof App',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: WelcomeScreen(),
    );
  }
}
