import 'package:flutter/material.dart';

class InvestmentBreakdownScreen extends StatelessWidget {
  const InvestmentBreakdownScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Investment',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            child: const Text('Help', style: TextStyle(color: Colors.amber)),
            onPressed: () {
              // Handle help action
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
              _buildInfoTile('Duration of investment', '3 months'),
              const SizedBox(height: 20),
              _buildPotentialReturnImage(),
              const SizedBox(height: 20),
              _buildInfoTile('Total invested', '\$2,000,000'),
              const Divider(),
              const Text('Breakdown', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              _buildBreakdownItem('30% capital insurance', '\$75.00', Icons.shield),
              _buildBreakdownItem('You are investing', '\$500.00', Icons.account_balance_wallet),
              _buildBreakdownItem('Expected Return', '\$50.00', Icons.trending_up, isGreen: true),
              _buildBreakdownItem('Total cash out + capital', '\$550.00', Icons.attach_money),
              _buildNavigationItem('You can opt out', Icons.exit_to_app),
              _buildNavigationItem('Get help', Icons.help_outline),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text('Invest \$500'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)
                      )// Full-width button
                  ),
                  onPressed: () {
                    // Handle investment action
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoTile(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 16)),
        Row(
          children: [
            Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const Icon(Icons.chevron_right),
          ],
        ),
      ],
    );
  }

  Widget _buildPotentialReturnImage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Potential return',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '+10%',
              style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              'This month',
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Image.asset(
          'assets/Chart 1.png',  // Use AssetImage for the chart image
          height: 150,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 8),
        Text(
          'Your expected return in December',
          style: TextStyle(color: Colors.grey[600], fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildBreakdownItem(String title, String amount, IconData icon, {bool isGreen = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.grey[200],  // Adding a light background color to the container
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(icon, color: isGreen ? Colors.green : Colors.grey),
        title: Text(title),
        trailing: Text(
          amount,
          style: TextStyle(fontWeight: FontWeight.bold, color: isGreen ? Colors.green : Colors.black),
        ),
      ),
    );
  }

  Widget _buildNavigationItem(String title, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.grey[200],  // Adding a light background color to the container
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          // Handle navigation
        },
      ),
    );
  }
}
