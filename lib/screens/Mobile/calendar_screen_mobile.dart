import 'package:flutter/material.dart';

class CalendarScreenMobile extends StatefulWidget {
  const CalendarScreenMobile({super.key});

  @override
  State<CalendarScreenMobile> createState() => _CalendarScreenMobileState();
}

class _CalendarScreenMobileState extends State<CalendarScreenMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
        automaticallyImplyLeading: false,
      ),
      body: Text('Calendar Mobile'),
    );
  }
}
