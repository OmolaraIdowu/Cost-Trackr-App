import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.iconColor,
  });

  final Widget icon;
  final Color? iconColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: icon,
      color: iconColor,
      iconSize: 30,
      splashColor: Theme.of(context).primaryColor,
      onPressed: onPressed,
    );
  }
}
