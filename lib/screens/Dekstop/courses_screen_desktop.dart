import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:risho_guru/ui/colors.dart';

import '../Common/courses_card.dart';

class CoursesScreenDesktop extends StatefulWidget {
  const CoursesScreenDesktop({super.key});

  @override
  State<CoursesScreenDesktop> createState() => _CoursesScreenDesktopState();
}

class _CoursesScreenDesktopState extends State<CoursesScreenDesktop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Courses'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          /*HERO SECTION*/
          Container(
            height: 250,
            margin: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                  image: AssetImage('assets/images/courses_back.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5),
                    // Adjust the opacity level (0.3 means 30% opacity)
                    BlendMode.dstATop,
                  )),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Find your desired courses on',
                  style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                const Text(
                  'RISHO.GURU',
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20.0),
                Container(
                  margin: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                  child: TextField(
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Explore Courses',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          /*GRID LAYOUT*/
          Expanded(
            // Expand to fill the remaining space
            child: GridView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(10.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width > 600 ? 5 : 4,
                childAspectRatio: 0.75,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: 10,
              itemBuilder: (context, index) {
                return ProductCard(
                  imageUrl:
                      "https://images.unsplash.com/photo-1456513080510-7bf3a84b82f8?q=80&w=1973&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                  title: "Beginner",
                  heading: "Study Alone",
                  rating: 4.6,
                  onButtonPressed: () {
                    Fluttertoast.showToast(
                        msg: "This is Center Short Toast",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
