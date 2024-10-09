import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
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
              'Welcome Chris Uche',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              'What financial topic would you like to explore?',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            FinancialTopicTile(
              icon: Icons.account_balance,
              title: 'Budgeting Basics',
              subtitle: 'Learn to create and stick to a budget',
              onTap: () {
                // Navigate to budgeting screen
              },
            ),
            FinancialTopicTile(
              icon: Icons.savings,
              title: 'Saving Strategies',
              subtitle: 'Discover effective ways to save money',
              onTap: () {
                // Navigate to saving screen
              },
            ),
            FinancialTopicTile(
              icon: Icons.school,
              title: 'Investing 101',
              subtitle: 'Understand the basics of safe investing',
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