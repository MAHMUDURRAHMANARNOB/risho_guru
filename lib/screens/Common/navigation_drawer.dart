import 'package:flutter/material.dart';
import 'package:risho_guru/ui/colors.dart';
import '../../animations.dart';
import '../../destinations.dart'; // Import your destinations list

class CustomNavigationDrawer extends StatelessWidget {
  const CustomNavigationDrawer({
    super.key,
    required this.selectedIndex,
    this.onDestinationSelected,
  });
  final int selectedIndex;
  final ValueChanged<int>? onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: destinations.map(
          (destination) {
            return ListTile(
              leading: Icon(destination.icon),
              title: Text(destination.label),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // You can add your navigation logic here based on the selected destination.
              },
            );
          },
        ).toList(),
      ),
    );
    /*  NavigationBar(
        elevation: 0,
        backgroundColor: AppColors.backgroundColorDark,
        destinations: destinations.map<NavigationDestination>((d) {
          return NavigationDestination(
            icon: Icon(d.icon),
            label: d.label,
          );
        }).toList(),
        selectedIndex: selectedIndex,
        onDestinationSelected: onDestinationSelected,
      ),
    );*/
  }
}
