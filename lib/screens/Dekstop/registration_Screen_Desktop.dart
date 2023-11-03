import 'package:flutter/material.dart';
import 'package:risho_guru/ui/colors.dart';

import '../Common/registration_form.dart';

class RegistrationScreenDesktop extends StatefulWidget {
  const RegistrationScreenDesktop({super.key});

  @override
  State<RegistrationScreenDesktop> createState() =>
      _RegistrationScreenDesktopState();
}

class _RegistrationScreenDesktopState extends State<RegistrationScreenDesktop> {
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
