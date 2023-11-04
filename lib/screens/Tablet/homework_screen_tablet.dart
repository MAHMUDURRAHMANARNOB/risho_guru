import 'package:flutter/material.dart';

class HomeWorkScreenTablet extends StatefulWidget {
  const HomeWorkScreenTablet({super.key});

  @override
  State<HomeWorkScreenTablet> createState() => _HomeWorkScreenTabletState();
}

class _HomeWorkScreenTabletState extends State<HomeWorkScreenTablet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeWork'),
      ),
      body: Text('HomeWork Tablet'),
    );
  }
}
