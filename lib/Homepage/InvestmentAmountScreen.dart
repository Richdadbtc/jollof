import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'InvestmentBreakdownScreen.dart';

class InvestmentAmountScreen extends StatefulWidget {
  @override
  _InvestmentAmountScreenState createState() => _InvestmentAmountScreenState();
}

class _InvestmentAmountScreenState extends State<InvestmentAmountScreen> {
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Investment amount',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
        actions: [
          TextButton(
            child: Text('Help', style: TextStyle(color: Colors.amber)),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text('Enter amount', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),

            // TextField for entering amount
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              style: TextStyle(fontSize: 48),
              decoration: InputDecoration(
                prefixText: '\$',
                border: InputBorder.none,
                hintText: '0.00',
              ),
            ),

            SizedBox(height: 10),
            Text('Balance: \$800.00', style: TextStyle(color: Colors.black)),

            Spacer(),

            // Continue button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)
                ),
                backgroundColor: Colors.amber,// Full-width button
              ),
              child: Text('Continue'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChooseDurationScreen(amount: _amountController.text)),
                );
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class ChooseDurationScreen extends StatelessWidget {
  final String amount;

  ChooseDurationScreen({required this.amount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Duration',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
        actions: [
          TextButton(
            child: Text('Help', style: TextStyle(color: Colors.amber)),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(Icons.lock_clock_outlined, size: 130, color: Colors.amber),
            SizedBox(height: 25),
            Text('Choose Duration', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Text('Please choose the duration you would like your investment to last',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18)
              ),

            // Duration options
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                children: [
                  Container(
                    color: Colors.grey.shade300, // Background color for the first ListTile
                    child: ListTile(
                      title: Text('3 months at 10%'),
                      leading: Radio(
                        value: true,
                        groupValue: true,
                        onChanged: (value) {},
                      ),
                    ),
                  ),
                  SizedBox(height: 10), // Spacing between list tiles
                  Container(
                    color: Colors.grey.shade200, // Background color for the second ListTile
                    child: ListTile(
                      title: Text('6 months at 25%'),
                      leading: Radio(
                        value: false,
                        groupValue: true,
                        onChanged: (value) {},
                      ),
                    ),
                  ),
                  SizedBox(height: 10), // Spacing between list tiles
                  Container(
                    color: Colors.grey.shade100, // Background color for the third ListTile
                    child: ListTile(
                      title: Text('12 months at 50%'),
                      leading: Radio(
                        value: false,
                        groupValue: true,
                        onChanged: (value) {},
                      ),
                    ),
                  ),
                ],
              ),
            ),


            // Continue button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)
                ),
                backgroundColor: Colors.amber// Full-width button
              ),
              child: Text('Continue'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InvestmentSummaryScreen(amount: amount)),
                );
              },
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class InvestmentSummaryScreen extends StatelessWidget {
  final String amount;

  InvestmentSummaryScreen({required this.amount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Investment',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            child: Text('Help', style: TextStyle(color: Colors.amber)),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Investment duration summary
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.calendar_today, color: Colors.black54),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '3 months',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'This investment would stay for 3 months',
                            style: TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Icon(Icons.chevron_right, color: Colors.black54),
                ],
              ),
            ),

            SizedBox(height: 30),

            // Investing amount
            Center(
              child: Column(
                children: [
                  Text(
                    'Investing',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '\$$amount',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),

            // What you will get section
            Text(
              'What you will get',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10),

            // Details with icons
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  _buildSummaryTile(
                    icon: Icons.security,
                    title: '30% capital insurance',
                    subtitle: 'Your capital is partly covered',
                    trailingText: '\$75.00',
                  ),
                  Divider(),
                  _buildSummaryTile(
                    icon: Icons.monetization_on,
                    title: 'You are investing',
                    subtitle: 'For 3 months',
                    trailingText: '\$$amount',
                  ),
                  Divider(),
                  _buildSummaryTile(
                    icon: Icons.trending_up,
                    title: 'Expected interest',
                    subtitle: 'The return on your investment',
                    trailingText: '\$50.00',
                    trailingTextColor: Colors.green,
                  ),
                  Divider(),
                  _buildSummaryTile(
                    icon: Icons.percent,
                    title: 'Interest rate',
                    subtitle: 'This is the percentage of your return',
                    trailingText: '10%',
                    trailingTextColor: Colors.green
                  ),
                ],
              ),
            ),

            Spacer(),

            // Start investment button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)
                )// Full-width button
              ),
              child: Text(
                'Start with \$$amount',
                style: TextStyle(fontSize: 16),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InvestmentBreakdownScreen()),
                );
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Helper method to build summary tiles with icons
  Widget _buildSummaryTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required String trailingText,
    Color trailingTextColor = Colors.black,
  }) {
    return Row(
      children: [
        Icon(icon, color: Colors.amber, size: 30),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(subtitle, style: TextStyle(color: Colors.black54)),
            ],
          ),
        ),
        Text(
          trailingText,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: trailingTextColor,
          ),
        ),
      ],
    );
  }
}

