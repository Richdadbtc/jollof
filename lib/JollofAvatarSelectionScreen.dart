import 'package:flutter/material.dart';

class AvatarSelectionScreen extends StatefulWidget {
  const AvatarSelectionScreen({Key? key}) : super(key: key);

  @override
  _AvatarSelectionScreenState createState() => _AvatarSelectionScreenState();
}

class _AvatarSelectionScreenState extends State<AvatarSelectionScreen> {
  int? _selectedAvatarIndex;

  final List<String> avatars = [
    '👨‍💼', '👩‍💼', '👦', '👧', '👩‍🦱', '👨‍🦰', '👩‍🦰', '👴',
    '👨‍🦱', '👱‍♀️', '🧑', '👩',
    '👩‍🦳', '👨', '👵', '👩‍🦱',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Set your avatar', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select an avatar for your profile to personalize your account',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              SizedBox(height: 40),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: avatars.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedAvatarIndex = index;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: _selectedAvatarIndex == index ? Colors.amber : Colors.grey[300]!,
                            width: 2,
                          ),
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.grey[200],
                          child: Text(
                            avatars[index],
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _selectedAvatarIndex != null
                      ? () {
                    // TODO: Save selected avatar and navigate to next screen
                    print('Selected avatar: ${avatars[_selectedAvatarIndex!]}');
                  }
                      : null,
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
              Center(
                child: TextButton(
                  onPressed: () {
                    // TODO: Handle skip functionality
                  },
                  child: Text('Skip for now', style: TextStyle(color: Colors.black)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}