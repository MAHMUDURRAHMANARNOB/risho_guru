import 'package:flutter/material.dart';
import 'package:risho_guru/screens/Dekstop/courses_screen_desktop.dart';
import 'package:risho_guru/screens/Mobile/courses_screen_mobile.dart';
import 'package:risho_guru/screens/Tablet/courses_screen_tablet.dart';

import '../responsive/responsive_layout.dart';

class CoursesScreen extends StatefulWidget {
  static const String id = "courses_screen";
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        mobileScaffold: CoursesScreenMobile(),
        tabletScaffold: CoursesScreenTablet(),
        desktopScaffold: CoursesScreenDesktop(),
      ),
    );
  }
}
