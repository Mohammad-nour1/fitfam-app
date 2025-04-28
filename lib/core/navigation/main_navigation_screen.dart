import 'package:fitfam2/modules/family/view/family_activity_screen.dart';
import 'package:fitfam2/modules/home/bloc/home_bloc.dart';
import 'package:fitfam2/modules/home/bloc/home_event.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../modules/home/view/home_screen.dart';
import '../../modules/challenges/view/challenges_screen.dart';
import '../../modules/profile/view/profile_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    BlocProvider(
      create: (_) => HomeBloc()..add(LoadHomeDataEvent()),
      child: const HomeScreen(),
    ),
    const ChallengesScreen(),
    const FamilyActivityScreen(),
    const ProfileScreen(),
  ];

  final List<Widget> _navIcons = const [
    Icon(Icons.home, size: 30, color: Colors.black),
    Icon(Icons.flag, size: 30, color: Colors.black),
    Icon(Icons.group, size: 30, color: Colors.black),
    Icon(Icons.person, size: 30, color: Colors.black),
  ];

  final List<String> _titles = [
    'الرئيسية',
    'التحديات',
    'العائلة',
    'الملف الشخصي',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF012532),
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
        backgroundColor: const Color(0xFF012532),
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: const Color(0xFF012532),
        color: const Color(0xFF8CEE2B),
        animationDuration: const Duration(milliseconds: 300),
        index: _selectedIndex,
        items: _navIcons,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
