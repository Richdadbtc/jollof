import 'package:flutter/material.dart';
import 'package:jollof/Homepage/AddMoneyScreen.dart';
import 'package:jollof/Homepage/ChoosePlanScreen.dart';
import 'package:jollof/Homepage/InvestmentAmountScreen.dart';
import 'package:jollof/Homepage/PaymentInProgressScreen.dart';
import 'package:jollof/Homepage/PaymentMethodSelectionScreen.dart';
import 'Homepage/JollofHomeScreen.dart';
import 'Homepage/PaymentScreen.dart';

import 'JollofSplashScreen.dart';
import 'KYC/LocationSelectionScreen.dart';
import 'WelcomeScreen.dart';
import 'Homepage/PaymentInProgressScreen.dart';
import 'Homepage/InvestmentAmountScreen.dart';

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
      home: LocationSelectionScreen(),
    );
  }
}