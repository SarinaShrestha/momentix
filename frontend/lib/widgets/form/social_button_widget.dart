import 'package:flutter/material.dart';
import 'package:frontend/utils/colors.dart'; // Adjust the path if needed

class SocialButtonWidget extends StatelessWidget {
  final String iconPath;
  final String text;
  final Color bgColor;
  final VoidCallback onPressed;

  const SocialButtonWidget({
    super.key,
    required this.iconPath,
    required this.text,
    required this.bgColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Image.asset(
        iconPath,
        height: 24.0,
        width: 24.0,
      ),
      label: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
          fontSize: 14.0,
          color: white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      ),
    );
  }
}
