import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Paymentscreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<Paymentscreen> {
  String selectedCurrency = 'Naira';
  double exchangeRate = 1700.0; // USDT to Naira rate
  TextEditingController _amountController = TextEditingController(text: '2000');
  TextEditingController _usdtController = TextEditingController(text: '1.54');
  bool isNaira = true;

  @override
  void initState() {
    super.initState();
    _amountController.addListener(_handleNairaInput);
    _usdtController.addListener(_handleUSDTInput);
  }

  @override
  void dispose() {
    _amountController.dispose();
    _usdtController.dispose();
    super.dispose();
  }

  void _handleNairaInput() {
    if (!isNaira) return;

    String value = _amountController.text.replaceAll(',', '');
    if (value.isEmpty) value = '0';

    int amount = int.tryParse(value) ?? 0;
    String formattedAmount = _formatNumber(amount);

    _amountController.value = TextEditingValue(
      text: formattedAmount,
      selection: TextSelection.collapsed(offset: formattedAmount.length),
    );

    double usdtAmount = amount / exchangeRate;
    _usdtController.text = usdtAmount.toStringAsFixed(2);
  }

  void _handleUSDTInput() {
    if (isNaira) return;

    String value = _usdtController.text;
    if (value.isEmpty) value = '0';

    double usdtAmount = double.tryParse(value) ?? 0;
    int nairaAmount = (usdtAmount * exchangeRate).round();
    String formattedNairaAmount = _formatNumber(nairaAmount);

    _amountController.text = formattedNairaAmount;
  }

  String _formatNumber(int number) {
    return number.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
    );
  }

  void _showCurrencyPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: CurrencyPicker(
            selectedCurrency: selectedCurrency,
            onCurrencySelected: (currency) {
              setState(() {
                selectedCurrency = currency;
                isNaira = currency == 'Naira';
                if (isNaira) {
                  _handleNairaInput();
                } else {
                  _handleUSDTInput();
                }
              });
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Payment', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          TextButton.icon(
            icon: Icon(Icons.calendar_today, size: 16),
            label: Text('Schedule'),
            style: TextButton.styleFrom(foregroundColor: Colors.amber),
            onPressed: () {
              // Handle schedule
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Icon(Icons.security, size: 16, color: Colors.green),
                SizedBox(width: 8),
                Text(
                  'Your money is safe',
                  style: TextStyle(color: Colors.green, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: ListTile(
              leading: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: selectedCurrency == 'USDT'
                    ? Icon(Icons.currency_bitcoin, color: Colors.amber)
                    : Text('₦', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
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
                Text(
                  'You are depositing',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      selectedCurrency == 'Naira' ? '₦' : '\$',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 4),
                    Expanded(
                      child: TextField(
                        controller: selectedCurrency == 'Naira'
                            ? _amountController
                            : _usdtController,
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '0.00',
                        ),
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        inputFormatters: [
                          selectedCurrency == 'Naira'
                              ? FilteringTextInputFormatter.digitsOnly
                              : FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                        ],
                      ),
                    ),
                  ],
                ),
                if (selectedCurrency == 'Naira')
                  Text(
                    '≈ ${_usdtController.text} USDT',
                    style: TextStyle(color: Colors.grey[600]),
                  )
                else
                  Text(
                    '≈ ₦${_amountController.text}',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.blue, size: 20),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Current exchange rate: 1 USDT = ₦${exchangeRate.toStringAsFixed(2)}',
                          style: TextStyle(color: Colors.blue[900]),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  child: Text('Transfer Funds'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentDetailsScreen(
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CurrencyPicker extends StatelessWidget {
  final Function(String) onCurrencySelected;
  final String selectedCurrency;

  CurrencyPicker({
    required this.onCurrencySelected,
    required this.selectedCurrency,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text('Naira (₦)'),
            trailing: selectedCurrency == 'Naira' ? Icon(Icons.check) : null,
            onTap: () => onCurrencySelected('Naira'),
          ),
          ListTile(
            title: Text('USDT (\$)'),
            trailing: selectedCurrency == 'USDT' ? Icon(Icons.check) : null,
            onTap: () => onCurrencySelected('USDT'),
          ),
        ],
      ),
    );
  }
}

class PaymentDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Payment Details',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // Navigates back
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
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
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 20),
            _buildPaymentDetails(),
            SizedBox(height: 20),
            _buildExpiryNotice(),
            Spacer(),
            _buildButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentDetails() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRow('Amount to send', 'NGN2,000', isBold: true),
          Divider(),
          _buildRow('Account name', 'Jollof Limited'),
          Divider(),
          _buildRow('Bank name', 'GTBank'),
          Divider(),
          _buildRow('Account number', '00181789'),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16),
        ),
        Row(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            IconButton(
              icon: Icon(Icons.copy, size: 16),
              onPressed: () {
                // Copy to clipboard logic
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildExpiryNotice() {
    return Row(
      children: [
        Icon(Icons.access_time, size: 20, color: Colors.grey[600]),
        SizedBox(width: 8),
        Text(
          'The account details is valid for only this transaction\nand it expires in 30 mins',
          style: TextStyle(fontSize: 14, color: Colors.black),
        ),
      ],
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () {
            // Handle payment confirmation
          },
          child: Text('I have paid'),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black, backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)
            ),
            side: BorderSide(color: Colors.black),
          ),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            // Handle sharing address
          },
          child: Text('Share address'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)
            )
          ),
        ),
      ],
    );
  }
}

