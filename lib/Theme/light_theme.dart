import 'package:flutter/material.dart';
import 'package:stitch_craft/res/color.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(color: Colors.black, fontSize: 20)),
  colorScheme: ColorScheme.light(
      background: Colors.grey[300]!,
      primary: Colors.grey[200]!,
      secondary: Colors.grey[300]!),
  textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: Colors.black)),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: AppColors.primaryColor, // Replace with your desired color
    selectionColor: AppColors.primaryColor
        .withOpacity(0.4), // Optional: text selection highlight color
    selectionHandleColor:
        AppColors.primaryColor, // Optional: text selection handle color
  ),

);
