import 'package:flutter/material.dart';
import 'package:custom_button_builder/custom_button_builder.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';

import '../../models/getToolsData_DataModel.dart';
import '../../providers/auth_provider.dart';
import '../../providers/getToolsData_provider.dart';
import '../../providers/toolsResponse_provider.dart';
import '../../providers/tools_provider.dart';
import '../../ui/colors.dart';

class ToolsScreenDesktop extends StatefulWidget {
  const ToolsScreenDesktop({super.key});

  @override
  State<ToolsScreenDesktop> createState() => _ToolsScreenDesktopState();
}

List<Widget> _lessonComponents = [];
List<Widget> _toolsComponents = [];

/*const List<String> list = <String>['One', 'Two', 'Three', 'Four'];*/

class _ToolsScreenDesktopState extends State<ToolsScreenDesktop> {
  String dropdownClassValue = "";
  String dropdownSubjectValue = "";
  TextEditingController questionTextFieldController = TextEditingController();
  late ToolsDataProvider toolsDataProvider;
  /*late ToolsResponseProvider toolsResponseProvider;*/

  bool isSelected = false;
  /*String dropdownValue = list.first;*/

  late String _selectedToolsCode;
  late String _selectedClassName = '';
  late String _selectedSubjectName = '';
  late String _question = '';

