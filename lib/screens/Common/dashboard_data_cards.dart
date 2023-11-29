import 'package:flutter/material.dart';

import '../../ui/colors.dart';

class DashboardDataCards extends StatelessWidget {
  const DashboardDataCards(
      {Key? key,
      required this.cardTitle,
      required this.cardCountNo,
      required this.imageUrl})
      : super(key: key);

  final String cardTitle;
  final String cardCountNo;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(8.0),
      ),
      height: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imageUrl,
            height: 50,
            width: 50,
          ),
          Text(
            cardTitle,
            style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(6.0)),
            child: Text(
              cardCountNo,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
