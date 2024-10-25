import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.onTap,
    this.hasSwitch = false,
    this.isSwitchOn,
    this.onSwitchChanged,
    this.style,
    this.subtitleStyle,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final void Function()? onTap;
  final bool hasSwitch;
  final bool? isSwitchOn;
  final ValueChanged<bool>? onSwitchChanged;
  final TextStyle? style;
  final TextStyle? subtitleStyle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
      leading: Icon(icon, color: Theme.of(context).primaryColorDark),
      title: Text(title,
          style: style ??
              Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.w500)),
      subtitle: subtitle != null
          ? Text(subtitle!,
              style: subtitleStyle ?? Theme.of(context).textTheme.bodySmall)
          : null,
      trailing: hasSwitch
          ? Switch.adaptive(
              activeColor: Theme.of(context).primaryColor,
              value: isSwitchOn ?? false,
              onChanged: onSwitchChanged,
            )
          : Icon(
              Icons.arrow_forward_ios_rounded,
              color: Theme.of(context).primaryColorDark,
              size: 14,
            ),
      onTap: onTap,
    );
  }
} //arrow_forward_ios_rounded
