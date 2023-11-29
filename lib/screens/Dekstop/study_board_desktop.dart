import 'package:flutter/material.dart';
import 'package:risho_guru/ui/colors.dart';

import '../../models/course.dart';

class StudyBoardDesktop extends StatefulWidget {
  const StudyBoardDesktop({Key? key}) : super(key: key);

  @override
  State<StudyBoardDesktop> createState() => _StudyBoardDesktopState();
}

class _StudyBoardDesktopState extends State<StudyBoardDesktop> {
  bool _isPressed = false;
  int _selectedIndex = 0;
  String inputText = '';
  late List<List<int>> _selectedIndices;
  @override
  void initState() {
    super.initState();
    _selectedIndices = List.generate(courses.length, (index) => []);
  }

  int _selectedLessonIndex = -1;

  void togglePressed() {
    setState(() {
      _isPressed = !_isPressed;
      print('isPressed: $_isPressed');
    });
  }

  List<Course> courses = [
    Course('English for Today - Class 1',
        ['How to Say Hello', 'How to greet your Elders']),
    Course('Elementary Physics', [
      'What is an Atom? - Lesson for Kids',
      'What is Mass? - Lesson for Kids',
      'Ions Lesson for Kids',
      'Newton\'s Three Laws of Motion Lesson for Kids',
      'The Theory of Relativity Lesson for Kids'
    ]),
    Course('Elementary Mathematics', [
      '1. Number and Algebra',
      '2. Geometry and measurement',
      '3. Statistics and probability',
    ]),
    Course('Elementary Chemistry ', [
      'States of Matter',
      'Atoms and Elements',
      'Molecules and Compounds',
      'Solutions and Mixtures',
      'The Periodic Table',
      'Density'
    ]),
  ];
  late int courseIndex = 0;

