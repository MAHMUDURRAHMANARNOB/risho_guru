import 'package:custom_button_builder/custom_button_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../providers/tools_provider.dart';
import '../../ui/colors.dart';

class ToolsScreenDesktop extends StatefulWidget {
  const ToolsScreenDesktop({super.key});

  @override
  State<ToolsScreenDesktop> createState() => _ToolsScreenDesktopState();
}

List<String> _lessonContents = [];
List<Widget> _lessonComponents = [];

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class _ToolsScreenDesktopState extends State<ToolsScreenDesktop> {
  bool isSelected = false;
  String dropdownValue = list.first;

  ElevatedButton buildToolButton(String toolName) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
      ),
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("$toolName Selected"),
            duration: Duration(seconds: 1),
          ),
        );
      },
      child: Text(toolName),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final toolsProvider = ToolsProvider(userId: authProvider.user?.id ?? 0);
    print(toolsProvider.userId);
    if (authProvider.user != null) {
      toolsProvider.userId = authProvider.user!.id;
      print('Setting userId for ToolsProvider: ${toolsProvider.userId}');
    }
    String _className = 'Select';
    String _subject = 'Select';
    String _maxWord = '';
    String _question = '';
    String _answer = '';

    return Scaffold(
      appBar: AppBar(
        title: Text('Tools'),
        automaticallyImplyLeading: false,
      ),
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              height: double.infinity,
              color: AppColors.backgroundColorDark,
              child: FutureBuilder(
                future:
                    toolsProvider.fetchTools(), // Call the fetchTools method
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    // Display your list of tools
                    return SingleChildScrollView(
                      child: Column(
                        children: toolsProvider.tools.map((tool) {
                          return Container(
                            width: double.infinity,
                            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                            height: 50,
                            child: buildToolButton(tool.toolName),
                          );
                        }).toList(),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: Container(
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.grey[800],
                      child: ListView.builder(
                        itemCount: _lessonComponents.length,
                        itemBuilder: (BuildContext context, int index) {
                          // Replace this with your actual component widget based on your data
                          return Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 15.0),
                            padding: const EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                              color: AppColors.backgroundColorDark,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: _lessonComponents[index],
                          );
                        },
                      ),
                    ),
                  ),
                  /*BOTTOM CONTROL*/
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundColorDark,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.backgroundColorDark,
                          ),
                          child: Icon(
                            Icons.add_circle_outline,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            maxLines: 3,
                            minLines: 1,
                            cursorColor: AppColors.primaryColor,
                            decoration: InputDecoration(
                              hintText: 'Type your message...',
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                            onChanged: (value) {},
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      AppColors.backgroundColorDark,
                                ),
                                child: Icon(
                                  Icons.image_rounded,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      AppColors.backgroundColorDark,
                                ),
                                child: Icon(
                                  Icons.keyboard_rounded,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      AppColors.backgroundColorDark,
                                ),
                                child: Icon(
                                  Icons.send_rounded,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final ButtonStyle flatButtonStyle = TextButton.styleFrom(
  backgroundColor: AppColors.primaryColor,
  minimumSize: Size(88, 36),
  padding: EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2)),
  ),
);
