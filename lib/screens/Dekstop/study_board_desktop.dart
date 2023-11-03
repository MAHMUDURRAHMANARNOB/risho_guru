import 'package:flutter/material.dart';

class StudyBoardDesktop extends StatefulWidget {
  const StudyBoardDesktop({super.key});

  @override
  State<StudyBoardDesktop> createState() => _StudyBoardDesktopState();
}

class _StudyBoardDesktopState extends State<StudyBoardDesktop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: Text('Courses'),
      ),*/
      body: Text('Study Board Desktop'),
    );
  }
}
