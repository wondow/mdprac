import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import '../../../configs/theme.dart';
import 'home_screen.dart';
import 'orders.dart';
import 'proflie.dart';


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
      backgroundColor: AppTheme.background,
      body: _pages[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        color: AppTheme.primaryContainer,
        backgroundColor: AppTheme.background,
        buttonBackgroundColor: AppTheme.primary,
        animationDuration: const Duration(milliseconds: 300),
        items: const [
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.list, size: 30, color: Colors.white),
          Icon(Icons.person, size: 30, color: Colors.white),
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