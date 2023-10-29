import 'package:flutter/material.dart';
import 'package:risho_guru/screens/calendar_screen.dart';
import 'package:risho_guru/screens/courses_screen.dart';
import 'package:risho_guru/screens/login_screen.dart';
import 'package:risho_guru/screens/packages_screen.dart';
import 'package:risho_guru/screens/registration_screen.dart';
import 'package:risho_guru/screens/splash_screen.dart';
import 'package:risho_guru/screens/study_section_screen.dart';
import 'package:risho_guru/screens/tools_screen.dart';
import 'package:risho_guru/screens/welcome_screen.dart';
import 'package:risho_guru/ui/colors.dart';

void main() {
  runApp(RishoGuru());
}

class RishoGuru extends StatelessWidget {
  const RishoGuru({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          textTheme: TextTheme(
            bodyText2: TextStyle(
              fontFamily: 'Poppins', // Set the custom font as the default
              fontSize: 14,
            ),
            // You can define more text styles here as needed
          ),
        ),
        initialRoute: SplashScreen.id,
        routes: {
          SplashScreen.id: (context) => SplashScreen(),
          WelcomeScreen.id: (context) => WelcomeScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
          CoursesScreen.id: (context) => CoursesScreen(),
          StudySectionScreen.id: (context) => StudySectionScreen(),
          PackagesScreen.id: (context) => PackagesScreen(),
          CalendarScreen.id: (context) => CalendarScreen(),
          ToolsScreen.id: (context) => ToolsScreen(),
        });
  }
}
