import 'package:flutter/material.dart';

class AppElevatedButtonTheme {
  AppElevatedButtonTheme._();

  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        elevation: 1,
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF005CE7),
        disabledBackgroundColor: const Color(0xFFD8DAE0),
        disabledForegroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        side: BorderSide.none,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(48),
        ),
        iconColor: Colors.white),
  );

  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        elevation: 1,
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF005CE7),
        disabledBackgroundColor: const Color(0xFF111418),
        disabledForegroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        side: BorderSide.none,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(48),
        ),
        iconColor: Colors.black),
  );
}
