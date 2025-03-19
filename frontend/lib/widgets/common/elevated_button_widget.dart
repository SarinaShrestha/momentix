import 'package:flutter/material.dart';
import 'package:frontend/utils/colors.dart';

class ElevatedButtonWidget extends StatelessWidget {
  const ElevatedButtonWidget({
    super.key,
    required this.buttonName, 
    required this.onPressed,
    required this.color,
    this.textColor,
  });

  final String buttonName;
  final VoidCallback onPressed;
  final Color color;
  
  final dynamic textColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        
        backgroundColor: color, // Soft Blue
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: EdgeInsets.symmetric(vertical: 15.0),
      ),
      child: Text(
        buttonName,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600, // 600 weight
          fontSize: 16.0,
          color: white,
        ),
      ),
    );
  }
}