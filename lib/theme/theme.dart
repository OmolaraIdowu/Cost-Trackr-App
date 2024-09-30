import 'package:cost_trackr/theme/button_theme.dart';
import 'package:cost_trackr/theme/text_theme.dart';
import 'package:cost_trackr/theme/textfield_theme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      textTheme: AppTextTheme.lightTextTheme,
      brightness: Brightness.light,
      cardColor: const Color(0xFFF5F5F5),
      primaryColor: const Color(0xFF005CE7),
      primaryColorLight: Colors.white,
      primaryColorDark: Colors.black,
      scaffoldBackgroundColor: Colors.white,
      disabledColor: Colors.grey,
      elevatedButtonTheme: AppElevatedButtonTheme.lightElevatedButtonTheme,
      inputDecorationTheme: AppTextFormFieldTheme.lightInputDecorationTheme);

  static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      textTheme: AppTextTheme.darkTextTheme,
      brightness: Brightness.dark,
      cardColor: const Color(0xFF081221),
      primaryColor: const Color(0xFF005CE7),
      primaryColorLight: Colors.black,
      primaryColorDark: Colors.white,
      disabledColor: Colors.grey,
      scaffoldBackgroundColor: const Color(0xFF000917),
      elevatedButtonTheme: AppElevatedButtonTheme.darkElevatedButtonTheme,
      inputDecorationTheme: AppTextFormFieldTheme.darkInputDecorationTheme);
}
