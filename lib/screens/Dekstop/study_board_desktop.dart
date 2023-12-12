import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:html/parser.dart';
import 'package:risho_guru/providers/getTaslation_provider.dart';
/*import 'package:markdown/markdown.dart' as md;*/
import 'package:risho_guru/ui/colors.dart';
import 'package:provider/provider.dart';
import '../../models/course.dart';
import '../../providers/auth_provider.dart';
import '../../providers/courses_provider.dart';
import '../../providers/getLessonAnswer_Provider.dart';

class StudyBoardDesktop extends StatefulWidget {
  const StudyBoardDesktop({Key? key}) : super(key: key);

  @override
  State<StudyBoardDesktop> createState() => _StudyBoardDesktopState();
}

class _StudyBoardDesktopState extends State<StudyBoardDesktop> {
  bool _isPressed = false;
  int _selectedIndex = 0;
  String inputText = '';
  late List<Course>? _courses = [];
  late List<List<int>> _selectedIndices;

  int _selectedLessonIndex = -1;
  int courseIndex = -1;
  int selectedCourseId = 0;
  int selectedLessonId = 0;
  int userid = 0;
  List<String> _lessonContents = [];
  List<Widget> _lessonComponents = [];
  bool isListViewVisible = false; // Add this variable

  @override
  void initState() {
    super.initState();
    // Assuming you have a method to fetch courses, replace this with your actual logic
    _selectedIndices = List.generate(_courses!.length, (index) => []);
  }

