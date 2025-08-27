import 'package:flutter/material.dart';
import 'package:medical_app/config/responsive/main_responsive.dart';
import 'package:medical_app/modules/screen/view/Message_screen.dart';
import 'package:medical_app/modules/screen/view/booking_screen.dart';
import 'package:medical_app/modules/screen/view/home_screen.dart';
import 'package:medical_app/modules/screen/view/profile_screens.dart';
import 'package:medical_app/widgets/bottom_navigation.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedPage = 0;
  final List _listPages = [];

  @override
  void initState() {
    super.initState();
    _listPages.addAll([
      MainResponsive(small: HomeScreen()),
      MainResponsive(small: MessageScreen()),
      MainResponsive(small: ProfileScreens()),
      MainResponsive(small: BookingScreen()),
    ]);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listPages[_selectedPage],
      backgroundColor: Colors.white,
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedPage,
        onTap: _onItemTapped,
      ),
    );
  }
}
