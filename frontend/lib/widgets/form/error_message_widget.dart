import 'package:flutter/material.dart';
import 'package:frontend/utils/colors.dart';
import 'package:frontend/utils/image_strings.dart';

class ErrorMessageWidget extends StatelessWidget {
  const ErrorMessageWidget( {
    super.key, 
    required this.text,
  });

  final String text;
  

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          //height: 0.15* size.height,
          width: 0.95*size.width,
          //bottom: 10,
          child: Container(
            padding: const EdgeInsets.all(15),
            height: 0.13 * size.height,
            clipBehavior: Clip.none,
          
            decoration: BoxDecoration(
              color: errorRed,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            child: Row(
              children: [
                const SizedBox(width: 48),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Oh Snap!',
                        style: TextStyle(
                          color: Colors.white, 
                          fontSize: 16, 
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        text,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // Error Image
        Positioned(
          top: 10,
          left: 5,
          child: SizedBox(
            height: 60,
            width: 60,
            child: Image.asset(errorImage, fit: BoxFit.cover),
          ),
        ),
        // Close Button
        Positioned(
          top: -20,
          right: 10,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Image.asset(redBubble, height: 60, width: 60),
              Positioned(
                top: 15,
                child: Image.asset(closeButton, height: 20, width: 20),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
