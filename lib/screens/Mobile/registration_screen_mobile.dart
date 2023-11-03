import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:risho_guru/screens/registration_screen.dart';
import 'package:risho_guru/ui/colors.dart';

import '../Common/registration_form.dart';

class RegistrationScreenMobile extends StatefulWidget {
  const RegistrationScreenMobile({super.key});

  @override
  State<RegistrationScreenMobile> createState() =>
      _RegistrationScreenMobileState();
}

class _RegistrationScreenMobileState extends State<RegistrationScreenMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColorDark,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              margin: EdgeInsets.all(16.0),
              child: RegistrationForm(),
            ),
          ),
          /*Expanded(
            child: Container(
              margin: EdgeInsets.all(16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image.asset(
                  'assets/images/registration.jpg', // Replace with the path to your image
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),*/
        ],
      ),
    );
  }
}
