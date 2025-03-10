import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:frontend/features/authentication/controller/register_controller.dart';
import 'package:frontend/utils/colors.dart';
import 'package:frontend/utils/image_strings.dart';
import 'package:frontend/utils/sizes.dart';
import 'package:frontend/utils/text_strings.dart';
import 'package:frontend/features/authentication/views/login/login.dart';
import 'package:frontend/widgets/form/error_message_widget.dart';
import 'package:frontend/widgets/form/form_header_widget.dart';
import 'package:frontend/widgets/common/elevated_button_widget.dart';
import 'package:frontend/widgets/form/login_form_widget.dart';
import 'package:frontend/widgets/form/profile_picture.dart';
import 'package:frontend/widgets/form/social_button_widget.dart';
import 'package:get/get.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  RegistrationPageState createState() => RegistrationPageState();
}

class RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  final GlobalKey<ProfilePictureState> profilePicKey = GlobalKey<ProfilePictureState>();

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

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
                  FormHeaderWidget(title: signUpTitle, subTitle: signUpSubTitle),


                  SizedBox(height: 10),

                  ProfilePicture(key: profilePicKey),

                  SizedBox(height: 10),

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
                          final File? imageFile = profilePicKey.currentState?.imageFile;

                          if (imageFile == null){
                            showDialog(context: context, 
                            builder: (_) => Dialog(
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              child: ErrorMessageWidget(text: 'Please take a picture first'),
                            ));
                            return;
                          }
                          controller.registerUser(context, controller.email.text.trim(), controller.fullName.text.trim(), controller.password.text.trim(), imageFile);
                        }
                      },
                      color: outlineBlue,
                      //onPressed: proceedToNextPage,
                      ),
                  ),

                  SizedBox(height: 20.0),

                  // Divider for Social Login
                  Row(
                    children: [
                      Expanded(child: Divider(color: divider)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'OR',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400, // 400 weight
                            fontSize: 14.0,
                            color: textGray, // Medium Gray
                          ),
                        ),
                      ),
                      Expanded(child: Divider(color: divider)),
                    ],
                  ),

                  SizedBox(height: 20.0),
                // Social Login Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [SocialButtonWidget(
                    iconPath: googleLogo,
                    text: 'Sign up with Google',
                    bgColor: textGray,
                    onPressed: () {
                      // Handle Google sign up
                    },
                  ),
                  ]
                ),
                SizedBox(height: 20.0),
                // Sign-Up Text
                Text.rich(
                  TextSpan(
                    text: alreadyHaveAccount,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400, // 400 weight
                      fontSize: 14.0,
                      color: Color(0xFF555555),
                    ),
                    children: [
                      TextSpan(
                        text: login,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400, // 400 weight
                          fontSize: 14.0,
                          color: Color(0xFF4A90E2), // Soft Blue
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LoginPage()),
                            );
                          },
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 30.0),
              ],    
              ),
            ),
          ),
        )
      )
    );
  }
}
