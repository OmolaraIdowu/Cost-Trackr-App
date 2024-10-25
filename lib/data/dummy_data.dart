import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

List<Map<String, dynamic>> transactionsData = [
  {
    'icon': SvgPicture.asset('assets/icons/travel.svg'),
    'color': Colors.green,
    'name': 'Travel',
    'totalAmount': '-\$45.00',
    'date': 'Today',
  },
  {
    'icon': SvgPicture.asset('assets/icons/food.svg'),
    'color': Colors.pink,
    'name': 'Food',
    'totalAmount': '-\$50.00',
    'date': 'Today',
  },
  {
    'icon': SvgPicture.asset('assets/icons/utility.svg'),
    'color': Colors.purple,
    'name': 'Utility',
    'totalAmount': '-\$4.00',
    'date': 'Today',
  },
  {
    'icon': SvgPicture.asset('assets/icons/home.svg'),
    'color': Colors.green,
    'name': 'Essentials',
    'totalAmount': '-\$45.00',
    'date': 'Yesterday',
  },
  {
    'icon': SvgPicture.asset('assets/icons/profile.svg'),
    'color': Colors.blue,
    'name': 'Tech',
    'totalAmount': '-\$45.00',
    'date': 'Yesterday',
  },
];
