import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:risho_guru/screens/registration_screen.dart';
import 'package:risho_guru/screens/Common/login_form.dart';
import 'package:risho_guru/ui/colors.dart';

class LoginScreenTablet extends StatefulWidget {
  const LoginScreenTablet({super.key});

  @override
  State<LoginScreenTablet> createState() => _LoginScreenTabletState();
}

class _LoginScreenTabletState extends State<LoginScreenTablet> {
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
            ),
          ),
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
