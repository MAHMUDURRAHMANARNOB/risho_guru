import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:risho_guru/providers/auth_provider.dart';
import 'package:risho_guru/providers/courses_provider.dart';
import 'package:risho_guru/providers/getLessonAnswer_Provider.dart';
import 'package:risho_guru/providers/getTaslation_provider.dart';
import 'package:risho_guru/providers/getToolsData_provider.dart';
import 'package:risho_guru/providers/subscriptionStatus_provider.dart';
import 'package:risho_guru/providers/toolsResponse_provider.dart';
import 'package:risho_guru/providers/tools_provider.dart';
import 'package:risho_guru/screens/courses_screen.dart';
import 'package:risho_guru/screens/dashboard.dart';
import 'package:risho_guru/screens/dashboard_screen.dart';
import 'package:risho_guru/screens/login_screen.dart';
import 'package:risho_guru/screens/packages_screen.dart';
import 'package:risho_guru/screens/registration_screen.dart';
import 'package:risho_guru/screens/splash_screen.dart';
import 'package:risho_guru/screens/study_section_screen.dart';
import 'package:risho_guru/screens/tools_screen.dart';
import 'package:risho_guru/screens/welcome_screen.dart';
import 'package:risho_guru/ui/colors.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => ToolsProvider(userId: 0)),
        ChangeNotifierProvider(
            create: (context) => SubscriptionStatusProvider(userId: 0)),
        ChangeNotifierProvider(create: (context) => CourseProvider()),
        ChangeNotifierProvider(
          create: (context) => LessonAnswerProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TranslationProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ToolsDataProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ToolsResponseProvider(),
        ),
      ],
      child: RishoGuru(),
    ),
  );
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
          Dashboard.id: (context) => Dashboard(),
          CoursesScreen.id: (context) => CoursesScreen(),
          StudySectionScreen.id: (context) => StudySectionScreen(),
          PackagesScreen.id: (context) => PackagesScreen(),
          ToolsScreen.id: (context) => ToolsScreen(),
          DashboardScreen.id: (context) => DashboardScreen(),
        });
  }
}
