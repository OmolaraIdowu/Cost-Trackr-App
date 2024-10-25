import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialog {
  static void show({
    required BuildContext context,
    required String title,
    required String content,
    String cancelText = 'Cancel',
    String confirmText = 'Yes',
    required VoidCallback onConfirm,
  }) {
    final theme = Theme.of(context);

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog.adaptive(
          title: Text(
            title,
            style: theme.textTheme.titleMedium,
          ),
          content: Text(content, style: theme.textTheme.bodyMedium),
          backgroundColor: theme.cardColor,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text(
                cancelText,
                style: theme.textTheme.labelMedium,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                onConfirm();
              },
              child: Text(
                confirmText,
                style: theme.textTheme.labelMedium!.copyWith(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  static void showSelectionDialog<T>({
    required BuildContext context,
    required String title,
    required List<T> options,
    required T selectedOption,
    required Function(T) onOptionSelected,
    required String Function(T) optionLabel,
    String cancelText = 'Cancel',
  }) {
    if (Platform.isIOS) {
      showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return CupertinoActionSheet(
            title: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.grey),
            ),
            actions: options.map((option) {
              return CupertinoActionSheetAction(
                onPressed: () {
                  onOptionSelected(option);
                  Navigator.pop(context);
                },
                child: Text(
                  optionLabel(option),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              );
            }).toList(),
            cancelButton: CupertinoActionSheetAction(
              isDefaultAction: true,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(cancelText,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontSize: 16, color: Theme.of(context).primaryColor)),
            ),
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).cardColor,
            title: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Colors.grey),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: options.map((option) {
                  return RadioListTile<T>(
                    activeColor: Theme.of(context).primaryColor,
                    title: Text(
                      optionLabel(option),
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    value: option,
                    groupValue: selectedOption,
                    onChanged: (value) {
                      onOptionSelected(value as T);
                      Navigator.pop(context);
                    },
                  );
                }).toList(),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(cancelText,
                    style: Theme.of(context).textTheme.labelMedium),
              ),
            ],
          );
        },
      );
    }
  }
}
