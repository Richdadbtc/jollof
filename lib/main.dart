import 'package:flutter/material.dart';

import 'JollofSplashScreen.dart';

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
        primarySwatch: Colors.orange,
      ),
      home: const JollofSplashScreen(),
    );
  }
}