import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:frontend/controller/register_controller.dart';
import 'package:frontend/utils/colors.dart';
import 'package:frontend/utils/image_strings.dart';
import 'package:frontend/utils/sizes.dart';
import 'package:frontend/utils/text_strings.dart';
import 'package:frontend/views/signup.dart';
import 'package:frontend/widgets/form/form_header_widget.dart';
import 'package:frontend/widgets/common/elevated_button_widget.dart';
import 'package:frontend/views/home.dart';
import 'package:frontend/widgets/form/login_form_widget.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart'; // Adjust the path as necessary

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    
    final controller = Get.put(SignUpController());
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horiPadding),
            child: Column(
              children: [
                FormHeaderWidget(title: loginTitle, subTitle: loginSubTitle),
                Image(image: AssetImage(loginImage), height: size.height * 0.2),
                SizedBox(height: 20,),

                //Form
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LoginFormWidget(text: email, hintText: hintEmail, controller: controller.fullName,),

                    LoginFormWidget(text: password, hintText: hintPassword, controller: controller.fullName,),

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: (){
    
                        }, 
                        style: TextButton.styleFrom(
                          foregroundColor: outlineBlue,
                          textStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                      child: Text(forgotPassword)
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20,),
                // Login Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButtonWidget(buttonName: login,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },),
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
                  children: [
                    _buildSocialButton(googleLogo, google, textGray),
                  ],
                ),
                SizedBox(height: 20.0),
                // Sign-Up Text
                Text.rich(
                  TextSpan(
                    text: dontHaveAccount,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400, // 400 weight
                      fontSize: 14.0,
                      color: Color(0xFF555555),
                    ),
                    children: [
                      TextSpan(
                        text: 'Sign Up',
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
                              MaterialPageRoute(builder: (context) => RegistrationPage()),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton(String iconPath, String text, Color bgColor) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Image.asset(
        iconPath,
        height: 24.0,
        width: 24.0,
      ),
      label: Text(
        text,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500, // 500 weight
          fontSize: 14.0,
          color: white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      ),
    );
  }
}





