import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:feb25prac/configs/colors.dart';
import 'package:feb25prac/views/screens/auth/home_screen.dart';
import 'package:feb25prac/views/screens/auth/orders.dart';
import 'package:feb25prac/views/screens/auth/proflie.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [const HomeScreen(), const Orders(), const ProfilePage()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,

      body: _pages[_currentIndex],

      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        color: const Color(0xFFB99099),
        backgroundColor: colorBackground,
        buttonBackgroundColor: const Color(0xFF935661),
        animationDuration: const Duration(milliseconds: 300),
        items: const [
          Icon(Icons.home, size: 30, color: Colors.black),
          Icon(Icons.list, size: 30, color: Colors.black),
          Icon(Icons.person, size: 30, color: Colors.black),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
