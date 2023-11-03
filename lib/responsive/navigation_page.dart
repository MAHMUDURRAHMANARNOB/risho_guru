import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:adaptive_navigation/adaptive_navigation.dart';
import 'package:risho_guru/screens/courses_screen.dart';
import 'package:risho_guru/screens/study_section_screen.dart';
import 'package:risho_guru/ui/colors.dart';
import '../destinations.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _selectedIndex = 0;

  changeIndex(int index) {
    _selectedIndex = index;
    setState(() {});
  }

  final destinations = <AdaptiveScaffoldDestination>[
    AdaptiveScaffoldDestination(
        title: 'Courses', icon: Icons.cast_for_education_outlined),
    AdaptiveScaffoldDestination(title: 'StudyBoard', icon: Icons.book_outlined),
    AdaptiveScaffoldDestination(
        title: 'HomeWork', icon: Icons.home_work_outlined),
    AdaptiveScaffoldDestination(
        title: 'Calender', icon: Icons.calendar_month_outlined),
    AdaptiveScaffoldDestination(title: 'Tools', icon: Icons.handyman),
    AdaptiveScaffoldDestination(
        title: 'Packages', icon: Icons.inventory_2_outlined),
  ];

  bool showLabels() {
    // You can adjust the threshold value based on your design requirements.
    return MediaQuery.of(context).size.width >
        600; // Example threshold: 600 pixels
  }

  @override
  Widget build(BuildContext context) {
    return /*AdaptiveNavigationScaffold(
        body: Text('hello'),
        selectedIndex: _selectedIndex,
        destinations: destinations);*/
        Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedIndex,
            labelType: showLabels()
                ? NavigationRailLabelType.all
                : NavigationRailLabelType.none,
            destinations: destinations.asMap().entries.map((entry) {
              final index = entry.key;
              final destination = entry.value;
              return NavigationRailDestination(
                icon: GestureDetector(
                  onTap: () {
                    _navigateToScreen(index);
                  },
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors
                          .backgroundColorDark, // Customize the background color
                    ),
                    child: Icon(
                      destination.icon,
                      color: _selectedIndex == index
                          ? AppColors.secondaryColor
                          : Colors.white,
                    ),
                  ),
                ),
                label: showLabels()
                    ? Text(
                        destination.title,
                        style: TextStyle(
                          color: _selectedIndex == index
                              ? AppColors.secondaryColor // Active label color
                              : Colors.white, // Inactive label color
                        ),
                      )
                    : Container(),
              );
            }).toList(),
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
          // Add your content here
          Expanded(
            child: Center(
              child: _getSelectedScreen(_selectedIndex),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getSelectedScreen(int selectedIndex) {
    Widget screen;
    switch (selectedIndex) {
      case 0:
        return CoursesScreen();
        /*Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => CoursesScreen()));*/
        break;
      case 1:
        return StudySectionScreen();
        /*Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => StudySectionScreen()));*/
        break;
      default:
        return Text('Select a screen');
    }
  }

  void _navigateToScreen(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
