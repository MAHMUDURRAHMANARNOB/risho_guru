import 'package:flutter/material.dart';
import 'package:risho_guru/screens/Dekstop/calendar_screen_desktop.dart';
import 'package:risho_guru/screens/Mobile/calendar_screen_mobile.dart';
import 'package:risho_guru/screens/Tablet/calendar_screen_tablet.dart';

import '../responsive/responsive_layout.dart';

class CalendarScreen extends StatefulWidget {
  static const String id = "calendar_screen";
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        mobileScaffold: CalendarScreenMobile(),
        tabletScaffold: CalendarScreenTablet(),
        desktopScaffold: CalendarScreenDesktop(),
      ),
    );
  }
}
