import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.icon,
      this.height,
      this.width,
      this.backgroundColor,
      this.foregroundColor,
      this.padding,
      this.style,
      this.borderRadius = 48.0});

  final String text;
  final Widget? icon;
  final void Function()? onPressed;
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final EdgeInsetsGeometry? padding;
  final TextStyle? style;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        iconAlignment: IconAlignment.start,
        style: ElevatedButton.styleFrom(
          padding: padding,
          backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[icon!, const SizedBox(width: 6)],
            Text(text,
                style: style ??
                    Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: foregroundColor ?? Colors.white)),
          ],
        ),
      ),
    );
  }
}
