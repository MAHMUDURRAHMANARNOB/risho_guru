import 'package:flutter/material.dart';

class StudyBoardMobile extends StatefulWidget {
  const StudyBoardMobile({super.key});

  @override
  State<StudyBoardMobile> createState() => _StudyBoardMobileState();
}

class _StudyBoardMobileState extends State<StudyBoardMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Study Board'),
        automaticallyImplyLeading: false,
      ),
      body: Text('Study Board Mobile'),
    );
  }
}
