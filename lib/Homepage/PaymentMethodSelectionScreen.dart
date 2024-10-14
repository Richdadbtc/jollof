import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class PaymentMethodScreen extends StatefulWidget {
  @override
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  bool _defaultForFutureDeposit = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Payment method'),
        actions: [
          TextButton(
            child: Text('Skip', style: TextStyle(color: Colors.amber)),
            onPressed: () {
              // Handle skip action
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select how you would fund your wallet',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                'Experience the future of crypto investing with Jollof '
                    'by funding your wallet and activating our AI-'
                    'Managed Portfolio feature. Our advanced algorithms '
                    'ensure smart decision-making, risk management, '
                    'and 24/7 monitoring, allowing you to effortlessly '
                    'optimise your crypto portfolio for maximum returns.',
                style: TextStyle(color: Colors.grey[600]),
              ),
              SizedBox(height: 24),
              _buildPaymentOption(
                icon: 'assets/apple_pay_icon.png',
                title: 'Apple pay',
                subtitle: 'Pay with Apple pay',
              ),
              _buildPaymentOption(
                icon: 'assets/paypal_icon.png',
                title: 'PayPal',
                subtitle: 'Pay with PayPal',
              ),
              _buildPaymentOption(
                icon: Icons.compare_arrows,
                title: 'Pay with Bank Transfer',
                subtitle: 'Funds will arrive within an hour',
              ),
              _buildPaymentOption(
                icon: Icons.credit_card,
                title: 'Debit card',
                subtitle: 'Pay with your debit card',
              ),
              _buildPaymentOption(
                icon: Icons.currency_bitcoin,
                title: 'Deposit crypto',
                subtitle: 'Fund wallet with fiat or crypto currency',
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Default this for future deposit'),
                  CupertinoSwitch(
                    value: _defaultForFutureDeposit,
                    onChanged: (bool value) {
                      setState(() {
                        _defaultForFutureDeposit = value;
                      });
                    },
                    activeColor: Colors.green,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentOption({
    required dynamic icon,
    required String title,
    required String subtitle,
  }) {
    return ListTile(
      leading: icon is IconData
          ? Icon(icon)
          : Image.asset(icon, width: 24, height: 24),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Icon(Icons.chevron_right),
      onTap: () {
        // Handle payment option selection
      },
    );
  }
}