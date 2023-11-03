import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:risho_guru/screens/Common/login_form.dart';
import 'package:risho_guru/screens/registration_screen.dart';
import 'package:risho_guru/ui/colors.dart';

class LoginScreenMobile extends StatefulWidget {
  const LoginScreenMobile({super.key});

  @override
  State<LoginScreenMobile> createState() => _LoginScreenMobileState();
}

class _LoginScreenMobileState extends State<LoginScreenMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColorDark,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /*Expanded(
            child: Container(
              margin: EdgeInsets.all(16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image.asset(
                  'assets/images/login.png', // Replace with the path to your image
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),*/
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              margin: EdgeInsets.all(16.0),
              child: Loginform(),
            ),
          ),
        ],
      ),
    );
  }
}
