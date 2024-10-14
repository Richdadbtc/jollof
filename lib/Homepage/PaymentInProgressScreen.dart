import 'package:flutter/material.dart';

// PaymentInProgressScreen (Image 1)
class PaymentInProgressScreen extends StatelessWidget {
  final double amount;

  PaymentInProgressScreen({required this.amount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.sync,
              size: 100,
              color: Colors.black,
            ),
            SizedBox(height: 20),
            Text(
              'Your payment is on its way',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 80,),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ElevatedButton(
                    child: Text('View Transaction'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProcessingTransactionScreen(amount: amount)),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                    ),
                  ),
                  SizedBox(height: 10),
                  OutlinedButton(
                    child: Text('Back to Home'),
                    onPressed: () {
                      Navigator.pop(context); // Go back to previous screen
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black,
                      side: BorderSide(color: Colors.black),
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ProcessingTransactionScreen (Image 2)
class ProcessingTransactionScreen extends StatelessWidget {
  final double amount;

  ProcessingTransactionScreen({required this.amount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Processing Transaction'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('To Naira Wallet'),
                    Text('28th Jan, 15:33 PM', style: TextStyle(color: Colors.grey)),
                  ],
                ),
                Text('₦${amount.toStringAsFixed(2)}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ],
            ),
            SizedBox(height: 20),
            _buildTransactionStep('Processing', true, '29th Dec'),
            _buildTransactionStep('Waiting to receive funds', false, '29th Dec'),
            _buildTransactionStep('Funds Deposited', false, '29th Dec'),
            SizedBox(height: 20),
            Text('Details', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            _buildDetailRow('Reference no', 'JF-002836ZY18'),
            _buildDetailRow('You will get', '₦${amount.toStringAsFixed(2)}'),
            _buildDetailRow('Fee', '₦0.00'),
            _buildDetailRow('Total paid', '₦${amount.toStringAsFixed(2)}'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PaymentSuccessScreen(amount: amount)),
          );
        },
      ),
    );
  }

  Widget _buildTransactionStep(String title, bool isActive, String date) {
    return Row(
      children: [
        Column(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isActive ? Colors.green : Colors.grey,
              ),
              child: isActive ? Icon(Icons.check, color: Colors.white, size: 12) : null,
            ),
            Container(
              width: 2,
              height: 30,
              color: Colors.grey[300],
            ),
          ],
        ),
        SizedBox(width: 10),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(date, style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Row(
            children: [
              Text(value),
              if (label == 'Reference no')
                IconButton(
                  icon: Icon(Icons.copy, size: 18),
                  onPressed: () {
                    // Implement copy functionality
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }
}


// PaymentSuccessScreen (Image 3)
class PaymentSuccessScreen extends StatelessWidget {
  final double amount;

  PaymentSuccessScreen({required this.amount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 100,
            ),
            SizedBox(height: 20),
            Text(
              'Your payment of ₦${amount.toStringAsFixed(2)} to your wallet has',
              textAlign: TextAlign.center,
            ),
            Text(
              'been successfully funded.',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 80,),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                child: Text('Done'),
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  minimumSize: Size(double.infinity, 50),
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
