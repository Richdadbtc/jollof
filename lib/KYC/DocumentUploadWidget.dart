import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class DocumentUploadWidget extends StatefulWidget {
  final Function(File) onDocumentCaptured;

  const DocumentUploadWidget({Key? key, required this.onDocumentCaptured}) : super(key: key);

  @override
  _DocumentUploadWidgetState createState() => _DocumentUploadWidgetState();
}

class _DocumentUploadWidgetState extends State<DocumentUploadWidget> {
  File? _capturedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(12),
          ),
          child: _capturedImage != null
              ? ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.file(_capturedImage!, fit: BoxFit.cover),
          )
              : const Icon(Icons.add_a_photo, size: 50, color: Colors.grey),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _captureDocument,
          child: const Text('Capture Document'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          ),
        ),
        if (_capturedImage != null) ...[
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _confirmUpload,
            child: const Text('Confirm Upload'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
          ),
        ],
      ],
    );
  }

  Future<void> _captureDocument() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _capturedImage = File(image.path);
      });
    }
  }

  void _confirmUpload() {
    if (_capturedImage != null) {
      widget.onDocumentCaptured(_capturedImage!);
      // You can add additional logic here, such as showing a success message
    }
  }
}