import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/features/authentication/model/user_model.dart';
import 'package:frontend/repository/authentication_repository/authentication_repository.dart';
import 'package:frontend/repository/authentication_repository/exceptions/signup_failure.dart';
import 'package:frontend/repository/user_repository/user_repository.dart';
import 'package:frontend/views/login.dart';
import 'package:frontend/widgets/form/error_message_widget.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final email = TextEditingController();
  final fullName = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  final _authRepo = AuthenticationRepository.instance;
  final _userRepo = Get.put(UserRepository());

  //Validation
  void validateInputs() {

    //Validation for Name
    if (fullName.text.trim().isEmpty) {
      print("Name is empty");
      throw SignUpFailure.code('emptyName');
    } else if (fullName.text.trim().length < 3) {
      throw SignUpFailure.code('invalidName');
    }

    //Validation for Email
    if (email.text.trim().isEmpty) {
      throw SignUpFailure.code('emptyEmail');
    } else if (!GetUtils.isEmail(email.text.trim())) {
      throw SignUpFailure.code('invalidEmail');
    }

    //Validation for Password
    if (password.text.trim().isEmpty) {
      throw SignUpFailure.code('emptyPassword');
    } else if (password.text.trim().length < 6) {
      throw SignUpFailure.code('weakPassword');
    }

    //Validation for Confirm Password
    if (confirmPassword.text.trim().isEmpty) {
      throw SignUpFailure.code('emptyConfirmPassword');
    } else if (confirmPassword.text.trim() != password.text.trim()) {
      throw SignUpFailure.code('passwordMismatch');
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

  Future<void> registerUser(BuildContext context, String email, String fullName, String password) async{
    try{
      validateInputs();

      // Create user in Firebase Authentication
      UserCredential authUser = await _authRepo.createUserWithEmailAndPassword(email, password);

      // Create user in Firestore Database
      UserModel user = UserModel(
        id: authUser.user!.uid,
        email: email.trim(), 
        name: fullName.trim(), 
        password: password.trim(),
      );

      await _userRepo.createUser(authUser.user!.uid, user);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.snackbar("Success", "The account has been created.",
        snackPosition: SnackPosition.BOTTOM,  
        backgroundColor: Colors.green,
        colorText: Colors.white,
        margin: EdgeInsets.all(20),
        borderRadius: 10,
        duration: Duration(seconds: 3),
        isDismissible: true,
        forwardAnimationCurve: Curves.easeOutBack,
        reverseAnimationCurve: Curves.easeInBack,
        animationDuration: Duration(milliseconds: 200),
        );
      });
      

      await Future.delayed(Duration(seconds: 3));

      Get.to(() => const LoginPage());

    } on SignUpFailure catch (e) {
      print("Inside SignUpFailure catch block");
      showMessage(context, ErrorMessageWidget(text: e.message));
    } catch (e) {
    // Handle any other unexpected errors
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.snackbar(
        "Error",
        "Something went wrong. Please try again later.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: EdgeInsets.all(20),
        borderRadius: 10,
        duration: Duration(seconds: 3),
        isDismissible: true,
      );
  });
  return;
  }
}}