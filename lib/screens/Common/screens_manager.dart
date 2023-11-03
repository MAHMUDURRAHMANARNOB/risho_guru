import 'package:flutter/material.dart';

import '../../destinations.dart';

class CustomScreensManager extends StatefulWidget {
  final List<Widget> screens;
  final Function(int) onScreenChange;

  CustomScreensManager({required this.screens, required this.onScreenChange});

  @override
  _ScreensManagerState createState() => _ScreensManagerState();
}

class _ScreensManagerState extends State<CustomScreensManager> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: widget.screens,
        controller: PageController(
          initialPage: _currentIndex,
          keepPage: true,
        ),
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
          widget.onScreenChange(index);
        },
      ),
      /*bottomNavigationBar: BottomNavigationBar(
        items: destinations.map((destination) {
          return BottomNavigationBarItem(
            icon: Icon(destination.icon),
            label: destination.label,
          );
        }).toList(),
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),*/
    );
  }
}
