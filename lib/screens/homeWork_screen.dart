import 'package:flutter/material.dart';
import 'package:risho_guru/screens/Dekstop/homework_screen_desktop.dart';
import 'package:risho_guru/screens/Mobile/homework_screen_mobile.dart';
import 'package:risho_guru/screens/Tablet/homework_screen_tablet.dart';

import '../responsive/responsive_layout.dart';

class HomeWorkScreen extends StatefulWidget {
  const HomeWorkScreen({super.key});

  @override
  State<HomeWorkScreen> createState() => _HomeWorkScreenState();
}

class _HomeWorkScreenState extends State<HomeWorkScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        mobileScaffold: HomeWorkScreenMobile(),
        tabletScaffold: HomeWorkScreenTablet(),
        desktopScaffold: HomeWorkScreenDesktop(),
      ),
    );
  }
}
