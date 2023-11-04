import 'package:flutter/material.dart';

class ToolsScreenTablet extends StatefulWidget {
  const ToolsScreenTablet({super.key});

  @override
  State<ToolsScreenTablet> createState() => _ToolsScreenTabletState();
}

class _ToolsScreenTabletState extends State<ToolsScreenTablet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tools'),
      ),
      body: Text('Tools Tablet'),
    );
  }
}
