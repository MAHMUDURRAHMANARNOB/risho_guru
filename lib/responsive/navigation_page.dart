import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:adaptive_navigation/adaptive_navigation.dart';
import 'package:risho_guru/screens/courses_screen.dart';
import 'package:risho_guru/screens/dashboard_screen.dart';
import 'package:risho_guru/screens/packages_screen.dart';
import 'package:risho_guru/screens/study_section_screen.dart';
import 'package:risho_guru/screens/tools_screen.dart';
import 'package:risho_guru/ui/colors.dart';
import '../destinations.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _selectedIndex = 0;

  bool extended = false;

  changeIndex(int index) {
    _selectedIndex = index;
    setState(() {
      extended = !extended;
    });
  }

  /*final destinations = <AdaptiveScaffoldDestination>[
    AdaptiveScaffoldDestination(
      title: 'Dashboard',
      icon: CustomIcon(
        imagePath:
            'assets/images/risho_guru_icon.png', // Replace with your actual logo asset path
      ).iconData,
    ),
    AdaptiveScaffoldDestination(
        title: 'Courses', icon: Icons.cast_for_education_outlined),
    AdaptiveScaffoldDestination(title: 'StudyBoard', icon: Icons.book_outlined),
    AdaptiveScaffoldDestination(title: 'Tools', icon: Icons.handyman),
    AdaptiveScaffoldDestination(
        title: 'Packages', icon: Icons.inventory_2_outlined),
  ];*/
  final List<CustomDestination> destinations = [
    CustomDestination(
        title: 'Dashboard', imagePath: 'assets/images/risho_guru_icon.png'),
    CustomDestination(
        title: 'Courses', imagePath: 'assets/images/course_icon.png'),
    CustomDestination(
        title: 'StudyBoard', imagePath: 'assets/images/study_board.png'),
    CustomDestination(
        title: 'Tools', imagePath: 'assets/images/tools_icon.png'),
    CustomDestination(
        title: 'Packages', imagePath: 'assets/images/packages_icon.png'),
  ];

  bool showLabels() {
    // You can adjust the threshold value based on your design requirements.
    return MediaQuery.of(context).size.width >
        600; // Example threshold: 600 pixels
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          /*GestureDetector(
            onTap: () {
              setState(() {
                extended = !extended;
              });
            },
            child:*/
          NavigationRail(
            groupAlignment: -1,
            extended: extended,
            selectedIndex: _selectedIndex,
            labelType: showLabels()
                ? NavigationRailLabelType.none
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
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _selectedIndex == index
                            ? Colors.white
                            : AppColors
                                .backgroundColorDark, // Customize the background color
                      ),
                      child: Image.asset(
                        destination.imagePath,
                        width: 30,
                        height: 40,
                      ),
                    ),
                  ),
                  label: /*showLabels()
                      ? */
                      Text(
                    destination.title,
                    style: TextStyle(
                      color: _selectedIndex == index
                          ? AppColors.secondaryColor // Active label color
                          : Colors.white, // Inactive label color
                    ),
                  )
                  /*: Container(),*/
                  );
            }).toList(),
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
          /*),*/
          // Add your content here
          Expanded(
            child: Center(
              child: Container(
                child: _getSelectedScreen(_selectedIndex),
              ),
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
        return DashboardScreen();
        /*Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => CoursesScreen()));*/
        break;
      case 1:
        return CoursesScreen();
        /*Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => CoursesScreen()));*/
        break;
      case 2:
        return StudySectionScreen();
        /*Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => StudySectionScreen()));*/
        break;
      case 3:
        return ToolsScreen();
        /*Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => StudySectionScreen()));*/
        break;
      case 4:
        return PackagesScreen();
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

class CustomDestination {
  final String title;
  final String imagePath;

  CustomDestination({required this.title, required this.imagePath});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is CustomDestination &&
        other.title == title &&
        other.imagePath == imagePath;
  }

  @override
  int get hashCode => title.hashCode ^ imagePath.hashCode;
}

class CustomIcon extends StatelessWidget {
  final String imagePath;

  CustomIcon({super.key, required this.imagePath});

  IconData get iconData => Icons.dashboard_customize_rounded;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      width: 24,
      height: 24,
    );
  }
}
