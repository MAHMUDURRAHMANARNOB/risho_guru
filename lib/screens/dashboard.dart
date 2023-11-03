import 'package:flutter/material.dart';
import 'package:risho_guru/responsive/navigation_page.dart';
import 'package:risho_guru/screens/courses_screen.dart';
import 'package:risho_guru/screens/packages_screen.dart';
import 'package:risho_guru/screens/study_section_screen.dart';
import 'package:risho_guru/screens/tools_screen.dart';

import 'Common/navigation_drawer.dart';
import 'Common/screens_manager.dart';
import 'calendar_screen.dart';

class Dashboard extends StatefulWidget {
  static const String id = "dashboard_screen";

  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int selectedIndex = 0;

  void handleScreenChange(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: Text('DASHBOARD'),
      ),*/
      // Add the navigation drawer to the Scaffold
      body: NavigationPage(),
    );
  }
}
