import 'package:flutter/material.dart';

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
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5.0,
          child: Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/courses_back.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                const Text(
                  'Find your desired courses on',
                  style: TextStyle(fontSize: 24.0, color: Colors.white),
                ),
                const Text(
                  'RISHO.GURU',
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                ),
                const SizedBox(height: 20.0),
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Explore Courses',
                    hintStyle: TextStyle(color: Colors.grey),
                    /*icon: Icon(Icons.search),*/
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
