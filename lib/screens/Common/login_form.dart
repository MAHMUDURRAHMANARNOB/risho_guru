import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:risho_guru/screens/courses_screen.dart';
import 'package:risho_guru/screens/dashboard.dart';

import '../../models/user.dart';
import '../../providers/auth_provider.dart';
import '../../ui/colors.dart';
import '../registration_screen.dart';
import 'error_dialog.dart';

class Loginform extends StatefulWidget {
  Loginform({super.key});

  @override
  State<Loginform> createState() => _LoginformState();
}

class _LoginformState extends State<Loginform> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;
  // Initially hide the password
  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColorDark,
      body: Center(
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
              /*EMAIL INPUT BOX*/
              Container(
                width: 400,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Username / Email",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextField(
                      controller: usernameController,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: AppColors.primaryColor,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.person_2_outlined,
                          color:
                              Colors.grey[900], // Change the color of the icon
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                        ),
                        hintText: 'Your Username or Email',
                        filled: true,
                        fillColor: Colors.grey[200], // Background color
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(10.0), // Border radius
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors
                                  .primaryColor), // Border color when focused
                          borderRadius: BorderRadius.circular(
                              8.0), // Border radius when focused
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20), // Add vertical space
              Container(
                width: 400,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Password",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextField(
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      style: TextStyle(color: Colors.black),
                      cursorColor: AppColors.primaryColor,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock_outline_rounded,
                          color:
                              Colors.grey[900], // Change the color of the icon
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey[600],
                          ),
                          onPressed: _togglePasswordVisibility,
                        ),
                        /*labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.grey[400]),*/
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        hintText: 'Your Password',
                        filled: true,
                        fillColor: Colors.grey[200], // Background color
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(8.0), // Border radius
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors
                                  .primaryColor), // Border color when focused
                          borderRadius: BorderRadius.circular(
                              10.0), // Border radius when focused
                        ),
                      ),
                      obscureText: _obscureText,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20), // Add vertical space
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      AppColors.primaryColor, // Change the background color
                ),
                onPressed: () async {
                  try {
                    // Call the login method from the AuthProvider
                    await Provider.of<AuthProvider>(context, listen: false)
                        .login(
                            usernameController.text, passwordController.text);

                    // Check if the user is authenticated
                    if (Provider.of<AuthProvider>(context, listen: false)
                            .user !=
                        null) {
                      User user =
                          Provider.of<AuthProvider>(context, listen: false)
                              .user!;
                      print("User ID: ${user.userID}");
                      print("Username: ${user.username}");

                      // Navigate to the DashboardScreen on successful login
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Dashboard(),
                        ),
                      );
                    } else {
                      // Handle unsuccessful login
                      print("Login failed");
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ErrorDialog(
                              message:
                                  "Login failed, \ncheck username and password.");
                        },
                      );
                    }
                  } catch (error) {
                    // Handle errors from the API call or login process
                    print("Error during login: $error");
                    // Show the custom error dialog
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ErrorDialog(message: error.toString());
                      },
                    );
                  }
                },
                child: Container(
                  width: 350,
                  padding: EdgeInsets.all(10.0),
                  alignment: Alignment.center,
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20), // Add vertical space
              Container(
                constraints: BoxConstraints(
                  minWidth: 100.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        height: 1.0,
                        width: 30.0,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Login',
                      style: TextStyle(
                          fontSize: 14.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      ' with Others',
                      style: TextStyle(fontSize: 14.0),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        height: 1.0,
                        width: 30.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
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
                  width: 350,
                  padding: EdgeInsets.all(10.0),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FaIcon(
                        FontAwesomeIcons
                            .google, // Google icon from Font Awesome
                        color:
                            Colors.white, // Change the color of the Google logo
                      ),
                      SizedBox(
                          width: 8.0), // Add space between the logo and text
                      Text(
                        'Login with Google',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account? ',
                      style: TextStyle(fontSize: 14.0),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegistrationScreen(),
                          ),
                        );
                      },
                      child: Text('Sign-up'),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
