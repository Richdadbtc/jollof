import 'package:flutter/material.dart';
import 'package:jollof/Homepage/JollofHomeScreen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Welcome',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back navigation
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            Image.asset(
              'assets/welcome_image.png',
              height: 200,
            ),
            SizedBox(height: 20),
            Text(
              'Welcome to Jollof',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              'What do you want to do with Jollof?',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            FinancialTopicTile(
              icon: Icons.list_alt_outlined,
              title: 'Build my porfolio',
              subtitle: 'Let Ai trade for you while you sleep',
              onTap: () {
                // Navigate to budgeting screen
              },
            ),
            FinancialTopicTile(
              icon: Icons.savings,
              title: 'Invest in mutual fund',
              subtitle: 'Earn upto 55% fixed return',
              onTap: () {
                // Navigate to saving screen
              },
            ),
            FinancialTopicTile(
              icon: Icons.wallet,
              title: 'Fund my wallet',
              subtitle: 'Add some money into you wallet',
              onTap: () {
                // Navigate to investing screen
              },
            ),
            Spacer(),
            ElevatedButton(
              child: Text('Skip'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black, backgroundColor: Colors.amber,
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)
                )
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MainApp(),
                  ),
                );
                // Handle skip action
              },
            ),
          ],
        ),
      ),
    );
  }
}

class FinancialTopicTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const FinancialTopicTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}