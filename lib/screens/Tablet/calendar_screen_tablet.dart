import 'package:flutter/material.dart';

class CalendarScreenTablet extends StatefulWidget {
  const CalendarScreenTablet({super.key});

  @override
  State<CalendarScreenTablet> createState() => _CalendarScreenTabletState();
}

class _CalendarScreenTabletState extends State<CalendarScreenTablet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
        automaticallyImplyLeading: false,
      ),
      body: Text('Calendar Tablet'),
    );
  }
}
