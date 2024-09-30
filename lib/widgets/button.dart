import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.height,
    this.width,
    this.backgroundColor,
    this.foregroundColor,
  });

  final String text;
  final Widget? icon;
  final void Function()? onPressed;
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        iconAlignment: IconAlignment.start,
        style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? Theme.of(context).primaryColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[icon!, const SizedBox(width: 6)],
            Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: foregroundColor ?? Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
