import 'package:flutter/material.dart';

class AppTextTheme {
  AppTextTheme._();

  static TextTheme lightTextTheme = const TextTheme(
    titleSmall: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.normal,
        fontSize: 14,
        color: Colors.black),
    titleMedium: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: Colors.black),
    titleLarge: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: Colors.black),
    headlineMedium: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.bold,
        fontSize: 14,
        color: Color(0xFF005CE7)),
  );

  static TextTheme darkTextTheme = const TextTheme(
    titleSmall: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.normal,
        fontSize: 14,
        color: Colors.white),
    titleMedium: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: Colors.white),
    titleLarge: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: Colors.white),
    headlineMedium: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.bold,
        fontSize: 14,
        color: Color(0xFF005CE7)),
  );
}
