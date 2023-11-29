import 'package:flutter/material.dart';

import '../../ui/colors.dart';

class DashboardCardButtons extends StatelessWidget {
  const DashboardCardButtons({
    Key? key,
    required this.cardTitle,
  }) : super(key: key);

  final String cardTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      height: 50,
      width: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            cardTitle,
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
