import 'package:flutter/material.dart';

import 'ProofOfIdentityScreen.dart';

class DateOfBirthScreen extends StatefulWidget {
  const DateOfBirthScreen({super.key});

  @override
  _DateOfBirthScreenState createState() => _DateOfBirthScreenState();
}

class _DateOfBirthScreenState extends State<DateOfBirthScreen> {
  final TextEditingController _dayController = TextEditingController();
  final TextEditingController _monthController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  double progress = 0.88; // 88% progress as shown in the image

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Date of birth',
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
      body: SingleChildScrollView( // Wrap with SingleChildScrollView to avoid render flex issues
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
                        size: Size(40, 40),
                        painter: CircleProgressPainter(progress: progress, percentage: 88, color: Colors.amber),
                      ),
                      Text(
                        '${(progress * 100).toInt()}%',
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Date of birth',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'You must be at least 18 years old, and date must match your government issued ID or passport',
              style: TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(child: _buildTextField('Day', _dayController)),
                const SizedBox(width: 10),
                Expanded(child: _buildTextField('Month', _monthController)),
                const SizedBox(width: 10),
                Expanded(child: _buildTextField('Year', _yearController)),
              ],
            ),
            const SizedBox(height: 430),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: const Text('Next'),
                onPressed: _isFormValid()
                    ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProofOfIdentityScreen()),
                  );
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

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  bool _isFormValid() {
    return _dayController.text.isNotEmpty &&
        _monthController.text.isNotEmpty &&
        _yearController.text.isNotEmpty;
  }
}

// Reuse CircleProgressPainter or ensure it is available here.
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
