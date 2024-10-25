import 'dart:io';
import 'package:cost_trackr/widgets/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({
    super.key,
    required this.title,
    required this.actions,
    required this.onConfirm,
  });

  final String title;
  final List<Widget> actions;
  final VoidCallback onConfirm;

  void show(BuildContext context) {
    if (Platform.isIOS) {
      // Show Cupertino-style bottom sheet for iOS
      showCupertinoModalPopup(
        context: context,
        builder: (ctx) {
          return CupertinoActionSheet(
            title: Text(title),
            actions: actions,
            cancelButton: CupertinoActionSheetAction(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              isDefaultAction: true,
              child: const Text('Cancel'),
            ),
          );
        },
      );
    } else {
      // Show Material-style bottom sheet for Android
      showModalBottomSheet(
        context: context,
        showDragHandle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        builder: (ctx) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                ...actions,
                const SizedBox(height: 16),
                CustomButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    onConfirm();
                  },
                  text: 'Save',
                ),
                const SizedBox(height: 8),
              ],
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox
        .shrink(); // This widget should be shown using the `show` method
  }
}
