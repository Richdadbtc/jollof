import 'package:flutter/material.dart';
import '../Homepage/JollofHomeScreen.dart';
import 'DateOfBirthScreen.dart';

class AddressScreen2 extends StatefulWidget {
  const AddressScreen2({Key? key}) : super(key: key);

  @override
  _AddressScreen2State createState() => _AddressScreen2State();
}

class _AddressScreen2State extends State<AddressScreen2> {
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  double progress = 0.68; // 68% progress as shown in the image

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Address',
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
      body: SingleChildScrollView(  // Added SingleChildScrollView
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
                        painter: CircleProgressPainter(progress: progress, percentage: 68, color: Colors.amber),
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
              'Enter your current address',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildTextField('Street', _streetController, '61 Hooper street'),
            _buildTextField('City', _cityController, 'Birmingham'),
            _buildTextField('State/Province', _stateController, 'England'),
            _buildTextField('Postcode/Zipcode', _postalCodeController, 'B54RW'),

             SizedBox(height: 170),  // Added spacing before the button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: const Text('Next'),
                onPressed: _isFormValid()
                    ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DateOfBirthScreen()),
                  );
                }
                    : null,

                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)
                    )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, String initialValue) {
    controller.text = initialValue;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  bool _isFormValid() {
    return _streetController.text.isNotEmpty &&
        _cityController.text.isNotEmpty &&
        _stateController.text.isNotEmpty &&
        _postalCodeController.text.isNotEmpty;
  }
}

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

class NextScreen extends StatelessWidget {
  const NextScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Next Screen')),
      body: const Center(child: Text('This is the next screen after address input')),
    );
  }
}
