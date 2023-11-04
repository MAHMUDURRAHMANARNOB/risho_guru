import 'package:flutter/material.dart';
import 'package:risho_guru/screens/Dekstop/tools_screen_desktop.dart';
import 'package:risho_guru/screens/Mobile/tools_screen_mobile.dart';
import 'package:risho_guru/screens/Tablet/tools_screen_tablet.dart';

import '../responsive/responsive_layout.dart';

class ToolsScreen extends StatefulWidget {
  static const String id = "tools_screen";
  const ToolsScreen({super.key});

  @override
  State<ToolsScreen> createState() => _ToolsScreenState();
}

class _ToolsScreenState extends State<ToolsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        mobileScaffold: ToolsScreenMobile(),
        tabletScaffold: ToolsScreenTablet(),
        desktopScaffold: ToolsScreenDesktop(),
      ),
    );
  }
}
