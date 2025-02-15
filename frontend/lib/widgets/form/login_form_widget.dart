import 'package:flutter/material.dart';

import 'package:frontend/utils/sizes.dart';


class LoginFormWidget extends StatelessWidget {
  const LoginFormWidget({
    super.key,
    required this.text,
    required this.hintText,
    required this.controller,
  });

  final String text, hintText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Email
        Text(text, style: Theme.of(context).textTheme.bodyMedium),
        SizedBox(height: 8,),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText
          )
        ),
        SizedBox(height: formHeight - 10),
    
      ],
    );
  }
}
