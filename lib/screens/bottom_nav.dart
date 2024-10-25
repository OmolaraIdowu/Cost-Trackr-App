import 'dart:io';

import 'package:cost_trackr/screens/pages/home.dart';
import 'package:cost_trackr/screens/pages/profile.dart';
import 'package:cost_trackr/screens/pages/statistics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _selectedPageIndex = 0;

  // List of pages for navigation
  final List<Widget> _pages = [
    const HomeScreen(),
    const StatisticsScreen(),
    const ProfileScreen(),
  ];

  // Map of navigation items
  final Map<String, Icon> _navigationItems = {
    'Home': Platform.isIOS
        ? const Icon(CupertinoIcons.home)
        : const Icon(Icons.home_outlined),
    'Statistics': Platform.isIOS
        ? const Icon(CupertinoIcons.chart_bar)
        : const Icon(Icons.bar_chart_outlined),
    'Profile': Platform.isIOS
        ? const Icon(CupertinoIcons.person)
        : const Icon(Icons.person_outline_rounded),
  };

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Widget activePage = _pages[_selectedPageIndex];
    String? activePageTitle =
        _navigationItems.keys.elementAt(_selectedPageIndex);

    Color? appBarBackgroundColor;
    TextStyle? appBarTextStyle;

    if (_selectedPageIndex == 2) {
      // ProfileScreen
      appBarBackgroundColor = theme.primaryColor;
      appBarTextStyle = theme.textTheme.headlineMedium!.copyWith(
        color: Colors.white,
      );
    } else {
      appBarBackgroundColor = theme.scaffoldBackgroundColor;
    }

    return Scaffold(
      appBar: (_selectedPageIndex != 0)
          ? AppBar(
              title: Text(
                activePageTitle,
                style: appBarTextStyle,
              ),
              backgroundColor: appBarBackgroundColor,
              automaticallyImplyLeading: false,
            )
          : null,
      body: SafeArea(
        child: activePage,
      ),
      bottomNavigationBar: Platform.isIOS
          ? CupertinoTabBar(
              backgroundColor: theme.shadowColor,
              activeColor: theme.primaryColor,
              currentIndex: _selectedPageIndex,
              onTap: _selectPage,
              items: _navigationItems.entries
                  .map(
                    (entry) => BottomNavigationBarItem(
                      icon: entry.value,
                      label: entry.key,
                    ),
                  )
                  .toList(),
            )
          : NavigationBar(
              overlayColor:
                  WidgetStatePropertyAll(theme.scaffoldBackgroundColor),
              backgroundColor: theme.cardColor,
              indicatorColor: theme.primaryColor,
              selectedIndex: _selectedPageIndex,
              onDestinationSelected: _selectPage,
              destinations: _navigationItems.entries
                  .map(
                    (entry) => NavigationDestination(
                      icon: entry.value,
                      label: entry.key,
                    ),
                  )
                  .toList(),
            ),
    );
  }
}
