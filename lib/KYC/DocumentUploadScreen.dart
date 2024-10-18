import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'AnnualIncomeSelection.dart';

class DocumentUploadScreen extends StatefulWidget {
  const DocumentUploadScreen({Key? key}) : super(key: key);

  @override
  _DocumentUploadScreenState createState() => _DocumentUploadScreenState();
}

class _DocumentUploadScreenState extends State<DocumentUploadScreen> {
  File? _selectedFile;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Upload Document',
          style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _selectedFile != null
                ? Image.file(_selectedFile!, height: 200)
                : const Text('No document selected.'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _showDocumentUploadOptions(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Upload Document'),
            ),
            if (_selectedFile != null) ...[
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _navigateToVerificationScreen();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Confirm'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showDocumentUploadOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take Photo'),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text('Choose from Camera Roll'),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.picture_as_pdf),
                title: const Text('Choose a PDF'),
                onTap: () {
                  _pickPdf();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.cancel),
                title: const Text('Cancel'),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    setState(() {
      if (pickedFile != null) {
        _selectedFile = File(pickedFile.path);
      }
    });
  }

  Future<void> _pickPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
      });
    }
  }

  void _navigateToVerificationScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => IDVerificationScreen(file: _selectedFile!),
      ),
    );
  }
}

class IDVerificationScreen extends StatefulWidget {
  final File file;

  const IDVerificationScreen({Key? key, required this.file}) : super(key: key);

  @override
  _IDVerificationScreenState createState() => _IDVerificationScreenState();
}

class _IDVerificationScreenState extends State<IDVerificationScreen> {
  bool _checkingPhoto = false;
  bool _checkingID = false;
  bool _finishing = false;

  @override
  void initState() {
    super.initState();
    _startVerification();
  }

  void _startVerification() async {
    setState(() => _checkingPhoto = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _checkingPhoto = false;
      _checkingID = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _checkingID = false;
      _finishing = true;
    });
    await Future.delayed(const Duration(seconds: 3));
    setState(() => _finishing = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildImage(),  // Replaced robot icon with image
                const SizedBox(height: 30), // Adjusted spacing
                const Text(
                  'Please wait while we verify your Photo and ID Card..',
                  textAlign: TextAlign.start,  // Center-aligned text
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15), // Adjusted spacing
                const Text(
                  'We are conducting a background check on you and anything we discover about you would be displayed on your profile. We aim to keep everyone safe.',
                  textAlign: TextAlign.start,  // Center-aligned text
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 50), // Larger gap before the status
                _buildCheckItem('Checking your Photo', _checkingPhoto),
                _buildCheckItem('Checking your ID', _checkingID),
                _buildCheckItem('Finishing up..', _finishing),
                const Spacer(),  // Push the button to the bottom
                ElevatedButton(
                  onPressed: _checkingPhoto || _checkingID || _finishing ? null : () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AnnualIncomeScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Continue'),
                ),
                const SizedBox(height: 20),  // Added space below the button
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Function to replace robot icon with image
  Widget _buildImage() {
    return Image.asset(
      'assets/verification_bot.png',  // Replace with the path to your image
      width: 100,  // Adjust width as needed
      height: 100,  // Adjust height as needed
    );
  }

  Widget _buildCheckItem(String text, bool isChecking) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,  // Align icon and text
        children: [
          Text(text, style: const TextStyle(fontSize: 16)),
          if (isChecking)
            const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ),
            )
          else
            const Icon(Icons.check, color: Colors.black, size: 24),  // Adjust icon size
        ],
      ),
    );
  }
}

