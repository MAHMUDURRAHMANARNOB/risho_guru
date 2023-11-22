import 'package:custom_button_builder/custom_button_builder.dart';
import 'package:flutter/material.dart';

import '../../ui/colors.dart';

class ToolsScreenDesktop extends StatefulWidget {
  const ToolsScreenDesktop({super.key});

  @override
  State<ToolsScreenDesktop> createState() => _ToolsScreenDesktopState();
}

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class _ToolsScreenDesktopState extends State<ToolsScreenDesktop> {
  bool isSelected = false;
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    /*Math*/
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      height: 50,
                      child: ElevatedButton(
                        style: OutlinedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Math Selected"),
                              duration: Duration(seconds: 1),
                            ),
                          );
                          // Open Instagram app
                        },
                        child: const Text("Math"),
                      ),
                    ),
                    /*Unseen Question*/
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      height: 50,
                      child: ElevatedButton(
                        style: OutlinedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Unseen Question Selected"),
                              duration: Duration(seconds: 1),
                            ),
                          );
                          // Open Instagram app
                        },
                        child: const Text("Unseen Question"),
                      ),
                    ),
                    /*Fill in the blank (grammar)*/
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      height: 50,
                      child: ElevatedButton(
                        style: OutlinedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text("Fill in the blank (grammar) Selected"),
                              duration: Duration(seconds: 1),
                            ),
                          );
                          // Open Instagram app
                        },
                        child: const Text("Fill in the blank (grammar)"),
                      ),
                    ),
                    /*Comprehension selected*/
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      height: 50,
                      child: ElevatedButton(
                        style: OutlinedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Comprehension Selected"),
                              duration: Duration(seconds: 1),
                            ),
                          );
                          // Open Instagram app
                        },
                        child: const Text("Comprehension"),
                      ),
                    ),
                    /*Letter writing*/
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      height: 50,
                      child: ElevatedButton(
                        style: OutlinedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Letter writing Selected"),
                              duration: Duration(seconds: 1),
                            ),
                          );
                          // Open Instagram app
                        },
                        child: const Text("Letter writing"),
                      ),
                    ),
                    /*Essay writing*/
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      height: 50,
                      child: ElevatedButton(
                        style: OutlinedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Essay writing Selected"),
                              duration: Duration(seconds: 1),
                            ),
                          );
                          // Open Instagram app
                        },
                        child: const Text("Essay writing"),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      height: 50,
                      child: ElevatedButton(
                        style: OutlinedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text("Pressed Follow on Instagram button"),
                              duration: Duration(seconds: 1),
                            ),
                          );
                          // Open Instagram app
                        },
                        child: const Text("Paragraph Writing"),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      height: 50,
                      child: ElevatedButton(
                        style: OutlinedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text("Pressed Follow on Instagram button"),
                              duration: Duration(seconds: 1),
                            ),
                          );
                          // Open Instagram app
                        },
                        child: const Text("Answer Preparation"),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      height: 50,
                      child: ElevatedButton(
                        style: OutlinedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text("Pressed Follow on Instagram button"),
                              duration: Duration(seconds: 1),
                            ),
                          );
                          // Open Instagram app
                        },
                        child: const Text("Youtube note"),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      height: 50,
                      child: ElevatedButton(
                        style: OutlinedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text("Pressed Follow on Instagram button"),
                              duration: Duration(seconds: 1),
                            ),
                          );
                          // Open Instagram app
                        },
                        child: const Text("Text grammar check"),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      height: 50,
                      child: ElevatedButton(
                        style: OutlinedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text("Pressed Follow on Instagram button"),
                              duration: Duration(seconds: 1),
                            ),
                          );
                          // Open Instagram app
                        },
                        child: const Text("Custom Study"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: Container(
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  /*1st row*/
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      /*Class / Grade*/
                      Container(
                        child: Row(
                          children: [
                            Text("Class / Grade"),
                            SizedBox(
                              width: 10,
                            ),
                            DropdownMenu<String>(
                              initialSelection: list.first,
                              onSelected: (String? value) {
                                // This is called when the user selects an item.
                                setState(() {
                                  dropdownValue = value!;
                                });
                              },
                              dropdownMenuEntries: list
                                  .map<DropdownMenuEntry<String>>(
                                      (String value) {
                                return DropdownMenuEntry<String>(
                                    value: value, label: value);
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                      /*Subject*/
                      Container(
                        child: Row(
                          children: [
                            Text("Subject"),
                            SizedBox(
                              width: 5,
                            ),
                            DropdownMenu<String>(
                              initialSelection: list.first,
                              onSelected: (String? value) {
                                // This is called when the user selects an item.
                                setState(() {
                                  dropdownValue = value!;
                                });
                              },
                              dropdownMenuEntries: list
                                  .map<DropdownMenuEntry<String>>(
                                      (String value) {
                                return DropdownMenuEntry<String>(
                                    value: value, label: value);
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 500,
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Max Word',
                            hintText:
                                'Enter the maximum number of words allowed for the question',
                          ),
                          onChanged: (String value) {
                            setState(() {
                              _maxWord = value;
                            });
                          },
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  /*2nd Row*/
                  Row(
                    children: [
                      Expanded(
                        flex: 8,
                        child: TextField(
                          maxLines: 3,
                          minLines: 2,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Question',
                            hintText: 'Enter the question',
                          ),
                          onChanged: (String value) {
                            setState(() {
                              _question = value;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Container(
                              width: 120,
                              child: ElevatedButton(
                                style: OutlinedButton.styleFrom(
                                    backgroundColor: AppColors.primaryColor),
                                onPressed: () {},
                                child: Text("Keyboard"),
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Container(
                              width: 120,
                              child: ElevatedButton(
                                style: OutlinedButton.styleFrom(
                                    backgroundColor: AppColors.primaryColor),
                                onPressed: () {},
                                child: Text("Add Image"),
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Container(
                              width: 120,
                              child: ElevatedButton(
                                style: OutlinedButton.styleFrom(
                                    backgroundColor: AppColors.primaryColor),
                                onPressed: () {},
                                child: Text("Generate"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  /*3rd Row*/
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          maxLines: 15,
                          minLines: 10,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Answer Question',
                          ),
                          onChanged: (String value) {
                            setState(() {
                              _question = value;
                            });
                          },
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  /*4th Reo*/
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        width: 150,
                        child: ElevatedButton(
                          style: OutlinedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor),
                          onPressed: () {},
                          child: Text("Request Review"),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topRight,
                        child: Row(
                          children: [
                            Container(
                              width: 80,
                              child: ElevatedButton(
                                style: OutlinedButton.styleFrom(
                                    backgroundColor: AppColors.primaryColor),
                                onPressed: () {},
                                child: Text("Copy"),
                              ),
                            ),
                            SizedBox(width: 5.0),
                            Container(
                              width: 80,
                              child: ElevatedButton(
                                style: OutlinedButton.styleFrom(
                                    backgroundColor: AppColors.primaryColor),
                                onPressed: () {},
                                child: Text("Save"),
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

final ButtonStyle flatButtonStyle = TextButton.styleFrom(
  backgroundColor: AppColors.primaryColor,
  minimumSize: Size(88, 36),
  padding: EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2)),
  ),
);
