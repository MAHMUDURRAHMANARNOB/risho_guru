import 'package:flutter/material.dart';

class ToolsScreenMobile extends StatefulWidget {
  const ToolsScreenMobile({super.key});

  @override
  State<ToolsScreenMobile> createState() => _ToolsScreenMobileState();
}

class _ToolsScreenMobileState extends State<ToolsScreenMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tools'),
        automaticallyImplyLeading: false,
      ),
      body: Text('Tools Mobile'),
    );
  }
}
