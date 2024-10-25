import 'package:flutter/material.dart';

extension SnackBarExtension on BuildContext {
  void showSnackBar(String message) {
    ScaffoldMessenger.of(this).clearSnackBars();
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
          backgroundColor: Theme.of(this).cardColor,
          content: Text(
            message,
            style: Theme.of(this).textTheme.titleMedium,
          )),
    );
  }
}
