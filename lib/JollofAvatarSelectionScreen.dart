import 'package:flutter/material.dart';
import 'package:jollof/AllowNotificationScreen.dart';

class AvatarSelectionScreen extends StatefulWidget {
  const AvatarSelectionScreen({Key? key}) : super(key: key);

  @override
  _AvatarSelectionScreenState createState() => _AvatarSelectionScreenState();
}

class _AvatarSelectionScreenState extends State<AvatarSelectionScreen> {
  int? _selectedAvatarIndex;

  final List<String> avatarAssets = [
    'assets/avatar1.png',
    'assets/avatar2.png',
    'assets/avatar3.png',
    'assets/avatar4.png',
    'assets/avatar5.png',
    'assets/avatar6.png',
    'assets/avatar7.png',
    'assets/avatar8.png',
    'assets/avatar9.png',
    'assets/avatar10.png',
    'assets/avatar11.png',
    'assets/avatar12.png',
    'assets/avatar13.png',
    'assets/avatar14.png',
    'assets/avatar15.png',
    'assets/avatar16.png',
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
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Text(
              'Select an avatar for your profile to personalize your account',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            SizedBox(height: 60),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: avatarAssets.length,
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
                        color: _selectedAvatarIndex == index ? Colors.amber : Colors.white,
                        width: 2,
                      ),
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: ClipOval(
                        child: Image.asset(
                          avatarAssets[index],
                          fit: BoxFit.cover,
                          width: 75,
                          height: 75,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 110),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _selectedAvatarIndex != null
                    ? () {
                  // Navigate to AllowNotificationScreen after selecting avatar
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AllowNotificationScreen(),
                    ),
                  );
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
    );
  }
}
