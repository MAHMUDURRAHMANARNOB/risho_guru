import 'package:flutter/material.dart';
import 'package:risho_guru/screens/Dekstop/packages_screen_desktop.dart';
import 'package:risho_guru/screens/Mobile/packages_screen_mobile.dart';
import 'package:risho_guru/screens/Tablet/packages_screen_tablet.dart';

import '../responsive/responsive_layout.dart';

class PackagesScreen extends StatefulWidget {
  static const String id = "packages_screen";
  const PackagesScreen({super.key});

  @override
  State<PackagesScreen> createState() => _PackagesScreenState();
}

class _PackagesScreenState extends State<PackagesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        mobileScaffold: PackagesScreenMobile(),
        tabletScaffold: PackagesScreenTablet(),
        desktopScaffold: PackagesScreenDesktop(),
      ),
    );
  }
}
