import 'package:flutter/material.dart';

class PackagesScreenTablet extends StatefulWidget {
  const PackagesScreenTablet({super.key});

  @override
  State<PackagesScreenTablet> createState() => _PackagesScreenTabletState();
}

class _PackagesScreenTabletState extends State<PackagesScreenTablet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Packages'),
        automaticallyImplyLeading: false,
      ),
      body: Text('Packages Tablet'),
    );
  }
}
