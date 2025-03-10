import 'dart:io';
import 'package:flutter/material.dart';
import 'package:frontend/utils/text_strings.dart';
import 'package:frontend/widgets/form/error_message_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:frontend/utils/image_strings.dart';
import 'package:google_ml_kit/google_ml_kit.dart'; // Face detection package

class ProfilePicture extends StatefulWidget {
  const ProfilePicture({super.key});

  @override
  ProfilePictureState createState() => ProfilePictureState();
}

class ProfilePictureState extends State<ProfilePicture> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  String? _errorMessage; 
  
  File? get imageFile => _imageFile;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Stack(
            children: <Widget>[
              CircleAvatar(
                radius: 70,
                backgroundImage: _imageFile == null 
                  ? const AssetImage(profilePicture) 
                  : FileImage(_imageFile!) as ImageProvider,
              ),
              Positioned(
                bottom: 20,
                right: 30,
                child: InkWell(
                  onTap: () {
                    takePicture();
                  },
                  child: const Icon(
                    Icons.camera_alt,
                    size: 22,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        // Show error message if there's an issue
        if (_errorMessage != null) 
          ErrorMessageWidget(text : _errorMessage!),
      ],
    );
  }

  Future<void> takePicture() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    
    if (pickedFile == null) {
      setState(() {
        _errorMessage = "Please take a picture to proceed.";
      });
      return;
    }

    File imageFile = File(pickedFile.path);
    int faceCount = await detectFaces(imageFile);

    if (faceCount == 0) {
      setState(() {
        _errorMessage = noFaceDetected;
      });
    } else if (faceCount > 1) {
      setState(() {
        _errorMessage = multipleFacesDetected;
      });
    } else {
      setState(() {
        _imageFile = imageFile;
        _errorMessage = null; // Clear error when valid image is taken
      });
    }
  }

  Future<int> detectFaces(File imageFile) async {
    final inputImage = InputImage.fromFile(imageFile);
    final faceDetector = GoogleMlKit.vision.faceDetector(
      FaceDetectorOptions(enableContours: true, enableLandmarks: true),
    );

    final List<Face> faces = await faceDetector.processImage(inputImage);
    await faceDetector.close();

    return faces.length;
  }
}
