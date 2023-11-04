import 'package:flutter/material.dart';

class PackagesScreenMobile extends StatefulWidget {
  const PackagesScreenMobile({super.key});

  @override
  State<PackagesScreenMobile> createState() => _PackagesScreenMobileState();
}

class _PackagesScreenMobileState extends State<PackagesScreenMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Packages'),
        automaticallyImplyLeading: false,
      ),
      body: Text('Packages Mobile'),
    );
  }
}
