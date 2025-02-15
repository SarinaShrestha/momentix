import "package:flutter/material.dart";
import "package:frontend/features/authentication/model/onboarding_model.dart";
import "package:frontend/utils/sizes.dart";

class OnBoardingPageWidget extends StatelessWidget {
  const OnBoardingPageWidget({
    super.key,
    required this.model,
  });

  final OnBoardingModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultSize),
      color: model.bgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image(image: AssetImage(model.image), height: model.height * 0.35, width: model.width,),
    
          Column(
            children: [
              Text(model.title, style: Theme.of(context).textTheme.headlineLarge, textAlign: TextAlign.center,),
              SizedBox(height: 25,),
              Text(model.subTitle, textAlign: TextAlign.center),
          ],),
          
          Text(model.counterText, style: Theme.of(context).textTheme.bodyLarge),
          SizedBox(height: 90,)
      ],)
      );
  }
}
