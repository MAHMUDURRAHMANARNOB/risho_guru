import 'package:flutter/material.dart';

class CoursesScreenDesktop extends StatefulWidget {
  const CoursesScreenDesktop({super.key});

  @override
  State<CoursesScreenDesktop> createState() => _CoursesScreenDesktopState();
}

class _CoursesScreenDesktopState extends State<CoursesScreenDesktop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: Text('Courses'),
      ),*/
      body: Text('Courses Desktop'),
    );
  }
}
