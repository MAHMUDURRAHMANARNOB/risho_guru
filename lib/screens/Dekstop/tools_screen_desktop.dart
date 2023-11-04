import 'package:flutter/material.dart';

class ToolsScreenDesktop extends StatefulWidget {
  const ToolsScreenDesktop({super.key});

  @override
  State<ToolsScreenDesktop> createState() => _ToolsScreenDesktopState();
}

class _ToolsScreenDesktopState extends State<ToolsScreenDesktop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: Text('Tools'),
      ),*/
      body: Text('Tools Desktop'),
    );
  }
}
