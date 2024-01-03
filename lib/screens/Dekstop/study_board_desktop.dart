import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:html/parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:risho_guru/providers/getEssayQuestion_provider.dart';
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

List<Widget> _lessonComponents = [];

class _StudyBoardDesktopState extends State<StudyBoardDesktop> {
  bool _isPressed = false;
  bool _askQuestionActive = false;
  int _selectedIndex = 0;
  String inputText = '';
  late List<Course>? _courses = [];
  late List<List<int>> _selectedIndices;

  int _selectedLessonIndex = 0;
  int courseIndex = 0;
  int selectedCourseId = 0;
  int selectedLessonId = 0;
  int userid = 0;
  bool isListViewVisible = false; // Add this variable

  File? _selectedImage;

  late String _selectedCourse = 'null';
  late String _selectedChapter = 'null';
  late String _selectedLesson = 'null';

  @override
  void initState() {
    super.initState();
    // Assuming you have a method to fetch courses, replace this with your actual logic
    _selectedIndices = List.generate(_courses!.length, (index) => []);
  }

  void resetSelectedClassAndSubject() {
    setState(() {
      /*_selectedCourse =
          'null';*/ // Set it to the initial value or an appropriate default
      _selectedLesson =
          'null'; // Set it to the initial value or an appropriate default
      _selectedLessonIndex = -1;
      courseIndex = -1;
      /*selectedCourseId = 0;*/
      selectedLessonId = 0;
    });
  }

  void resetLessonComponent() {
    setState(() {
      _lessonComponents = [];
    });
  }

  /*void togglePressed() {
    setState(() {
      _isPressed = !_isPressed;
      print('isPressed: $_isPressed');
    });
  }*/

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    userid = authProvider.user?.id ?? 0;
    /*final courseProvider = CourseProvider(userId: authProvider.user?.id ?? 0);*/
    final courseProvider = context.read<CourseProvider>();
    final translationProvider = context.read<TranslationProvider>();

    _courses = courseProvider.courses ?? [];

    /*print("courses in studyboard = $_courses");*/

