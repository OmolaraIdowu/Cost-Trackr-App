import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.icon,
    required this.backgroundColor,
    this.iconColor,
    this.size = 24.0,
    this.onPressed,
  });

  final Widget icon;
  final Color backgroundColor;
  final Color? iconColor;
  final double size;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size + 20,
      height: size + 20,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: IconButton(
        icon: icon,
        color: iconColor,
        onPressed: onPressed, // Remove default constraints
      ),
    );
  }
}
