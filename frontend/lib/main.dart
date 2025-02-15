import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:frontend/firebase_options.dart';
import 'package:frontend/repository/authentication_repository/authentication_repository.dart';
import 'package:frontend/views/onboarding.dart';
import 'package:get/get.dart';
import 'utils/theme.dart';
import 'controller/camera.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
  .then((value) => Get.put(AuthenticationRepository()));
  // Initialize the cameras as soon as the app starts
  await CameraProvider().initCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false, 
      home: OnBoardingScreen(),
    );
  }
}

