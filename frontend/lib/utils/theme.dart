import 'package:flutter/material.dart';
import 'package:frontend/utils/themes/widget_themes/form_theme.dart';
import 'package:frontend/utils/themes/widget_themes/text_theme.dart';

class AppTheme{

  AppTheme._();
  
  static ThemeData lightTheme = 
    ThemeData(
      primaryColor: Color(0xFFB4DAF3),
      brightness: Brightness.light,
      textTheme: TextThemes.lightTextTheme,
      inputDecorationTheme: TextFormTheme.formDecorationTheme,
    );
}

  
