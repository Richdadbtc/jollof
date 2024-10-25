import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'PaymentMethodSelectionScreen.dart';

class AddMoneyScreen extends StatefulWidget {
  @override
  _AddMoneyScreenState createState() => _AddMoneyScreenState();
}

class _AddMoneyScreenState extends State<AddMoneyScreen> {
  String selectedCurrency = 'USDT';
  TextEditingController _amountController = TextEditingController();

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
    if (value.isEmpty) return;  // Do nothing if the input is empty

    double amount = double.tryParse(value) ?? 0.0;
    String formattedAmount = amount.toStringAsFixed(2);

    // Format with commas for thousands
    List<String> parts = formattedAmount.split('.');
    parts[0] = parts[0].replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
            (Match m) => '${m[1]},'
    );
    formattedAmount = parts.join('.');

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
          selectedCurrency: selectedCurrency,
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
            // Handle back navigation
          },
        ),
        title: Text(
          'Add money',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        color: Colors.grey[100],
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
              color: Colors.white,
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
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      hintText: 'Enter amount',  // Show placeholder instead of default value
                      prefixText: selectedCurrency == 'USDT' ? '\$' : '₦', // Switch prefix based on currency
                      border: InputBorder.none,
                    ),
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                    ],
                  ),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                child: Text(
                  'Confirm and pay',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PaymentMethodScreen()),
                  );
                  // Handle payment confirmation
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

class CurrencyPicker extends StatelessWidget {
  final Function(String) onCurrencySelected;
  final String selectedCurrency;

  CurrencyPicker({required this.onCurrencySelected, required this.selectedCurrency});

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
            trailing: Icon(selectedCurrency == 'USDT' ? Icons.radio_button_checked : Icons.radio_button_unchecked),
            onTap: () => onCurrencySelected('USDT'),
          ),
          ListTile(
            leading: Text('₦', style: TextStyle(fontSize: 24)),
            title: Text('Naira'),
            trailing: Icon(selectedCurrency == 'Naira' ? Icons.radio_button_checked : Icons.radio_button_unchecked),
            onTap: () => onCurrencySelected('Naira'),
          ),
          TextButton(
            child: Text('Cancel',
            style: TextStyle(color: Colors.black),),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
