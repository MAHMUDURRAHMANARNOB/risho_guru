import 'package:flutter/material.dart';

class HomeWorkScreenMobile extends StatefulWidget {
  const HomeWorkScreenMobile({super.key});

  @override
  State<HomeWorkScreenMobile> createState() => _HomeWorkScreenMobileState();
}

class _HomeWorkScreenMobileState extends State<HomeWorkScreenMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeWork'),
        automaticallyImplyLeading: false,
      ),
      body: Text('HomeWork Mobile'),
    );
  }
}