  ElevatedButton buildToolButton(
    String toolName,
    String toolsCode,
    int toolId, {
    required VoidCallback onToolSelected,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
      ),
      onPressed: () {
        onToolSelected();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                "$toolName Selected >> $toolsCode << and tools id >> $toolId"),
            duration: Duration(seconds: 1),
          ),
        );
      },
      child: Text(toolName),
    );
  }

  @override
  Widget build(BuildContext context) {
    final jobRoleCtrl = TextEditingController();
    final authProvider = Provider.of<AuthProvider>(context);
    final toolsProvider = ToolsProvider(userId: authProvider.user?.id ?? 0);
    int userID = toolsProvider.userId;
    print(userID);
    if (authProvider.user != null) {
      toolsProvider.userId = authProvider.user!.id;
      print('Setting userId for ToolsProvider: ${toolsProvider.userId}');
    }
    toolsDataProvider = Provider.of<ToolsDataProvider>(context, listen: false);

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
                            child: buildToolButton(
                              tool.toolName,
                              _selectedToolsCode = tool.toolsCode,
                              tool.toolID,
                              onToolSelected: () {
                                // Call the API when a tool is selected
                                toolsDataProvider.fetchToolsData(
                                  userID, // replace with the actual user ID
                                  tool.toolID,
                                );
                              },
                            ),
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
                  /*TOOLS Components*/
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
                  /*BOTTOM CONTROL 1*/

                  /*BOTTOM CONTROL 2*/
                  Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: AppColors.backgroundColorDark,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                        ),
                        child: Row(
                          children: [
                            /*SELCTED CLASS*/
                            Container(
                              padding: EdgeInsets.all(5),
                              child: Row(
                                children: [
                                  Text("Class "),
                                  DropdownMenu<String>(
                                    onSelected: (String? value) {
                                      // This is called when the user selects an item.
                                      setState(() {
                                        _selectedClassName = value!;
                                        print(
                                            "$_selectedClassName << Selectedclassname");
                                      });
                                    },
                                    dropdownMenuEntries: toolsDataProvider
                                            .toolsData?.classList
                                            .map<DropdownMenuEntry<String>>(
                                                (ClassInfo classInfo) {
                                          return DropdownMenuEntry<String>(
                                            value: classInfo.className,
                                            label: classInfo.className,
                                          );
                                        }).toList() ??
                                        [],
                                  ),
                                ],
                              ),
                            ),
                            /*SELECTED SUBJECT*/
                            Container(
                              padding: EdgeInsets.all(5),
                              child: Row(
                                children: [
                                  Text("Subject "),
                                  DropdownMenu<String>(
                                    onSelected: (String? value) {
                                      // This is called when the user selects an item.
                                      setState(() {
                                        _selectedSubjectName = value!;
                                        print(
                                            "$_selectedSubjectName << _selectedSubjectName");
                                      });
                                    },
                                    dropdownMenuEntries: toolsDataProvider
                                            .toolsData?.subjectList
                                            .map<DropdownMenuEntry<String>>(
                                                (Subject subject) {
                                          return DropdownMenuEntry<String>(
                                            value: subject.subjectName,
                                            label: subject.subjectName,
                                          );
                                        }).toList() ??
                                        [],
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(5),
                                child: TextField(
                                  maxLines: 3,
                                  minLines: 1,
                                  cursorColor: AppColors.primaryColor,
                                  decoration: const InputDecoration(
                                    hintText: 'Max lines..',
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
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.backgroundColorDark,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            /*ADD DOCUMENT*/
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
                                controller: questionTextFieldController,
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
                                onChanged: (value) {
                                  _question = value;
                                },
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  /*IMAGE PICKER*/
                                  Visibility(
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            AppColors.backgroundColorDark,
                                      ),
                                      child: const Icon(
                                        Icons.image_rounded,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                  ),
                                  /*MATH KEYBOARD*/
                                  Visibility(
                                    child: ElevatedButton(
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
                                  ),
                                  /*SEND*/
                                  Visibility(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          _lessonComponents.add(
                                            generateComponentGettingResponse(
                                                context,
                                                userID,
                                                _question,
                                                _selectedSubjectName,
                                                _selectedClassName,
                                                _selectedToolsCode),
                                          );
                                          // Clear the text in the TextField
                                          questionTextFieldController.clear();
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            AppColors.backgroundColorDark,
                                      ),
                                      child: Icon(
                                        Icons.send_rounded,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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

Widget generateComponentGettingResponse(
    BuildContext context,
    int userid,
    String question,
    String selectedSubject,
    String selectedClass,
    String selectedToolsCode) {
  bool _isPressed = false;
  final toolsResponseProvider =
      Provider.of<ToolsResponseProvider>(context, listen: false);
  return FutureBuilder<void>(
    future: toolsResponseProvider.fetchToolsResponse(
        userid, question, selectedSubject, selectedClass, selectedToolsCode),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const CircularProgressIndicator(); // Loading state
      } else if (snapshot.hasError) {
        return Text('ErrorSnapshotFutureBuilder: ${snapshot.error}');
      } else {
        /*final ansType =
        toolsResponseProvider.lessonModel?.lessonAnswer.ansType.toString();*/
        /*print(
            'Selected course: $courseId \n Selected lesson: $lessonId \n userid: $userid \n ANSTYPE: $ansType');*/

        // Your 'T' case code
        final lessonAnswer = toolsResponseProvider.toolsResponse;
        print(lessonAnswer!.answer.toString());
        final ansId = lessonAnswer.ticketId.toString();
        return Container(
          // Your 'T' case UI code
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /*Top Part*/
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "$selectedClass -- $selectedSubject \n $question",
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[700],
                            borderRadius: BorderRadius.circular(25),
                          ),
                          margin: EdgeInsets.all(2),
                          child: IconButton(
                            icon: Icon(
                              Icons.thumb_up_outlined,
                              color: AppColors.secondaryColor,
                              size: 14,
                            ),
                            onPressed: () {
                              /*setState(() {
                                _lessonComponents.add(
                                  generateTranslationforAnswer(ansId),
                                );
                              });*/
                            },
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[700],
                            borderRadius: BorderRadius.circular(25),
                          ),
                          margin: EdgeInsets.all(2),
                          child: IconButton(
                            icon: Icon(
                              Icons.volume_up_outlined,
                              color: AppColors.secondaryColor,
                              size: 16,
                            ),
                            onPressed: () {},
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[700],
                            borderRadius: BorderRadius.circular(25),
                          ),
                          margin: EdgeInsets.all(2),
                          child: IconButton(
                            icon: Icon(
                              Icons.question_answer_outlined,
                              color: AppColors.secondaryColor,
                              size: 14,
                            ),
                            onPressed: () {},
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.more_horiz,
                            color: AppColors.secondaryColor,
                          ),
                          onPressed: () {
                            // Implement your logic to show a popup menu here
                            // For example, use a PopupMenuButton
                            /*setState(() {
                              showPopupMenuPOP(
                                  context,
                                  const Offset(0, 40),
                                  context.findRenderObject() as RenderBox,
                                  courseIndex);
                            });*/
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.all(10.0),
                  height: 400,
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Markdown(
                    data: lessonAnswer.answer.toString(),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    },
  );
}

final ButtonStyle flatButtonStyle = TextButton.styleFrom(
  backgroundColor: AppColors.primaryColor,
  minimumSize: Size(88, 36),
  padding: EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2)),
  ),
);
