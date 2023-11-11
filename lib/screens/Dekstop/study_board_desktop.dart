import 'package:flutter/material.dart';
import 'package:risho_guru/ui/colors.dart';

import '../../data/models/course.dart';

class StudyBoardDesktop extends StatefulWidget {
  const StudyBoardDesktop({Key? key}) : super(key: key);

  @override
  State<StudyBoardDesktop> createState() => _StudyBoardDesktopState();
}

class _StudyBoardDesktopState extends State<StudyBoardDesktop> {
  int _selectedIndex = 0;
  String inputText = '';
  List<List<int>> _selectedIndices = List.generate(3, (index) => []);

  List<Course> courses = [
    Course('Course 1', ['Lesson 1', 'Lesson 2']),
    Course('Course 2', ['Lesson 3', 'Lesson 4']),
    Course('Course 3', ['Lesson 5', 'Lesson 6', 'Lesson 7']),
  ];

  /*List<String> _lessonContents = [
    'Content for Lesson 1',
    'Content for Lesson 2',
    'Content for Lesson 3',
    'Content for Lesson 4',
    'Content for Lesson 5',
    'Content for Lesson 6',
    'Content for Lesson 7',
  ];*/

  List<String> _lessonContents = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Study Board'),
        automaticallyImplyLeading: false,
      ),
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: AppColors.backgroundColorDark,
              child: Center(
                child: ListView(
                  children: <Widget>[
                    ExpansionTile(
                      title: Text('Course 1'),
                      textColor: _selectedIndices[0].isNotEmpty
                          ? AppColors.secondaryColor
                          : Colors.white,
                      children: [
                        _buildLessonList(0, ['Lesson 1', 'Lesson 2']),
                      ],
                    ),
                    ExpansionTile(
                      title: Text('Course 2'),
                      textColor: _selectedIndices[1].isNotEmpty
                          ? AppColors.primaryColor
                          : Colors.white,
                      children: [
                        _buildLessonList(1, ['Lesson 3', 'Lesson 4']),
                      ],
                    ),
                    ExpansionTile(
                      title: Text('Course 3'),
                      textColor: _selectedIndices[2].isNotEmpty
                          ? AppColors.primaryColor
                          : Colors.white,
                      children: [
                        _buildLessonList(
                            2, ['Lesson 5', 'Lesson 6', 'Lesson 7']),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.grey[900],
                    child: Center(
                      child: Container(
                        child: Center(
                          child: Text(
                            /*_selectedIndices.isNotEmpty &&
                                    _selectedIndex < _selectedIndices.length &&
                                    _selectedIndices[_selectedIndex].isNotEmpty
                                ? _lessonContents[
                                    _selectedIndices[_selectedIndex].last]
                                : 'Select a lesson',
                            style: TextStyle(fontSize: 24.0),*/
                            _lessonContents.isNotEmpty
                                ? _lessonContents.join('\n')
                                : 'Select a lesson',
                            style: TextStyle(fontSize: 24.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  color: AppColors.backgroundColorDark,
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Type your message...',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.add_circle_outline),
                          ),
                          onChanged: (value) {
                            inputText = value;
                          },
                        ),
                      ),
                      SizedBox(width: 16.0),
                      ElevatedButton(
                        onPressed: () {
                          // Add your logic to send the message
                          setState(() {
                            /*_lessonContents.add(
                              'Lesson ${_selectedIndex + 1}: $inputText + ${DateTime.now()}',*/
                            _lessonContents
                                .add('$inputText : \n${DateTime.now()}');
                          });
                        },
                        child: Text('Send'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLessonList(int courseIndex, List<String> lessons) {
    return Column(
      children: lessons
          .asMap()
          .entries
          .map((entry) => ListTile(
                title: Text(entry.value),
                selected: _selectedIndices[courseIndex].contains(entry.key),
                onTap: () {
                  setState(() {
                    _selectedIndex = courseIndex;
                    if (_selectedIndices[courseIndex].contains(entry.key)) {
                      _selectedIndices[courseIndex].remove(entry.key);
                      _lessonContents.remove(entry.value);
                    } else {
                      // _selectedIndices[courseIndex].add(entry.key);
                      _lessonContents.add(entry.value);
                    }
                  });
                },
              ))
          .toList(),
    );
  }
}
