import 'package:flutter/material.dart';

class TextThemes {
  static TextTheme lightTextTheme = TextTheme(
        // Bold headline text
    headlineLarge: TextStyle(
      fontFamily: 'Poppins', 
      fontWeight: FontWeight.w700,
      fontSize: 30,
      color: Colors.black87,
    ),

    // Normal font for larger text
    titleMedium : TextStyle(
      fontFamily: 'Poppins', 
      fontWeight: FontWeight.w400,
      color: Colors.black54,
      fontSize: 25,
    ),

    // Bold font for medium sized text
    bodyLarge : TextStyle(
      fontFamily: 'Poppins', 
      fontWeight: FontWeight.w600,
      color: Colors.black,
      fontSize: 18,
    ),

    // Normal text Regular Greyish Color
    bodyMedium : TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w400,
      color: Color(0xFF555555),
      fontSize: 15,
    ),

    bodySmall: TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w300,
      fontSize: 16,
      color: Color(0xFFAAAAAA)
    ),

    //Momentix
    titleLarge: TextStyle(
      fontFamily: 'Oleo',
      fontWeight: FontWeight.w400,
      color: Colors.black,
      fontSize: 34
    )
  );
}