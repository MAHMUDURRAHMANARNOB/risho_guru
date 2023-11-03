import 'package:flutter/material.dart';

class StudyBoardTablet extends StatefulWidget {
  const StudyBoardTablet({super.key});

  @override
  State<StudyBoardTablet> createState() => _StudyBoardTabletState();
}

class _StudyBoardTabletState extends State<StudyBoardTablet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('StudyBoard'),
      ),
      body: Text('StudyBoard Tablet'),
    );
  }
}
