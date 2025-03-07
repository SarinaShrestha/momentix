import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/repository/authentication_repository/authentication_repository.dart';
import 'package:frontend/repository/authentication_repository/exceptions/login_failure.dart';
import 'package:frontend/views/home.dart';
import 'package:frontend/widgets/form/error_message_widget.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();

  final _authRepo = AuthenticationRepository.instance;

  // Validation for login inputs
  void validateLoginInputs() {
    if (email.text.trim().isEmpty) {
      throw LoginFailure.code('emptyEmail');
    } else if (!GetUtils.isEmail(email.text.trim())) {
      throw LoginFailure.code('invalidEmail');
    }

    if (password.text.trim().isEmpty) {
      throw LoginFailure.code('emptyPassword');
    }
  }

  void showMessage(BuildContext context, Widget message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: message,
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        padding: EdgeInsets.zero,
      ),
      );
    }


  // Login user with Firebase Authentication
  Future<void> loginUser(BuildContext context) async {
    try {
      validateLoginInputs();

      await _authRepo.loginUserWithEmailAndPassword(
        email.text.trim(),
        password.text.trim(),
      );

      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.snackbar(
          "Welcome Back!",
          "Login successful.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          margin: const EdgeInsets.all(20),
          borderRadius: 10,
          duration: const Duration(seconds: 3),
          isDismissible: true,
        );
      });

      await Future.delayed(const Duration(seconds: 3));
      Get.offAll(() => const HomePage()); // Redirecting to Home after login

    } on FirebaseAuthException catch (e) {
      showMessage(context, ErrorMessageWidget(text: e.message ?? 'An unknown error occurred.'));

    } on LoginFailure catch (e) {
      showMessage(context, ErrorMessageWidget(text: e.message));
      
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.snackbar(
          "Error",
          "Something went wrong. Please try again later.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: const EdgeInsets.all(20),
          borderRadius: 10,
          duration: const Duration(seconds: 3),
          isDismissible: true,
        );
      });
    }
  }
}