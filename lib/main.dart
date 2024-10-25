import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jollof/Homepage/AddMoneyScreen.dart';
import 'package:jollof/Homepage/ChoosePlanScreen.dart';
import 'package:jollof/Homepage/CryptoTradingWidget.dart';
import 'package:jollof/Homepage/HelpScreen.dart';
import 'package:jollof/Homepage/InvestmentAmountScreen.dart';
import 'package:jollof/Homepage/NotificationScreen.dart';
import 'package:jollof/Homepage/PaymentInProgressScreen.dart';
import 'package:jollof/Homepage/PaymentMethodSelectionScreen.dart';
import 'package:jollof/QuestionnaireScreen.dart';
import 'GetX/UserController.dart';
import 'Homepage/JollofHomeScreen.dart';
import 'Homepage/PaymentScreen.dart';

import 'JollofSplashScreen.dart';
import 'KYC/LocationSelectionScreen.dart';
import 'WelcomeScreen.dart';
import 'Homepage/PaymentInProgressScreen.dart';
import 'Homepage/InvestmentAmountScreen.dart';
import 'Homepage/AIAdvisorScreen.dart';
import 'package:jollof/JollofVerificationSuccessScreen.dart';
import 'Homepage/HelpScreen.dart';
void main() {
  Get.put(UserController());
  Gemini.init(apiKey: 'AIzaSyA2nxR6JQ9cEqwLyDIpBN50ivvfCRdD4lY');
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
      home: JollofSplashScreen(),
    );
  }
}