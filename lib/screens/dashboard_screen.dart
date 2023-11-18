import 'package:flutter/material.dart';
import 'package:risho_guru/screens/Dekstop/courses_screen_desktop.dart';
import 'package:risho_guru/screens/Mobile/courses_screen_mobile.dart';
import 'package:risho_guru/screens/Tablet/courses_screen_tablet.dart';

import '../responsive/responsive_layout.dart';
import 'Dekstop/dashboard_screen_desktop.dart';
import 'Mobile/dashboard_screen_mobile.dart';
import 'Tablet/dashboard_screen_tablet.dart';

class DashboardScreen extends StatefulWidget {
  static const String id = "Dashboard_Screen";
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        mobileScaffold: DashboardScreenMobile(),
        tabletScaffold: DashboardScreenTablet(),
        desktopScaffold: DashboardScreenDesktop(),
      ),
    );
  }
}
