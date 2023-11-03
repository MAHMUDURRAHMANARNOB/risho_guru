import 'package:flutter/material.dart';

class CoursesScreenTablet extends StatefulWidget {
  const CoursesScreenTablet({super.key});

  @override
  State<CoursesScreenTablet> createState() => _CoursesScreenTabletState();
}

class _CoursesScreenTabletState extends State<CoursesScreenTablet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Courses'),
      ),
      body: Text('Courses Tablet'),
    );
  }
}