    return Scaffold(
      appBar: AppBar(
        title: const Text('Study Board'),
        automaticallyImplyLeading: false,
        actions: [
          Container(
            margin: EdgeInsets.all(10.0),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    resetLessonComponent();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                  ),
                  child: const Icon(
                    Icons.cleaning_services_rounded,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                  ),
                  child: Icon(
                    Icons.save_outlined,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                /*EARNED POINTS*/
                ElevatedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    padding: EdgeInsets.all(10.0),
                  ),
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
              ],
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          /*LEFT COURSE CONTAINER*/
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
                      margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5.0),
                      padding: const EdgeInsets.all(12.0),
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

                                    return Container(
                                      margin: EdgeInsets.all(2.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.grey[800],
                                      ),
                                      child: ExpansionTile(
                                        title: MaterialButton(
                                          child: Text(
                                            course.courseName,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              selectedCourseId =
                                                  course.courseId;
                                              _selectedCourse =
                                                  course.courseName;

                                              resetSelectedClassAndSubject();
                                            });
                                          },
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
                      margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                      padding: EdgeInsets.all(12.0),
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
          /*RIGHT LESSON COMPONENT CONTAINER*/
          Expanded(
            flex: 8,
            child: Column(
              children: [
                /*TOP CONTAINER*/
                Container(
                  width: double.infinity,
                  color: AppColors.backgroundColorDark,
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: [
                      Text(
                        "Selected Course: ",
                        style: TextStyle(color: AppColors.primaryColor),
                      ),
                      Text(_selectedCourse),
                      const SizedBox(width: 16.0),
                      Text(
                        "Selected Lesson: ",
                        style: TextStyle(color: AppColors.primaryColor),
                      ),
                      SizedBox(
                        width: 300.0,
                        child: Text(
                          _selectedLesson,
                          overflow: TextOverflow.fade,
                          softWrap: false,
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Text(
                        "Class: ",
                        style: TextStyle(color: AppColors.primaryColor),
                      ),
                      Text(_selectedLessonIndex.toString()),
                    ],
                  ),
                ),
                /*STUDY BOARD COMPONENTS LOADING PART*/
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
                /*QUESTION ASKING BOX*/
                Visibility(
                  visible: _askQuestionActive,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Lesson: $_selectedLesson"),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.backgroundColorDark),
                          onPressed: () {
                            // Add your logic to send the message
                            setState(() {
                              _askQuestionActive = false;
                            });
                          },
                          child: const Icon(
                            Icons.close_rounded,
                            color: AppColors.primaryColor,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: AppColors.backgroundColorDark,
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.backgroundColorDark),
                        onPressed: () {
                          _pickImage(context);
                        },
                        child: const Icon(
                          Icons.add_a_photo_outlined,
                          color: AppColors.primaryColor,
                          size: 18,
                        ),
                      ),
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
                          ),
                          onChanged: (value) {
                            inputText = value;
                          },
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.backgroundColorDark),
                        onPressed: () {
                          // Add your logic to send the message
                          setState(() {
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

  /*CHAPTER AND LESSON LIST LOADER*/
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
                        _selectedLesson = lesson.lessonTitle;
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

  /*BUTTONS UNDER RESPONSE*/
  Widget _menuButtonRow(int answerId) {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
            ),
            onPressed: () {
              setState(() {
                _askQuestionActive = true;
              });
            },
            child: Text("Ask Question"),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text("MCQ Exam"),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _lessonComponents.add(
                  generateEssayQuestions(selectedLessonId),
                );
              });
            },
            child: Text("Generate Questions"),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text("Play Audio"),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text("Show Video Content"),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _lessonComponents.add(
                  generateTranslationforAnswer(answerId),
                );
              });
            },
            child: Text("Translation"),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  /*LESSON ANSWER GENERATOR*/
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

              final answer = lessonAnswer.textAns ?? "No answer available";
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
                    /*LESSONNAME*/
                    Container(
                      width: double.infinity,
                      child: Text(
                        _selectedLesson,
                        style: TextStyle(color: AppColors.secondaryColor),
                      ),
                    ),
                    /*ANSWER RESPONSE*/
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
                          data: answer.toString(),
                        ),
                      ),
                    ),
                    /*MENU BUTTONS*/
                    Container(
                      child: _menuButtonRow(ansId),
                    )
                  ],
                ),
              );
            default:
              // Your default case code
              final lessonAnswer = lessonProvider.lessonModel?.lessonAnswer;
              print(lessonAnswer?.textAns);

              String? answer = lessonAnswer?.textAns;
              return Text(answer!);
          }
        }
      },
    );
  }

  /*ANSWER TRANSLATION GENERATOR*/
  Widget generateTranslationforAnswer(int lessonAnsId) {
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
                      styleSheet: MarkdownStyleSheet(
                        a: TextStyle(fontSize: 12),
                      ),
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

  /*COMPONENT GENERATOR TO LOAD ON THE LIST OF STUDY BOARD*/
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

  /*ASK QUESTION COMPONENT*/

  /*MCQ EXAM COMPONENT*/

  /*GENERATE QUESTION COMPONENT*/
  Widget generateEssayQuestions(int lessonId) {
    final getEssayQuestionProvider =
        Provider.of<EssayQuestionProvider>(context, listen: false);
    return FutureBuilder<void>(
      future: getEssayQuestionProvider.fetchEssayQuestionResponse(lessonId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Loading state
        } else if (snapshot.hasError) {
          return Text('ErrorSnapshotFutureBuilder: ${snapshot.error}');
        } else {
          final essayQuesResponse =
              getEssayQuestionProvider.essayQuestionResponse;
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  children: [
                    Text(
                      "Essay Questions for: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "$_selectedLesson",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: getEssayQuestionProvider
                      .essayQuestionResponse?.questionList.length,
                  itemBuilder: (context, questionIndex) {
                    /*var lesson = chapter.lessonList[lessonIndex];
                    bool isSelected = lessonIndex == _selectedLessonIndex;*/
                    final question =
                        essayQuesResponse?.questionList[questionIndex];
                    String questionText = question?.questionText ?? '';
                    String answerText = question?.ansText ?? '';
                    return Container(
                      // Your 'T' case UI code
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(10.0),
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[800],
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Text(
                              "Question: $questionText",
                              style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(10.0),
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[800],
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Text("Answer: $answerText"),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }

  /*PLAY AUDIO COMPONENT*/

  /*SHOW VIDEO COMPONENT*/

  /*PICK IMAGE*/
  Future<File?> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
        _showSelectedImageDialog(context, _selectedImage!);
      });

      print("file picked ${pickedFile.path}");
      return File(pickedFile.path);
    } else {
      print("nothing picked");
      return null;
    }
  }

  Future<void> _showSelectedImageDialog(
      BuildContext context, File selectedImage) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Selected Image'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                if (_selectedImage != null)
                  Image.file(_selectedImage!, height: 200, width: 200),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /*POPUP ON MORE CLICK ON COMPONENTS*/
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

  /*POPUP MENU ITEMS*/
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

  /*COMMON MENU ITEMS*/
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
