import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Paymentscreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<Paymentscreen> {
  String selectedCurrency = 'Naira';
  TextEditingController _amountController = TextEditingController(text: '2,000');

  @override
  void initState() {
    super.initState();
    _amountController.addListener(_formatAmount);
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _formatAmount() {
    String value = _amountController.text.replaceAll(',', '');
    if (value.isEmpty) {
      value = '0';
    }
    int amount = int.tryParse(value) ?? 0;
    String formattedAmount = amount.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
            (Match m) => '${m[1]},'
    );

    _amountController.value = TextEditingValue(
      text: formattedAmount,
      selection: TextSelection.collapsed(offset: formattedAmount.length),
    );
  }

  void _showCurrencyPicker() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return CurrencyPicker(
          onCurrencySelected: (currency) {
            setState(() {
              selectedCurrency = currency;
            });
            Navigator.pop(context);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Payment'),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Your money is safe'),
                  Text('Schedule', style: TextStyle(color: Colors.amber)),
                ],
              ),
            ),
            Container(
              color: Colors.grey[200],
              child: ListTile(
                leading: Icon(Icons.credit_card),
                title: Text(selectedCurrency),
                trailing: Icon(Icons.chevron_right),
                onTap: _showCurrencyPicker,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('You are depositing'),
                  TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixText: '₦',
                      border: InputBorder.none,
                    ),
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                child: Text('Transfer Funds'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PaymentDetailsScreen(amount: _amountController.text)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: Colors.amber,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentDetailsScreen extends StatelessWidget {
  final String amount;

  PaymentDetailsScreen({required this.amount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Payment Details'),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Fund your Naira wallet',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Tap the "I have paid" button below after completing the transfer',
                style: TextStyle(color: Colors.grey[600]),
              ),
              SizedBox(height: 24),
              _buildInfoTile('Amount to send', 'NGN$amount'),
              _buildInfoTile('Account name', 'Jollof Limited', showCopyIcon: true),
              _buildInfoTile('Bank name', 'GTBank', showCopyIcon: true),
              _buildInfoTile('Account number', '00181789', showCopyIcon: true),
              SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'The account details is valid for only this transaction and it expires in 30 mins',
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              ElevatedButton(
                child: Text('I have paid'),
                onPressed: () {
                  // Handle payment confirmation
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                child: Text('Share address'),
                onPressed: () {
                  // Handle sharing address
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: Colors.amber,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoTile(String title, String value, {bool showCopyIcon = false}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(color: Colors.grey[600])),
          Row(
            children: [
              Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
              if (showCopyIcon) ...[
                SizedBox(width: 8),
                Icon(Icons.copy, size: 18, color: Colors.grey[400]),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

// CurrencyPicker widget remains unchanged
class CurrencyPicker extends StatelessWidget {
  final Function(String) onCurrencySelected;

  CurrencyPicker({required this.onCurrencySelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Choose currency', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          ListTile(
            leading: Icon(Icons.diamond),
            title: Text('USDT'),
            trailing: Icon(Icons.radio_button_unchecked),
            onTap: () => onCurrencySelected('USDT'),
          ),
          ListTile(
            leading: Text('₦', style: TextStyle(fontSize: 24)),
            title: Text('Naira'),
            trailing: Icon(Icons.radio_button_checked, color: Colors.amber),
            onTap: () => onCurrencySelected('Naira'),
          ),
          TextButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}