  void togglePressed() {
    setState(() {
      _isPressed = !_isPressed;
      print('isPressed: $_isPressed');
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    userid = authProvider.user?.id ?? 0;
    /*final courseProvider = CourseProvider(userId: authProvider.user?.id ?? 0);*/
    final courseProvider = context.read<CourseProvider>();
    final translationProvider = context.read<TranslationProvider>();

    _courses = courseProvider.courses ?? [];

    print("courses in studyboard = $_courses");

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
                          child: FutureBuilder<List<Course>>(
                            future: context
                                .read<CourseProvider>()
                                .fetchCourses(userid),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (snapshot.hasError ||
                                  snapshot.data == null) {
                                return Text('ErrorSNAPSHOT: ${snapshot.error}');
                              } else {
                                final courses = snapshot.data ?? [];
                                if (courses.isEmpty) {
                                  return Text(
                                      'No courses available.'); // Handle empty course list
                                }

                                return ListView.builder(
                                  itemCount: courses.length,
                                  itemBuilder: (context, courseIndex) {
                                    var course = courses[courseIndex];
                                    selectedCourseId = course.courseId;
                                    return Container(
                                      margin: EdgeInsets.all(2.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.grey[800],
                                      ),
                                      child: ExpansionTile(
                                        title: Text(
                                          course.courseName,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                        children: _buildLessonList(courseIndex,
                                            course.chapters, selectedCourseId),
                                      ),
                                    );
                                  },
                                );
                              }
                            },
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
                          const Text(
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
                          maxLines: 3,
                          minLines: 1,
                          cursorColor: AppColors.primaryColor,
                          decoration: const InputDecoration(
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
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.backgroundColorDark),
                        onPressed: () {
                          // Add your logic to send the message
                          setState(() {
                            _lessonContents
                                .add('$inputText : ${DateTime.now()}');
                            _lessonComponents.add(generateComponent(
                                userid,
                                inputText,
                                selectedCourseId,
                                _selectedLessonIndex,
                                selectedLessonId));
                          });
                        },
                        child: const Icon(
                          Icons.send_rounded,
                          color: AppColors.primaryColor,
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

  List<Widget> _buildLessonList(
      int courseIndex, List<Chapters> chapters, int selectedCourseId) {
    /*print("Course Index: $courseIndex");
    print("Number of chapters: ${chapters.length}");*/
    return chapters.map((chapter) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExpansionTile(
            title: Text(
              chapter.lessonTitle,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: chapter.lessonList.length,
                itemBuilder: (context, lessonIndex) {
                  var lesson = chapter.lessonList[lessonIndex];
                  bool isSelected = lessonIndex == _selectedLessonIndex;
                  return ListTile(
                    title: Text(
                      lesson.lessonTitle,
                      style: TextStyle(
                        fontSize: 14,
                        color:
                            isSelected ? AppColors.primaryColor : Colors.white,
                      ),
                    ),
                    onTap: () {
                      // Handle onTap for lesson
                      setState(() {
                        selectedLessonId = lesson.lessonId;
                        _selectedLessonIndex = lessonIndex;
                        _lessonComponents.add(generateComponentGettingAnswer(
                          userid,
                          selectedCourseId,
                          _selectedLessonIndex,
                          selectedLessonId,
                        ));
                      });

                      /*int selectedCourseId = course.courseId;*/
                      print(
                          'Selected Lesson ID: $selectedLessonId, Course ID: $selectedCourseId');
                    },
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 16),
        ],
      );
    }).toList();
  }

  Widget generateComponentGettingAnswer(
      int userid, int courseId, int lessonIndex, int lessonId) {
    bool _isPressed = false;

    final lessonProvider =
        Provider.of<LessonAnswerProvider>(context, listen: false);
    return FutureBuilder<void>(
      future: lessonProvider.fetchLessonData(lessonId, courseId, userid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Loading state
        } else if (snapshot.hasError) {
          return Text('ErrorSnapshotFutureBuilder: ${snapshot.error}');
        } else {
          final ansType =
              lessonProvider.lessonModel?.lessonAnswer.ansType.toString();
          print(
              'Selected course: $courseId \n Selected lesson: $lessonId \n userid: $userid \n ANSTYPE: $ansType');

          switch (ansType) {
            case "T":
              // Your 'T' case code
              final lessonAnswer = lessonProvider.lessonModel!.lessonAnswer;
              print(lessonAnswer.textAns);
              final ansId = lessonAnswer.answerId;
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
                          "$lessonId -- $courseId",
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
                                    setState(() {
                                      _lessonComponents.add(
                                        generateNewComponentforAnswer(ansId),
                                      );
                                    });
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
                          data: lessonAnswer.textAns.toString(),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            default:
              // Your default case code
              return Text("No Text Available");
          }
        }
      },
    );
  }

  Widget generateNewComponentforAnswer(int lessonAnsId) {
    bool _isPressed = false;

    final translationProvider =
        Provider.of<TranslationProvider>(context, listen: false);
    return FutureBuilder<void>(
      future: translationProvider.fetchTranslationData(lessonAnsId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Loading state
        } else if (snapshot.hasError) {
          return Text('ErrorSnapshotFutureBuilder: ${snapshot.error}');
        } else {
          final traslation =
              translationProvider.translationModel?.traslation.TextAnsBn;

          print(traslation);
          return Container(
            // Your 'T' case UI code
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*Top Part*/
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
                      data: traslation.toString(),
                    ),
                    /*Text(
                      traslation.toString(),
                      style: TextStyle(
                        fontFamily: 'Sutonnoy',
                      ),
                    ),*/
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget generateComponent(int userid, String inputText, int courseId,
      int lessonIndex, int lessonId) {
    bool _isPressed = false;

    final lessonProvider =
        Provider.of<LessonAnswerProvider>(context, listen: false);
    return FutureBuilder<void>(
      future: lessonProvider.fetchLessonData(lessonId, courseId, userid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Loading state
        } else if (snapshot.hasError) {
          return Text('ErrorSnapshotFutureBuilder: ${snapshot.error}');
        } else {
          final ansType = lessonProvider.lessonModel?.lessonAnswer.ansType;
          print(
              'Selected course: $courseId \n Selected lesson: $lessonId \n userid: $userid \n ANSTYPE: $ansType');

          switch (ansType) {
            case 'T':
              // Your 'T' case code
              final lessonAnswer = lessonProvider.lessonModel!.lessonAnswer;
              return Container(
                // Your 'T' case UI code
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "$lessonId -- $courseId",
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
                        Text(
                          inputText,
                        ),
                        Container(
                          margin: const EdgeInsets.all(10.0),
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[800],
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child:
                              Text(lessonAnswer.textAns ?? 'No Text Available'),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            default:
              // Your default case code
              return Text(inputText);
          }
        }
      },
    );
  }

  void showPopupMenuPOP(
      BuildContext context, Offset offset, RenderBox button, int courseIndex) {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
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
