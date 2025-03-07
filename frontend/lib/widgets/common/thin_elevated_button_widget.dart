import 'package:flutter/material.dart';
import 'package:frontend/utils/colors.dart';

class ThinElevatedButtonWidget extends StatelessWidget {
  const ThinElevatedButtonWidget({
    super.key,
    required this.buttonName, 
    required this.onPressed,
    required this.color,
    this.textColor,
    required this.outlined
  });

  final String buttonName;
  final VoidCallback onPressed;
  final Color color;
  final bool outlined;
  final dynamic textColor;

  @override
  Widget build(BuildContext context) {
    if (outlined == true) {
      return OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: white,
          backgroundColor: black,
          side: const BorderSide(color: buttonYellow, width: 2.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          padding: EdgeInsets.symmetric(vertical: 10.0),
        ),
        child: Text(
          buttonName,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600, // 600 weight
            fontSize: 15.0,
            color: textColor ?? white,
          ),
        ),
      );
    } else {
      return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonYellow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          padding: EdgeInsets.symmetric(vertical: 10.0),
        ),
        child: Text(
          buttonName,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600, // 600 weight
            fontSize: 15.0,
            color: black,
          ),
        ),
      );
    }
  }
}