  List<String> _lessonContents = [];
  List<Widget> _lessonComponents = [];
  bool isListViewVisible = true; // Add this variable

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Study Board'),
        automaticallyImplyLeading: false,
        actions: [
          Container(
            margin: EdgeInsets.all(10.0),
            child: ElevatedButton(
              style: OutlinedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor),
              onPressed: () {},
              child: Row(
                children: [
                  Text("Earned Points: "),
                  Text(
                    "0",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: AppColors.backgroundColorDark,
              child: Column(
                children: [
                  // Your collapsible text here
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isListViewVisible = !isListViewVisible;
                      });
                      // Toggle the visibility of the text, or implement the desired behavior
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.primaryColor,
                      ),
                      margin: EdgeInsets.fromLTRB(10, 10.0, 10, 10.0),
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'My Courses',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            isListViewVisible
                                ? Icons.expand_less
                                : Icons.expand_more,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: isListViewVisible,
                    child: Expanded(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(5.0, 0, 5.0, 0),
                        child: Center(
                          child: ListView(
                            children: courses.map((course) {
                              int courseIndex = courses.indexOf(course);
                              return Container(
                                margin: EdgeInsets.all(2.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.grey[800],
                                ),
                                child: ExpansionTile(
                                  title: Text(
                                    course.name,
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  textColor:
                                      _selectedIndices[courseIndex].isNotEmpty
                                          ? AppColors.primaryColor
                                          : Colors.white,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(5, 0, 5, 5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        color: Colors.grey[850],
                                      ),
                                      child: _buildLessonList(
                                        courseIndex,
                                        course.lessons,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isListViewVisible = !isListViewVisible;
                      });
                      // Toggle the visibility of the text, or implement the desired behavior
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.primaryColor,
                      ),
                      margin: EdgeInsets.fromLTRB(10, 10.0, 10, 10.0),
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Recommended',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            isListViewVisible
                                ? Icons.expand_less
                                : Icons.expand_more,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
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
                Container(
                  color: AppColors.backgroundColorDark,
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          cursorColor: AppColors.primaryColor,
                          decoration: InputDecoration(
                            hintText: 'Type your message...',
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.primaryColor,
                              ),
                            ),
                            prefixIcon: Icon(
                              Icons.add_circle_outline,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          onChanged: (value) {
                            inputText = value;
                          },
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      ElevatedButton(
                        style: OutlinedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor),
                        onPressed: () {
                          // Add your logic to send the message
                          setState(() {
                            _lessonContents
                                .add('$inputText : ${DateTime.now()}');
                            _lessonComponents.add(generateComponent(
                                inputText, courseIndex, _selectedLessonIndex));
                          });
                        },
                        child: const Icon(
                          Icons.send_rounded,
                          size: 18,
                        ),
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
    print("Course Index: $courseIndex");
    print("Selected Lesson Index: $_selectedLessonIndex");
    return Column(
      children: lessons
          .asMap()
          .entries
          .map((entry) => ListTile(
                title: Text(
                  "> " + entry.value,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                selected: _selectedIndices[courseIndex].contains(entry.key),
                onTap: () {
                  setState(() {
                    _selectedIndices[courseIndex].clear();
                    // _selectedIndex = courseIndex;
                    _selectedLessonIndex = entry.key;
                    if (_selectedIndices[courseIndex].contains(entry.key)) {
                      _selectedIndices[courseIndex].remove(entry.key);
                      _lessonContents.remove(entry.value);
                    } else {
                      _selectedIndices[courseIndex].add(entry.key);
                      _lessonContents.add(entry.value);
                    }
                  });
                },
              ))
          .toList(),
    );
  }

  Widget generateComponent(String inputText, int courseIndex, int lessonIndex) {
    bool _isPressed = false;
    String selectedLessonName = _selectedLessonIndex != -1
        ? courses[courseIndex].lessons[_selectedLessonIndex]
        : '';
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
                    selectedLessonName.isNotEmpty
                        ? 'Selected Lesson: $selectedLessonName'
                        : 'No Lesson Selected',
                  ),
                  Text(
                    inputText,
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
                              Icons.audiotrack_outlined,
                              color: AppColors.secondaryColor,
                              size: 14,
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
                            setState(() {
                              showPopupMenuPOP(
                                  context,
                                  const Offset(0, 40),
                                  context.findRenderObject() as RenderBox,
                                  courseIndex);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.all(10.0),
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
                              Icons.audiotrack_outlined,
                              color: AppColors.secondaryColor,
                              size: 14,
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
                            setState(() {
                              showPopupMenuPOP(
                                  context,
                                  const Offset(0, 40),
                                  context.findRenderObject() as RenderBox,
                                  courseIndex);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Text(
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

  void showPopupMenuPOP(
      BuildContext context, Offset offset, RenderBox button, int courseIndex) {
    final RenderBox overlay =
        Overlay.of(context)!.context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero),
            ancestor: overlay),
      ),
      offset & const Size(00, 0),
    );

    showMenu(
      context: context,
      /*position: RelativeRect.fill,*/
      position: position,
      items: [
        const PopupMenuItem<String>(
          value: 'translate',
          child: Row(
            children: [
              Icon(
                Icons.translate_outlined,
                color: AppColors.secondaryColor,
                size: 14,
              ),
              SizedBox(width: 8),
              Text(
                'Translate',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
        const PopupMenuItem<String>(
          value: 'takeExam',
          child: Row(
            children: [
              Icon(
                Icons.assignment_outlined,
                color: AppColors.secondaryColor,
                size: 14,
              ),
              SizedBox(width: 8),
              Text(
                'Take Exam',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
        const PopupMenuItem<String>(
          value: 'showEssayQuestion',
          child: Row(
            children: [
              Icon(
                Icons.subject_outlined,
                color: AppColors.secondaryColor,
                size: 14,
              ),
              SizedBox(width: 8),
              Text(
                'Show Essay Question',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
        const PopupMenuItem<String>(
          value: 'showVideo',
          child: Row(
            children: [
              Icon(
                Icons.video_library_outlined,
                color: AppColors.secondaryColor,
                size: 14,
              ),
              SizedBox(width: 8),
              Text(
                'Show Video',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
        const PopupMenuItem<String>(
          value: 'dislike',
          child: Row(
            children: [
              Icon(
                Icons.thumb_down_outlined,
                color: AppColors.secondaryColor,
                size: 14,
              ),
              SizedBox(width: 8),
              Text(
                'Dislike',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
        const PopupMenuItem<String>(
          value: 'markInappropriate',
          child: Row(
            children: [
              Icon(
                Icons.report_outlined,
                color: AppColors.secondaryColor,
                size: 14,
              ),
              SizedBox(width: 8),
              Text(
                'Mark Inappropriate',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
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
              padding: const EdgeInsets.all(10),
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
            const SizedBox(width: 8),
            Text(text),
          ],
        ),
      ),
    );
  }
}
