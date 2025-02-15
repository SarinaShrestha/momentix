import 'package:flutter/material.dart';
import 'package:frontend/utils/text_strings.dart';

class FormHeaderWidget extends StatelessWidget {
  const FormHeaderWidget({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
  });


  final String image, title, subTitle;
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Text(momentix , style: Theme.of(context).textTheme.titleLarge,),
        SizedBox(height: 10),
        Text(title, style: Theme.of(context).textTheme.headlineLarge,),
        Text(subTitle, style: Theme.of(context).textTheme.bodyMedium),
        SizedBox(height: 10),
        Image(image: AssetImage(image), height: size.height * 0.2),
        SizedBox(height: 20,),
      ],
    );
  }
}