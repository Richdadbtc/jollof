import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'InvestmentAmountScreen.dart';

class InvestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select how to pay',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 15,
            backgroundImage: AssetImage('assets/profile_pic.jpeg'),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text('Help', style: TextStyle(color: Colors.amber)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            Center(
              child: Image.asset(
                'assets/wallet_image.png',
                height: 120,
              ),
            ),
            SizedBox(height: 40),
            Text(
              'I want to pay from',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Please select how you would wish to fund your investment. You can choose from your wallet or from an external wallet.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(height: 120),
            _buildPaymentOption(
              context,
              'Wallet',
              'Your balance is',
              '\$0.00',
              Icons.account_balance_wallet_outlined,
              true,
            ),
            SizedBox(height: 10),
            _buildPaymentOption(
              context,
              'USDT',
              'Fund from an external wallet',
              '',
              Icons.credit_card,
              false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption(BuildContext context, String title, String subtitle, String amount, IconData icon, bool isWallet) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.black),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(amount, style: TextStyle(fontWeight: FontWeight.bold)),
            Icon(Icons.chevron_right),
          ],
        ),
        onTap: () {
          if (isWallet) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => InvestmentAmountScreen()),
            );
          } else {
            // Handle USDT option
            print('USDT option selected');
          }
        },
      ),
    );
  }
}

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
        title: Text(
          'Investment amount',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
            SizedBox(height: 20),
            Center(
              child: Text(
                'Enter amount',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),

            // Center the TextField
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '\$',
                    style: TextStyle(fontSize: 48, color: Colors.grey),
                  ),
                  SizedBox(
                    width: 200, // Adjust width as needed
                    child: TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      textAlign: TextAlign.left,  // Center-align the input text
                      style: TextStyle(fontSize: 48, color: Colors.black, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '0.00',
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10),

            // Center-align the balance text
            Center(
              child: Text(
                'Balance: \$800.00',
                style: TextStyle(color: Colors.black),
              ),
            ),

            Spacer(),

            // Full-width Continue button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: Colors.amber,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)
                )// Full-width button
              ),
              child: Text('Continue',
              style: TextStyle(color: Colors.black),),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChooseDurationScreen(amount: _amountController.text),
                  ),
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





