import 'package:flutter/material.dart';

class CalendarScreenDesktop extends StatefulWidget {
  const CalendarScreenDesktop({super.key});

  @override
  State<CalendarScreenDesktop> createState() => _CalendarScreenDesktopState();
}

class _CalendarScreenDesktopState extends State<CalendarScreenDesktop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: Text('Calendar'),
      ),*/
      body: Text('Calendar DESKTOP'),
    );
  }
}
