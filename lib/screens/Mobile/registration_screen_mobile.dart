import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:risho_guru/screens/registration_screen.dart';
import 'package:risho_guru/ui/colors.dart';

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

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
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
              "Sign Up",
              style: TextStyle(
                fontSize: 65,
                fontFamily: 'Smooch',
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "Lets get Started",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 20),
            /*EMAIL INPUT BOX*/
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Email",
                ),
                Container(
                  width: 400,
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: AppColors.primaryColor,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: Colors.grey[900], // Change the color of the icon
                      ),
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
                      ),
                      hintText: 'Your Email',
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
                            10.0), // Border radius when focused
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20), // Add vertical space
            /*Phone INPUT BOX*/
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Phone No",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Container(
                  width: 400,
                  child: TextField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^[0-9\+]{0,10}$')),
                    ],
                    keyboardType: TextInputType.phone,
                    cursorColor: AppColors.primaryColor,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.call_outlined,
                        color: Colors.grey[900], // Change the color of the icon
                      ),
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
                      ),
                      hintText: 'Your Phone No',
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
                ),
              ],
            ),
            const SizedBox(height: 20), // Add vertical space
            /*Password input box*/
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Password",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Container(
                  width: 400,
                  child: TextField(
                    keyboardType: TextInputType.visiblePassword,
                    style: TextStyle(color: Colors.black),
                    cursorColor: AppColors.primaryColor,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock_outline_rounded,
                        color: Colors.grey[900], // Change the color of the icon
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
                ),
              ],
            ),
            const SizedBox(height: 20), // Add vertical space
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    AppColors.primaryColor, // Change the background color
              ),
              onPressed: () {},
              child: Container(
                width: 350,
                padding: EdgeInsets.all(10.0),
                alignment: Alignment.center,
                child: Text(
                  'Next',
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
                  'Signup',
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
            /*Signup with google*/
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
                      FontAwesomeIcons.google, // Google icon from Font Awesome
                      color:
                          Colors.white, // Change the color of the Google logo
                    ),
                    SizedBox(width: 8.0), // Add space between the logo and text
                    Text(
                      'Signup with Google',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            /*const SizedBox(height: 20), // Add vertical space
            */ /*Signup with facebook*/ /*
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
                ),
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
                      FontAwesomeIcons.facebookF,
                      color: Colors.white,
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      'Signup with Facebook',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),*/
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an Account? ',
                  style: TextStyle(fontSize: 14.0),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                  ),
                  onPressed: () {
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );*/
                    // Navigate back when the button is pressed
                    Navigator.of(context).pop();
                  },
                  child: Text('Login'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
