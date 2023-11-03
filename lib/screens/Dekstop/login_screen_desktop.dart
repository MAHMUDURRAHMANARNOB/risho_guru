import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:risho_guru/screens/registration_screen.dart';
import 'package:risho_guru/ui/colors.dart';
import 'package:risho_guru/screens/Common/login_form.dart';

class LoginScreenDesktop extends StatefulWidget {
  const LoginScreenDesktop({super.key});

  @override
  State<LoginScreenDesktop> createState() => _LoginScreenDesktopState();
}

class _LoginScreenDesktopState extends State<LoginScreenDesktop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColorDark,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.all(16.0),
              padding: EdgeInsets.all(1.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: AppColors.secondaryColor,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image.asset(
                  'assets/images/login.png', // Replace with the path to your image
                  fit: BoxFit.cover,
                ),
              ),
              /*decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white, // Border color
                  width: 2.0, // Border width
                ),
              ),*/
            ),
          ),
          Expanded(
            child: Container(
                padding: const EdgeInsets.all(20.0),
                margin: EdgeInsets.all(16.0),
                child: Loginform()),
          ),
        ],
      ),
    );
  }
}
