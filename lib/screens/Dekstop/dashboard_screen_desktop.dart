import 'package:flutter/material.dart';
import 'package:risho_guru/screens/Common/dashboard_card_buttons.dart';
import 'package:risho_guru/ui/colors.dart';

import '../Common/dashboard_data_cards.dart';

class DashboardScreenDesktop extends StatefulWidget {
  const DashboardScreenDesktop({super.key});

  @override
  State<DashboardScreenDesktop> createState() => _DashboardScreenDesktopState();
}

class _DashboardScreenDesktopState extends State<DashboardScreenDesktop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: AppColors.backgroundColorDark,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Text(
                        "Welcome",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "User",
                        style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: DashboardDataCards(
                        cardTitle: "Ongoing courses",
                        cardCountNo: "35",
                        imageUrl: 'assets/images/ongoing_courses.png',
                      ),
                    ),
                    Expanded(
                      child: DashboardDataCards(
                        cardTitle: "Exams Attended",
                        cardCountNo: "8",
                        imageUrl: 'assets/images/exam_attended.png',
                      ),
                    ),
                    Expanded(
                      child: DashboardDataCards(
                        cardTitle: "Earned Points",
                        cardCountNo: "15",
                        imageUrl: 'assets/images/earned_points.png',
                      ),
                    ),
                    Expanded(
                      child: DashboardDataCards(
                        cardTitle: "Remaining Tickets",
                        cardCountNo: "132",
                        imageUrl: 'assets/images/tickets.png',
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    // Left part
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(10.0),
                        padding: EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Text(
                                "Last Studied: ",
                                style: TextStyle(color: AppColors.primaryColor),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text("19 Nov, 2023"),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Right part
                    Expanded(
                      child: DashboardDataCards(
                        cardTitle: "Remaining Comments",
                        cardCountNo: "132",
                        imageUrl: 'assets/images/comments.png',
                      ),
                    ),
                    Container(
                      width: 200,
                      margin: EdgeInsets.all(10.0),
                      padding: EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Active Packages",
                            style: TextStyle(
                              color: AppColors.secondaryColor,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Premium",
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Expatriation Date",
                            style: TextStyle(
                              color: AppColors.backgroundColorDark,
                            ),
                          ),
                          Text(
                            "01 Dec, 2023",
                            style: TextStyle(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(10.0),
                  child: Text(
                    "Ticket History",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DashboardCardButtons(
                      cardTitle: "Today",
                    ),
                    DashboardCardButtons(
                      cardTitle: "Last 7 days",
                    ),
                    DashboardCardButtons(
                      cardTitle: "See All",
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
