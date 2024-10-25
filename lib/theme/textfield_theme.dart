import 'package:flutter/material.dart';

class AppTextFormFieldTheme {
  AppTextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 2,
    filled: true,
    hintStyle: const TextStyle()
        .copyWith(fontSize: 14, color: Colors.grey, fontFamily: 'Poppins'),
    helperMaxLines: 3,
    helperStyle: const TextStyle().copyWith(
        fontSize: 8.5,
        color: Colors.grey,
        fontFamily: 'Poppins',
        fontStyle: FontStyle.italic),
    fillColor: const Color(0xFFF3F8FF),
    floatingLabelStyle:
        const TextStyle().copyWith(color: Colors.black.withOpacity(0.8)),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    border: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(width: 0, color: Colors.transparent),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(width: 1.5, color: Color(0xFF005CE7)),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(width: 1.5, color: Colors.red),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(width: 1.5, color: Colors.red),
    ),
  );

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 2,
    filled: true,
    isDense: true,
    hintStyle: const TextStyle()
        .copyWith(fontSize: 14, color: Colors.grey, fontFamily: 'Poppins'),
    helperMaxLines: 3,
    helperStyle: const TextStyle().copyWith(
        fontSize: 8.5,
        color: Colors.grey,
        fontFamily: 'Poppins',
        fontStyle: FontStyle.italic),
    fillColor: const Color(0xFF081221),
    floatingLabelStyle:
        const TextStyle().copyWith(color: Colors.white.withOpacity(0.8)),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    border: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(width: 0, color: Colors.transparent),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(width: 1.5, color: Color(0xFF005CE7)),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(width: 1.5, color: Colors.red),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(width: 1.5, color: Colors.red),
    ),
  );
}
