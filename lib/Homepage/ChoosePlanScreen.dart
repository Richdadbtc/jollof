import 'package:flutter/material.dart';
import 'dart:math';

class ChoosePlanScreen extends StatefulWidget {
  @override
  _ChoosePlanScreenState createState() => _ChoosePlanScreenState();
}

class _ChoosePlanScreenState extends State<ChoosePlanScreen> {
  String? selectedPlan; // This will hold the selected plan (null if none)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Choose a plan'),
        actions: [
          TextButton(
            child: Text('Help', style: TextStyle(color: Colors.amber)),
            onPressed: () {
              // Handle help action
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Text(
            'Choose a plan',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),

          // Horizontal scrollable plan cards
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildPlanCard('Standard Plan', '\$299.00', 'Standard plan details'),
                SizedBox(width: 10),
                _buildPlanCard('Premium Plan', '\$499.00', 'Premium plan details'),
                SizedBox(width: 10),
                _buildPlanCard('Exclusive Plan', '\$999.00', 'Exclusive plan details'),
              ],
            ),
          ),

          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'What you will get',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton(
                child: Text('Learn more'),
                onPressed: () {
                  // Handle learn more action
                },
              ),
            ],
          ),
          SizedBox(height: 10),
          _buildBenefitItem(color: Colors.blue, percentage: 0.1, duration: '3 months'),
          _buildBenefitItem(color: Colors.orange, percentage: 0.25, duration: '6 months'),
          _buildBenefitItem(color: Colors.red, percentage: 0.55, duration: '12 months'),
          _buildBenefitItem(
            color: Colors.amber,
            percentage: 0.80,
            title: 'capital reimbursement',
            subtitle: '80% capital reimbursement for \$50 only',
          ),
          SizedBox(height: 20),

          // Continue Button
          ElevatedButton(
            child: Text(selectedPlan != null ? 'Start with $selectedPlan' : 'Select a Plan to Continue'),
            onPressed: selectedPlan != null
                ? () {
              // Handle continue action (e.g., navigate to the next screen)
            }
                : null, // Disable the button if no plan is selected
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 50),
              backgroundColor: Colors.amber,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Function to build a plan card
  Widget _buildPlanCard(String planName, String price, String details) {
    bool isSelected = selectedPlan == planName; // Check if this plan is selected

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPlan = planName; // Update selected plan
        });
      },
      child: Container(
        width: 300,
        height: 250,
        decoration: BoxDecoration(
          color: isSelected ? Colors.greenAccent : Colors.amber, // Highlight if selected
          borderRadius: BorderRadius.circular(15),
          border: isSelected ? Border.all(color: Colors.green, width: 3) : null, // Add border if selected
        ),
        child: Stack(
          children: [
            Positioned(
              right: 10,
              bottom: 10,
              child: Text(
                'Jollof',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    planName,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    price,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Text(
                    details,
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to build a benefit item
  Widget _buildBenefitItem({
    required Color color,
    required double percentage,
    String duration = '',
    String title = '',
    String subtitle = '',
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          CustomPaint(
            size: Size(40, 40),
            painter: CircularIndicatorPainter(color: color, percentage: percentage),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title.isEmpty ? '${(percentage * 100).toInt()}% profit for $duration' : title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  subtitle.isEmpty
                      ? 'Earn ${percentage * 100}% profit in $duration'
                      : subtitle,
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
          Icon(Icons.check_circle, color: Colors.green),
        ],
      ),
    );
  }
}

class CircularIndicatorPainter extends CustomPainter {
  final Color color;
  final double percentage;

  CircularIndicatorPainter({required this.color, required this.percentage});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint baseCircle = Paint()
      ..color = color.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    final Paint progressCircle = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0
      ..strokeCap = StrokeCap.round;

    // Draw the base circle
    canvas.drawCircle(size.center(Offset.zero), size.width / 2, baseCircle);

    // Draw the progress arc
    double angle = 2 * pi * percentage;
    canvas.drawArc(
      Rect.fromCircle(center: size.center(Offset.zero), radius: size.width / 2),
      -pi / 2,
      angle,
      false,
      progressCircle,
    );

    // Draw the percentage number in the center
    final textSpan = TextSpan(
      text: '${(percentage * 100).toInt()}%',
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        (size.width - textPainter.width) / 2,
        (size.height - textPainter.height) / 2,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
