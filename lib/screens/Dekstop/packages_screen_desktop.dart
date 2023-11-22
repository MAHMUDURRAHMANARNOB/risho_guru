import 'package:flutter/material.dart';

class PackagesScreenDesktop extends StatefulWidget {
  const PackagesScreenDesktop({super.key});

  @override
  State<PackagesScreenDesktop> createState() => _PackagesScreenDesktopState();
}

class _PackagesScreenDesktopState extends State<PackagesScreenDesktop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Packages'),
        automaticallyImplyLeading: false,
      ),
      body: Text('Packages Desktop'),
    );
  }
}
