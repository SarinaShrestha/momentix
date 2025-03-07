import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:frontend/features/authentication/views/login/login.dart';
import 'package:frontend/features/core/views/home/home_page.dart';
import 'package:frontend/features/core/views/home/home_screen.dart';
import 'package:frontend/firebase_options.dart';
import 'package:frontend/repository/authentication_repository/authentication_repository.dart';
import 'package:get/get.dart';
import 'utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
    appleProvider: AppleProvider.debug,
  );

  Get.put(AuthenticationRepository());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false, 
      home: HomePage(),
    );
  }
}

