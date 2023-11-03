import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:risho_guru/screens/registration_screen.dart';
import 'package:risho_guru/ui/colors.dart';

import '../Common/registration_form.dart';

class RegistrationScreenTablet extends StatefulWidget {
  const RegistrationScreenTablet({super.key});

  @override
  State<RegistrationScreenTablet> createState() =>
      _RegistrationScreenTabletState();
}

class _RegistrationScreenTabletState extends State<RegistrationScreenTablet> {
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
          Expanded(
            child: Container(
              margin: EdgeInsets.all(16.0),
              padding: EdgeInsets.all(1.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: AppColors.primaryColor,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image.asset(
                  'assets/images/registration.jpg', // Replace with the path to your image
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
