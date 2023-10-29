import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:risho_guru/ui/colors.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = "welcome_screen";

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
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
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              margin: EdgeInsets.all(16.0),
              child: LoginForm(),
            ),
          ),
        ],
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _obscureText = true;
  // Initially hide the password
  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome",
              style: TextStyle(
                fontSize: 80,
                fontFamily: 'Smooch',
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "We are glad to see you back with us",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                color: Colors.black,
              ),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.person_2_outlined,
                  color: Colors.grey[900], // Change the color of the icon
                ),
                /*labelText: 'Email',
                labelStyle: TextStyle(color: Colors.blueGrey[900]),*/
                hintStyle: TextStyle(
                  color: Colors.grey[400],
                ),
                hintText: 'Username',
                filled: true,
                fillColor: Colors.grey[200], // Background color
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0), // Border radius
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.blue), // Border color when focused
                  borderRadius:
                      BorderRadius.circular(8.0), // Border radius when focused
                ),
              ),
            ),
            const SizedBox(height: 20), // Add vertical space
            TextField(
              keyboardType: TextInputType.visiblePassword,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.lock_outline_rounded,
                  color: Colors.grey[900], // Change the color of the icon
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey[600],
                  ),
                  onPressed: _togglePasswordVisibility,
                ),
                /*labelText: 'Password',
                labelStyle: TextStyle(color: Colors.grey[400]),*/
                hintStyle: TextStyle(color: Colors.grey[400]),
                hintText: 'Password',
                filled: true,
                fillColor: Colors.grey[200], // Background color
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0), // Border radius
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.blue), // Border color when focused
                  borderRadius:
                      BorderRadius.circular(10.0), // Border radius when focused
                ),
              ),
              obscureText: _obscureText,
            ),
            const SizedBox(height: 20), // Add vertical space
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    AppColors.primaryColor, // Change the background color
              ),
              onPressed: () {},
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(10.0),
                alignment: Alignment.center,
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20), // Add vertical space
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    height: 1.0,
                    width: 60.0,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Login',
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  ' with Others',
                  style: TextStyle(fontSize: 14.0),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    height: 1.0,
                    width: 60.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20), // Add vertical space
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(8.0), // Add rounded corners
                  side: BorderSide(
                    color: Colors.white, // Specify the border color
                    width: 1.0, // Specify the border width
                  ),
                ), // Change the background color
              ),
              onPressed: () {},
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(10.0),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.google, // Google icon from Font Awesome
                      color:
                          Colors.white, // Change the color of the Google logo
                    ),
                    SizedBox(width: 8.0), // Add space between the logo and text
                    Text(
                      'Login with Google',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20), // Add vertical space
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(8.0), // Add rounded corners
                  side: BorderSide(
                    color: Colors.white, // Specify the border color
                    width: 1.0, // Specify the border width
                  ),
                ), // Change the background color
              ),
              onPressed: () {},
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(10.0),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      FontAwesomeIcons
                          .facebookF, // Facebook icon from Font Awesome
                      color:
                          Colors.white, // Change the color of the Google logo
                    ),
                    SizedBox(width: 8.0), // Add space between the logo and text
                    Text(
                      'Login with Facebook',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
