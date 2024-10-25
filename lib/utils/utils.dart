import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

Widget platformSpecificTile({
  required Widget leading,
  required Widget title,
  required bool isSelected,
  required VoidCallback onTap,
}) {
  if (Platform.isIOS) {
    return CupertinoDialogAction(
      onPressed: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          title,
          if (isSelected)
            const Icon(
              CupertinoIcons.check_mark_circled_solid,
            ),
        ],
      ),
    );
  } else {
    return ListTile(
      leading: leading,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          title,
          if (isSelected) const Icon(Icons.check_circle_outline_rounded),
        ],
      ),
      onTap: onTap,
    );
  }
}
