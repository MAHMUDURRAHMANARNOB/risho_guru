import 'package:flutter/material.dart';

class CoursesScreenMobile extends StatefulWidget {
  const CoursesScreenMobile({super.key});

  @override
  State<CoursesScreenMobile> createState() => _CoursesScreenMobileState();
}

class _CoursesScreenMobileState extends State<CoursesScreenMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Courses'),
      ),
      body: Text('Courses Mobile'),
    );
  }
}
