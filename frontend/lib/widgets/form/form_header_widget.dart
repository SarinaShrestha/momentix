import 'package:flutter/material.dart';
import 'package:frontend/utils/text_strings.dart';

class FormHeaderWidget extends StatelessWidget {
  const FormHeaderWidget({
    super.key,
    required this.title,
    required this.subTitle,
  });


  final String title, subTitle;
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Text(momentix , style: Theme.of(context).textTheme.titleLarge,),
        SizedBox(height: 10),
        Text(title, style: Theme.of(context).textTheme.headlineLarge,),
        SizedBox(height: 5),
        Text(subTitle, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16),),
        SizedBox(height: 10),
        
      ],
    );
  }
}