import 'package:flutter/material.dart';
import 'package:frontend/utils/colors.dart';
import 'package:frontend/utils/image_strings.dart';

class ErrorMessageWidget extends StatelessWidget {
  const ErrorMessageWidget({
    super.key, 
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          height: 90,
          decoration: BoxDecoration(
            color: errorRed,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Row(
            children: [
              const SizedBox(width: 48),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Oh Snap!',
                      style: TextStyle(
                        color: white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      )
                    ),
                    const Spacer(),
                    Text(text,
                      style: TextStyle(
                        color: white,
                        fontSize: 12,
                        fontWeight: FontWeight.normal
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
        Positioned(
          top: 10,
          left: 5,
          child: SizedBox(
            height: 60,
            width: 60,
            child: Image(image: AssetImage(errorImage),
            fit: BoxFit.cover,
            )
          ),
        ),
        Positioned(
          top: -20,
          right: 10,
          child: SizedBox(
            height: 48,
            width: 50,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image(image: AssetImage(redBubble)),
                Positioned(
                  height: 10,
                  width: 10,
                  top: 15,
                  child: Image(image: AssetImage(closeButton))),
              ],
            ),
          ))
      ],
    );
  }
}