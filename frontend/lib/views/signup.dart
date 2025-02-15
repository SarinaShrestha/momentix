import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:frontend/controller/register_controller.dart';
import 'dart:io';



import 'package:frontend/utils/colors.dart';
import 'package:frontend/utils/image_strings.dart';
import 'package:frontend/utils/sizes.dart';
import 'package:frontend/utils/text_strings.dart';
import 'package:frontend/widgets/form/form_header_widget.dart';
import 'package:frontend/widgets/common/elevated_button_widget.dart';
import 'package:frontend/widgets/form/login_form_widget.dart';
import 'package:get/get.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  void proceedToNextPage() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CaptureProfilePicturePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(SignUpController());

    return Scaffold(
      backgroundColor: white,

      body: SafeArea(
        child : SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: horiPadding),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FormHeaderWidget(image: loginImage, title: signUpTitle, subTitle: signUpSubTitle),

                  LoginFormWidget(text: fullName, hintText: hintFullName, controller: controller.fullName,),

                  LoginFormWidget(text: email, hintText: hintEmail, controller: controller.email),

                  LoginFormWidget(text: password, hintText: hintPassword, controller: controller.password),

                  LoginFormWidget(text: confirmPassword, hintText: hintConfirmPassword, controller: controller.confirmPassword,),


                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButtonWidget(
                      buttonName: signUp,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          controller.registerUser(context, controller.email.text.trim(), controller.fullName.text.trim(), controller.password.text.trim());
                        }
                      },
                      //onPressed: proceedToNextPage,
                      ),
                  ),
                ],
              ),
            ),
          ),
        )
      )
    );
  }
}

class CaptureProfilePicturePage extends StatefulWidget {
  const CaptureProfilePicturePage({super.key});

  @override
  _CaptureProfilePicturePageState createState() => _CaptureProfilePicturePageState();
}

class _CaptureProfilePicturePageState extends State<CaptureProfilePicturePage> {
  CameraController? _cameraController;
  String? capturedImagePath;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.first;

    _cameraController = CameraController(camera, ResolutionPreset.medium);
    await _cameraController?.initialize();
    setState(() {});
  }

  Future<void> captureImage() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }

    try {
      final tempImage = await _cameraController!.takePicture();
      setState(() {
        capturedImagePath = tempImage.path;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Picture captured successfully!")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error capturing image: $e")),
      );
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Capture Profile Picture"),
        centerTitle: true,
        backgroundColor: Color(0xFF4A90E2),
      ),
      body: Column(
        children: [
          if (_cameraController != null && _cameraController!.value.isInitialized)
            AspectRatio(
              aspectRatio: _cameraController!.value.aspectRatio,
              child: CameraPreview(_cameraController!),
            )
          else 
            Center(child: Text("Initializing camera..."),),
            
          SizedBox(height: 16),
          if (capturedImagePath != null)
            Image.file(
              File(capturedImagePath!),
              height: 200,
              fit: BoxFit.cover,
            ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: captureImage,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF4A90E2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            ),
            child: Text(
              "Capture",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
