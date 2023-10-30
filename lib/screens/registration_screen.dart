import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:risho_guru/responsive/responsive_layout.dart';
import 'package:risho_guru/screens/Dekstop/registration_Screen_Desktop.dart';
import 'package:risho_guru/screens/Mobile/registration_screen_mobile.dart';
import 'package:risho_guru/screens/login_screen.dart';

import '../ui/colors.dart';
import 'Tablet/registration_screen_tablet.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = "registration_screen";
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        mobileScaffold: RegistrationScreenMobile(),
        tabletScaffold: RegistrationScreenTablet(),
        desktopScaffold: RegistrationScreenDesktop(),
      ),
    );
  }
}
