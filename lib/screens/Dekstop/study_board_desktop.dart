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
  List<Widget> _lessonComponents = [];

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
                    color: Colors.grey[800],
                    child: ListView.builder(
                      itemCount: _lessonComponents.length,
                      itemBuilder: (BuildContext context, int index) {
                        // Replace this with your actual component widget based on your data
                        return Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 15.0),
                          padding: EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: AppColors.backgroundColorDark,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: /*Text(
                            _lessonContents[index],
                            style:
                                TextStyle(fontSize: 24.0, color: Colors.black),
                          ),*/
                              _lessonComponents[index],
                        );
                        /*_lessonComponents[index];*/
                      },
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
                                .add('$inputText : ${DateTime.now()}');
                            _lessonComponents.add(generateComponent(inputText));
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

  Widget generateComponent(String inputText) {
    switch (inputText.toLowerCase()) {
      case 'image':
        // Replace 'ImageWidget' with the actual widget you want to display for images
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    inputText,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.more_horiz,
                      color: AppColors.secondaryColor,
                    ),
                    onPressed: () {
                      // Implement your logic to show a popup menu here
                      // For example, use a PopupMenuButton
                      setState(() {
                        showPopupMenu(context);
                      });
                    },
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Image.network(
                  "https://cdn.pixabay.com/photo/2014/09/05/18/32/old-books-436498_1280.jpg",
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        );
      case 'text':
        // Replace 'TextWidget' with the actual widget you want to display for text
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    inputText,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.more_horiz,
                      color: AppColors.secondaryColor,
                    ),
                    onPressed: () {
                      // Implement your logic to show a popup menu here
                      // For example, use a PopupMenuButton
                      setState(() {
                        showPopupMenu(context);
                      });
                    },
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Auctor eu augue ut lectus arcu bibendum at varius. Fringilla est ullamcorper eget nulla facilisi. Amet nisl suscipit adipiscing bibendum est ultricies integer. Sed lectus vestibulum mattis ullamcorper velit. Hendrerit dolor magna eget est lorem ipsum dolor. Eget egestas purus viverra accumsan in. At quis risus sed vulputate odio ut. In aliquam sem fringilla ut morbi tincidunt augue interdum velit. Mi ipsum faucibus vitae aliquet nec. Leo in vitae turpis massa sed elementum tempus egestas. Id neque aliquam vestibulum morbi. Scelerisque eleifend donec pretium vulputate sapien nec sagittis. Dictumst quisque sagittis purus sit amet. Ipsum dolor sit amet consectetur adipiscing elit ut. Magna sit amet purus gravida quis blandit. Arcu bibendum at varius vel. Nunc sed augue lacus viverra vitae congue.Mauris nunc congue nisi vitae. Convallis convallis tellus id interdum velit laoreet id. Faucibus et molestie ac feugiat sed lectus. Consequat interdum varius sit amet mattis. Pharetra diam sit amet nisl suscipit. Ut aliquam purus sit amet. Pharetra diam sit amet nisl. Scelerisque viverra mauris in aliquam sem. In fermentum et sollicitudin ac orci. Duis convallis convallis tellus id interdum velit. Feugiat in ante metus dictum at tempor. Congue quisque egestas diam in arcu cursus euismod quis. Convallis aenean et tortor at risus viverra adipiscing. Elementum curabitur vitae nunc sed. Nunc sed velit dignissim sodales ut eu sem integer vitae. Diam donec adipiscing tristique risus nec feugiat. Facilisis sed odio morbi quis commodo odio aenean sed. Ornare arcu odio ut sem nulla pharetra diam. Nisl pretium fusce id velit ut.Enim tortor at auctor urna nunc id cursus metus aliquam. Aliquam ut porttitor leo a diam. Velit scelerisque in dictum non consectetur. Diam sollicitudin tempor id eu nisl nunc mi ipsum. Dignissim suspendisse in est ante in nibh mauris. Morbi blandit cursus risus at ultrices mi tempus imperdiet nulla. Quisque non tellus orci ac auctor augue. Eu tincidunt tortor aliquam nulla. Faucibus nisl tincidunt eget nullam non nisi. Amet consectetur adipiscing elit ut aliquam. Ipsum a arcu cursus vitae congue mauris rhoncus. Aenean et tortor at risus. Semper viverra nam libero justo laoreet sit amet cursus sit. Felis bibendum ut tristique et egestas quis ipsum suspendisse."),
              ),
            ],
          ),
        );

      default:
        // Replace 'DefaultWidget' with the default widget you want to display
        return Text(
          inputText,
        );
    }
  }

  void showPopupMenu(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Container(
              width: 200,
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildMenuItem(
                      context, 'Like', Icons.thumb_up_outlined, 'like'),
                  buildMenuItem(context, 'Ask Question',
                      Icons.question_answer_outlined, 'askQuestion'),
                  buildMenuItem(context, 'Play Audio',
                      Icons.audiotrack_outlined, 'playAudio'),
                  buildMenuItem(context, 'Translate', Icons.translate_outlined,
                      'translate'),
                  buildMenuItem(context, 'Take Exam', Icons.assignment_outlined,
                      'takeExam'),
                  buildMenuItem(context, 'Show Essay Question', Icons.subject,
                      'showEssayQuestion'),
                  buildMenuItem(context, 'Show Video',
                      Icons.video_library_outlined, 'showVideo'),
                  buildMenuItem(
                      context, 'Dislike', Icons.thumb_down_outlined, 'dislike'),
                  buildMenuItem(context, 'Mark Inappropriate',
                      Icons.report_outlined, 'markInappropriate'),
                ],
              ),
            ),
          );
        });
  }

  Widget buildMenuItem(
      BuildContext context, String text, IconData icon, String value) {
    return GestureDetector(
      onTap: () {
        // Handle the selected menu item here
        Navigator.pop(context, value);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(icon, color: AppColors.secondaryColor),
            SizedBox(width: 8),
            Text(text),
          ],
        ),
      ),
    );
  }
}
