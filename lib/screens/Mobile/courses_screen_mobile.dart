import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../ui/colors.dart';

class CoursesScreenMobile extends StatefulWidget {
  const CoursesScreenMobile({super.key});

  @override
  State<CoursesScreenMobile> createState() => _CoursesScreenMobileState();
}

class _CoursesScreenMobileState extends State<CoursesScreenMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Courses'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            /*HERO SECTION*/
            Container(
              height: 180,
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
                        fontSize: 16.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'RISHO.GURU',
                    style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20.0),
                  Container(
                    margin: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                    child: TextField(
                      style: TextStyle(color: Colors.black, fontSize: 12),
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Explore Courses',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
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
                  crossAxisCount: 1,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: AppColors.backgroundColorDark,
                    ),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          ),
                          child: Image(
                            image: AssetImage("assets/images/math_class_7.png"),
                            width: double.infinity,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Class-01",
                                style: TextStyle(
                                    fontSize: 10.0, color: Colors.grey),
                              ),
                              Text(
                                "Elementary English",
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Wrap(
                                alignment: WrapAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "4.8",
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.grey,
                                        size: 12,
                                      ),
                                    ],
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            AppColors.primaryColor),
                                    onPressed: () {},
                                    child: Text("Enroll now"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
