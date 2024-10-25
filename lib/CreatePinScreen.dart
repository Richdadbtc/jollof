import 'package:flutter/material.dart';
import 'JollofAvatarSelectionScreen.dart';

class CreatePinScreen extends StatefulWidget {
  const CreatePinScreen({Key? key, required String email}) : super(key: key);

  @override
  _CreatePinScreenState createState() => _CreatePinScreenState();
}

class _CreatePinScreenState extends State<CreatePinScreen> {
  String _pin = '';

  void _onKeyPress(String key) {
    if (_pin.length < 4) {
      setState(() {
        _pin += key;
      });
    }
    if (_pin.length == 4) {
      // Navigate to ConfirmPinScreen after the PIN is entered
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ConfirmPinScreen(originalPin: _pin),
        ),
      );
    }
  }

  void _onDelete() {
    if (_pin.isNotEmpty) {
      setState(() {
        _pin = _pin.substring(0, _pin.length - 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.amber, width: 2),
                    ),
                    child: Icon(Icons.lock_outline, size: 40, color: Colors.amber),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Welcome To Jollof',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Please create your pin',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      4,
                          (index) => Container(
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.amber),
                          color: index < _pin.length ? Colors.amber : Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  TextButton(
                    onPressed: () {
                      // TODO: Implement forgot passcode functionality
                    },
                    child: Text('Forgot your passcode?', style: TextStyle(color: Colors.grey)),
                  ),
                ],
              ),
            ),
            PinKeypad(onKeyPress: _onKeyPress, onDelete: _onDelete),
          ],
        ),
      ),
    );
  }
}

class ConfirmPinScreen extends StatefulWidget {
  final String originalPin;

  const ConfirmPinScreen({Key? key, required this.originalPin}) : super(key: key);

  @override
  _ConfirmPinScreenState createState() => _ConfirmPinScreenState();
}

class _ConfirmPinScreenState extends State<ConfirmPinScreen> {
  String _pin = '';

  void _onKeyPress(String key) {
    if (_pin.length < 4) {
      setState(() {
        _pin += key;
      });
    }
    if (_pin.length == 4) {
      if (_pin == widget.originalPin) {
        // Navigate to Avatar Selection Screen
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AvatarSelectionScreen(),
          ),
        );
      } else {
        setState(() {
          _pin = '';
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('PINs do not match. Please try again.')),
        );
      }
    }
  }

  void _onDelete() {
    if (_pin.isNotEmpty) {
      setState(() {
        _pin = _pin.substring(0, _pin.length - 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.amber, width: 2),
                    ),
                    child: Icon(Icons.lock_outline, size: 40, color: Colors.amber),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Confirm Your PIN',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Please re-enter your pin',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      4,
                          (index) => Container(
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.amber),
                          color: index < _pin.length ? Colors.amber : Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            PinKeypad(onKeyPress: _onKeyPress, onDelete: _onDelete),
          ],
        ),
      ),
    );
  }
}

class PinKeypad extends StatelessWidget {
  final Function(String) onKeyPress;
  final Function() onDelete;

  const PinKeypad({Key? key, required this.onKeyPress, required this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildKeypadButton('1'),
              _buildKeypadButton('2'),
              _buildKeypadButton('3'),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildKeypadButton('4'),
              _buildKeypadButton('5'),
              _buildKeypadButton('6'),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildKeypadButton('7'),
              _buildKeypadButton('8'),
              _buildKeypadButton('9'),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildKeypadButton(''),
              _buildKeypadButton('0'),
              _buildKeypadButton('⌫', onTap: onDelete),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKeypadButton(String label, {Function()? onTap}) {
    return InkWell(
      onTap: onTap ?? (label.isNotEmpty ? () => onKeyPress(label) : null),
      child: Container(
        width: 60,
        height: 60,
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}