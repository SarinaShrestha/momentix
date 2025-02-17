import 'package:flutter/material.dart';
import 'package:frontend/controller/register_controller.dart';
import 'package:frontend/utils/colors.dart';
import 'package:frontend/utils/sizes.dart';
import 'package:frontend/utils/text_strings.dart';
import 'package:frontend/widgets/form/form_header_widget.dart';
import 'package:frontend/widgets/common/elevated_button_widget.dart';
import 'package:frontend/widgets/form/login_form_widget.dart';
import 'package:frontend/widgets/form/profile_picture.dart';
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
                  FormHeaderWidget(title: signUpTitle, subTitle: signUpSubTitle),


                  SizedBox(height: 10),

                  ProfilePictureWidget(),

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
