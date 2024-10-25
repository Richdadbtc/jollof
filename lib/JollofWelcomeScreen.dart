import 'package:flutter/material.dart';
import 'package:jollof/CreatePinScreen.dart';
import 'dart:convert';
import 'JollofAvatarSelectionScreen.dart';

class JollofWelcomeScreen extends StatefulWidget {
  const JollofWelcomeScreen({Key? key}) : super(key: key);

  @override
  _JollofWelcomeScreenState createState() => _JollofWelcomeScreenState();
}

class _JollofWelcomeScreenState extends State<JollofWelcomeScreen> {
  // State to track the selected investment option
  String _selectedOption = 'AI Managed Portfolio'; // Default option

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Welcome',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
        actions: [
          TextButton(
            onPressed: () {
              // TODO: Implement skip functionality
            },
            child: Text('Skip', style: TextStyle(color: Colors.amber)),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome to Jollof',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                'Select or create the portfolio you wish to invest in. Begin your investment adventure with a special collection of Jollof zero risk investment package. Boost your investment power with the help of our AI, and reach new heights in your money goals.',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              SizedBox(height: 32),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedOption = 'Fixed investment'; // Set selected option
                  });
                },
                child: InvestmentOptionTile(
                  icon: '🌿',
                  title: 'Fixed investment',
                  subtitle: 'Up to 100% returns',
                  isSelected: _selectedOption == 'Fixed investment',
                ),
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedOption = 'AI Managed Portfolio'; // Set selected option
                  });
                },
                child: InvestmentOptionTile(
                  icon: '🤖',
                  title: 'AI Managed Portfolio',
                  subtitle: 'Up to 300% returns',
                  isSelected: _selectedOption == 'AI Managed Portfolio',
                ),
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Pass the selected investment option to the next screen
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const CreatePinScreen(email: '',),
                      ),
                    );
                    // TODO: Implement continue functionality based on selected option
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('Continue', style: TextStyle(fontSize: 18)),
                ),
              ),
              SizedBox(height: 16),
              RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  children: [
                    TextSpan(text: 'By continuing you agree to our '),
                    TextSpan(
                      text: 'terms of service',
                      style: TextStyle(color: Colors.amber),
                      // TODO: Add GestureRecognizer for terms of service
                    ),
                    TextSpan(text: ' and '),
                    TextSpan(
                      text: 'privacy agreement',
                      style: TextStyle(color: Colors.amber),
                      // TODO: Add GestureRecognizer for privacy agreement
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
}

class InvestmentOptionTile extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  final bool isSelected;

  const InvestmentOptionTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: isSelected ? Colors.amber : Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Text(icon, style: TextStyle(fontSize: 24)),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text(subtitle, style: TextStyle(color: Colors.green)),
              ],
            ),
          ),
          if (isSelected)
            Icon(Icons.check_circle, color: Colors.amber)
          else
            Icon(Icons.radio_button_unchecked, color: Colors.grey),
        ],
      ),
    );
  }
}
