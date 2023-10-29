import 'package:flutter/material.dart';
import 'package:risho_guru/screens/login_screen.dart';
import 'package:risho_guru/screens/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String id = "splash_screen";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate some initialization tasks (e.g., data loading) here.
    // After completing the tasks, navigate to the next screen.

    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/risho_guru.png', // Replace with the path to your logo image
              width: 400.0, // Set the desired width
              height: 200.0,
            ), // Replace with your app's logo
            SizedBox(height: 20.0),
            Text(
              'Risho Guru',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
