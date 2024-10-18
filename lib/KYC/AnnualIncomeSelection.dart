import 'package:flutter/material.dart';
import 'package:jollof/KYC/terms_and_conditions_screen.dart';

class AnnualIncomeScreen extends StatefulWidget {
  const AnnualIncomeScreen({Key? key}) : super(key: key);

  @override
  _AnnualIncomeScreenState createState() => _AnnualIncomeScreenState();
}

class _AnnualIncomeScreenState extends State<AnnualIncomeScreen> {
  String? _selectedIncome;
  final List<String> _incomeRanges = [
    '\$0 - \$10,000',
    '\$10,000 - \$50,000',
    '\$50,000 - \$100,000',
    '\$100,000 - \$500,000',
    '\$500,000 and above',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Proof of identity',
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
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 40,
                  height: 40,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CustomPaint(
                        size: const Size(40, 40),
                        painter: CircleProgressPainter(progress: 1.0, percentage: 100, color: Colors.amber),
                      ),
                      const Text(
                        '100%',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Annual income',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Can include salary, alimony, social security, investment income etc.',
              style: TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 20),
            ..._incomeRanges.map((range) => _buildIncomeOption(range)),
            const SizedBox(height: 130),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: const Text('Continue'),
                onPressed: _selectedIncome != null ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TermsAndConditionsScreen()),
                  );
                  // Navigate to the next screen or finish the flow
                  print('Selected income: $_selectedIncome');
                  // Add navigation logic here
                } : null,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle chat action
        },
        child: const Icon(Icons.chat),
        backgroundColor: Colors.amber,
      ),
    );
  }

  Widget _buildIncomeOption(String range) {
    return RadioListTile<String>(
      title: Text(range),
      value: range,
      groupValue: _selectedIncome,
      onChanged: (String? value) {
        setState(() {
          _selectedIncome = value;
        });
      },
      activeColor: Colors.amber,
      contentPadding: EdgeInsets.zero,
    );
  }
}

// CircleProgressPainter class (same as in your original code)
class CircleProgressPainter extends CustomPainter {
  final double progress;
  final double percentage;
  final Color color;

  CircleProgressPainter({required this.progress, required this.percentage, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0
      ..strokeCap = StrokeCap.round;

    // Draw background circle
    paint.color = Colors.grey[300]!;
    canvas.drawCircle(center, radius, paint);

    // Draw progress arc
    paint.color = color;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -1.5708, // Start from the top (90 degrees)
      progress * 2 * 3.14159, // Full circle is 2*pi radians
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}