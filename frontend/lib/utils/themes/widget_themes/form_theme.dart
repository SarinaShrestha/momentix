import 'package:flutter/material.dart';
import 'package:frontend/utils/colors.dart';

class TextFormTheme {
  TextFormTheme._();

  static InputDecorationTheme formDecorationTheme =
    InputDecorationTheme(
      filled: true,
      fillColor: offWhite,
      hintStyle: TextStyle(
        fontFamily: 'Poppins',
          fontWeight: FontWeight.w300,
          fontSize: 16,
          color: hintTextColor
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: outlineBlue,
          width: 2
        )
      )
    );
  }










