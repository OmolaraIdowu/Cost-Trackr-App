import 'package:cost_trackr/widgets/button_icon_bg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Welcome Lara',
          style:
              Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 16),
        ),
        const Spacer(),
        CustomIconButton(
          icon: SvgPicture.asset('assets/icons/notification.svg'),
          backgroundColor: Theme.of(context).cardColor,
        ),
        const SizedBox(width: 6),
        CustomIconButton(
          icon: SvgPicture.asset(
            'assets/icons/theme.svg',
            colorFilter: ColorFilter.mode(
              Theme.of(context).primaryColorDark,
              BlendMode.srcIn,
            ),
          ),
          backgroundColor: Theme.of(context).cardColor,
        ),
        const SizedBox(width: 6),
        CustomIconButton(
          icon: Icon(
            Icons.more_vert_rounded,
            color: Theme.of(context).primaryColorDark,
          ),
          backgroundColor: Theme.of(context).cardColor,
        ),
      ],
    );
  }
}
