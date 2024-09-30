import 'package:cost_trackr/screens/chart.dart';
import 'package:cost_trackr/screens/home.dart';
import 'package:cost_trackr/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _selectedPageIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(), // Replace with your actual HomeScreen widget
    const ChartScreen(),
    const ProfileScreen()
  ];

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = _pages[_selectedPageIndex];

    return Scaffold(
      body: SafeArea(
        child: activePage, // Show the selected screen
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_rounded),
            label: 'Statistics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),
            label: 'Profile',
          )
        ],
        currentIndex: _selectedPageIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: _selectPage,
      ),
    );
  }
}
