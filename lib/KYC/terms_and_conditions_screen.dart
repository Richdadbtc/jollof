import 'package:flutter/material.dart';
import 'package:jollof/Homepage/JollofHomeScreen.dart';

class TermsAndConditionsScreen extends StatefulWidget {
  const TermsAndConditionsScreen({Key? key}) : super(key: key);

  @override
  _TermsAndConditionsScreenState createState() => _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
  bool _isAgreed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Terms and Conditions',
          style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.card_giftcard, color: Colors.black),
            onPressed: () {
              // Handle gift action
            },
          ),
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications, color: Colors.black),
                onPressed: () {
                  // Handle notification action
                },
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Introduction: Cryptocurrency markets are dynamic, constantly evolving to meet the demands and preferences of traders. In the latest development, a set of new trading pairs has been introduced, allowing users to trade CDCETH with PYUSD, USDT, and USD. This addition not only expands the trading options but also introduces more flexibility and opportunities for crypto enthusiasts.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Diversifying Trading Pairs: One of the key aspects of a thriving cryptocurrency exchange is the variety of trading pairs it offers. The introduction of CDCETH paired with PYUSD, USDT, and USD brings diversity to the trading ecosystem. Traders can now explore different strategies, take advantage of market trends, and diversify their portfolios with these new pairings.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'CDCETH and PYUSD:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              'This pairing enables traders to exchange Crypto.com Coin (CDC) with Ethereum (ETH) while introducing the stability of PYUSD, a crypto-backed stablecoin pegged to the US Dollar. This combination offers a unique blend of major cryptocurrencies and stable assets.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            Row(
              children: [
                Checkbox(
                  value: _isAgreed,
                  onChanged: (value) {
                    setState(() {
                      _isAgreed = value ?? false;
                    });
                  },
                ),
                Expanded(
                  child: Text(
                    'I have read, understood and agree to be bound by Joilof account terms and conditions',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: Text('Confirm & Continue'),
                onPressed: _isAgreed
                    ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainApp()),
                  );
                  // Handle confirmation action
                  print('Terms and Conditions accepted');
                }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}