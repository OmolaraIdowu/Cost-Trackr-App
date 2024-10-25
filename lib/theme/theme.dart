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
    cardColor: const Color(0xFFF3F8FF),
    shadowColor: Colors.white,
    primaryColor: const Color(0xFF005CE7),
    primaryColorLight: Colors.white,
    primaryColorDark: Colors.black,
    scaffoldBackgroundColor: Colors.white,
    disabledColor: Colors.grey,
    elevatedButtonTheme: AppElevatedButtonTheme.lightElevatedButtonTheme,
    inputDecorationTheme: AppTextFormFieldTheme.lightInputDecorationTheme,
    appBarTheme: AppBarTheme(
      titleTextStyle: AppTextTheme.lightTextTheme.headlineMedium,
      centerTitle: true,
      backgroundColor: Colors.white,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 6,
      selectedItemColor: const Color(0xFF005CE7),
      unselectedItemColor: Colors.grey,
      selectedLabelStyle: AppTextTheme.lightTextTheme.titleMedium,
      unselectedLabelStyle: AppTextTheme.lightTextTheme.titleSmall,
      backgroundColor: const Color(0xFFF3F8FF),
    ),
  );
//1A1E2A
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    textTheme: AppTextTheme.darkTextTheme,
    brightness: Brightness.dark,
    cardColor: const Color(0xFF081221),
    shadowColor: const Color(0xFF15243C),
    primaryColor: const Color(0xFF005CE7),
    primaryColorLight: Colors.black,
    primaryColorDark: Colors.white,
    disabledColor: Colors.grey,
    scaffoldBackgroundColor: const Color(0xFF000917),
    elevatedButtonTheme: AppElevatedButtonTheme.darkElevatedButtonTheme,
    inputDecorationTheme: AppTextFormFieldTheme.darkInputDecorationTheme,
    appBarTheme: AppBarTheme(
      titleTextStyle: AppTextTheme.darkTextTheme.headlineMedium,
      centerTitle: true,
      backgroundColor: const Color(0xFF000917),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 6,
      selectedItemColor: const Color(0xFF005CE7),
      unselectedItemColor: Colors.grey,
      selectedLabelStyle: AppTextTheme.darkTextTheme.titleMedium,
      unselectedLabelStyle: AppTextTheme.darkTextTheme.titleSmall,
      backgroundColor: const Color(0xFF081221),
    ),
  );
}
