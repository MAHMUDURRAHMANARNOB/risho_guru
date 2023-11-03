import 'package:flutter/material.dart';
import 'package:risho_guru/screens/Dekstop/study_board_desktop.dart';
import 'package:risho_guru/screens/Mobile/study_board_mobile.dart';
import 'package:risho_guru/screens/Tablet/study_board_tablet.dart';

import '../responsive/responsive_layout.dart';

class StudySectionScreen extends StatefulWidget {
  static const String id = "study_section_screen";
  const StudySectionScreen({super.key});

  @override
  State<StudySectionScreen> createState() => _StudySectionScreenState();
}

class _StudySectionScreenState extends State<StudySectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        mobileScaffold: StudyBoardMobile(),
        tabletScaffold: StudyBoardTablet(),
        desktopScaffold: StudyBoardDesktop(),
      ),
    );
  }
}
