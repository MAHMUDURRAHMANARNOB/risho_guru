import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:risho_guru/responsive/responsive_layout.dart';
import 'package:risho_guru/screens/registration_screen.dart';
import 'package:risho_guru/ui/colors.dart';

import 'Dekstop/login_screen_desktop.dart';
import 'Dekstop/registration_Screen_Desktop.dart';
import 'Mobile/login_screen_mobile.dart';
import 'Tablet/login_screen_tablet.dart';

class LoginScreen extends StatefulWidget {
  static const String id = "login_screen";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        mobileScaffold: LoginScreenMobile(),
        tabletScaffold: LoginScreenTablet(),
        desktopScaffold: LoginScreenDesktop(),
      ),
    );
  }
}
