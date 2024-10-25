import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'PaymentScreen.dart';

class PaymentMethodScreen extends StatefulWidget {
  @override
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  bool _defaultForFutureDeposit = false;

  // Payment method navigation handlers
  void _handleApplePay() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DummyPaymentScreen(paymentMethod: 'Apple Pay'),
      ),
    );
  }

  void _handlePayPal() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DummyPaymentScreen(paymentMethod: 'PayPal'),
      ),
    );
  }

  void _handleBankTransfer() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Paymentscreen(),
      ),
    );
  }

  void _handleDebitCard() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DummyPaymentScreen(paymentMethod: 'Debit Card'),
      ),
    );
  }

  void _handleCryptoDeposit() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DummyPaymentScreen(paymentMethod: 'Crypto'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Payment method',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          TextButton(
            child: Text('Skip',
              style: TextStyle(
                color: Colors.amber,
                fontWeight: FontWeight.w600,
              ),
            ),
            onPressed: () => Navigator.pop(context),
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
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.amber[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Experience the future of crypto investing with Jollof '
                      'by funding your wallet and activating our AI-'
                      'Managed Portfolio feature. Our advanced algorithms '
                      'ensure smart decision-making, risk management, '
                      'and 24/7 monitoring, allowing you to effortlessly '
                      'optimise your crypto portfolio for maximum returns.',
                  style: TextStyle(
                    color: Colors.black87,
                    height: 1.5,
                  ),
                ),
              ),
              SizedBox(height: 24),
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.white!),
                ),
                child: Column(
                  children: [
                    _buildPaymentOption(
                      icon: 'assets/apple_pay_icon.png',
                      title: 'Apple Pay',
                      subtitle: 'Pay with Apple Pay',
                      onTap: _handleApplePay,
                    ),
                    Divider(height: 1),
                    _buildPaymentOption(
                      icon: 'assets/paypal_icon.png',
                      title: 'PayPal',
                      subtitle: 'Pay with PayPal',
                      onTap: _handlePayPal,
                    ),
                    Divider(height: 1),
                    _buildPaymentOption(
                      icon: Icons.compare_arrows,
                      title: 'Bank Transfer',
                      subtitle: 'Funds will arrive within an hour',
                      onTap: _handleBankTransfer,
                    ),
                    Divider(height: 1),
                    _buildPaymentOption(
                      icon: Icons.credit_card,
                      title: 'Debit Card',
                      subtitle: 'Pay with your debit card',
                      onTap: _handleDebitCard,
                    ),
                    Divider(height: 1),
                    _buildPaymentOption(
                      icon: Icons.currency_bitcoin,
                      title: 'Deposit Crypto',
                      subtitle: 'Fund wallet with fiat or crypto currency',
                      onTap: _handleCryptoDeposit,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Default this for future deposit',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
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
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: ListTile(
          leading: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.amber[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: icon is IconData
                ? Icon(icon, color: Colors.black)
                : Image.asset(icon, width: 24, height: 24),
          ),
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
          trailing: Icon(
            Icons.chevron_right,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

// Dummy payment screen for demonstration
class DummyPaymentScreen extends StatelessWidget {
  final String paymentMethod;

  const DummyPaymentScreen({Key? key, required this.paymentMethod}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$paymentMethod Payment'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Processing $paymentMethod',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}