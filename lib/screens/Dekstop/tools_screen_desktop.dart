import 'package:flutter/material.dart';
import 'dart:io';
import 'package:custom_button_builder/custom_button_builder.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';

import '../../models/getToolsData_DataModel.dart';
import '../../providers/auth_provider.dart';
import '../../providers/getToolsData_provider.dart';
import '../../providers/toolsResponse_provider.dart';
import '../../providers/tools_provider.dart';
import '../../ui/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:crop_your_image/crop_your_image.dart';

class ToolsScreenDesktop extends StatefulWidget {
  const ToolsScreenDesktop({super.key});

  @override
  State<ToolsScreenDesktop> createState() => _ToolsScreenDesktopState();
}

List<Widget> _lessonComponents = [];
List<Widget> _toolsComponents = [];

final _cropController = CropController();

class _ToolsScreenDesktopState extends State<ToolsScreenDesktop> {
  String dropdownClassValue = "";
  String dropdownSubjectValue = "";
  TextEditingController questionTextFieldController = TextEditingController();
  late ToolsDataProvider toolsDataProvider;

  File? _selectedImage;

  DropdownMenu<String> buildDropdownMenuClass() {
    return DropdownMenu<String>(
      onSelected: (String? value) {
        setState(() {
          _selectedClassName = value!;
          print("$_selectedClassName << Selectedclassname");
        });
      },
      dropdownMenuEntries: toolsDataProvider.toolsData?.classList
              .map<DropdownMenuEntry<String>>((ClassInfo classInfo) {
            return DropdownMenuEntry<String>(
              value: classInfo.className,
              label: classInfo.className,
            );
          }).toList() ??
          [],
    );
  }

  DropdownMenu<String> buildDropdownMenuSubjects() {
    List<DropdownMenuEntry<String>> dropdownEntries = [];

    if (toolsDataProvider.toolsData?.subjectList != null) {
      dropdownEntries = toolsDataProvider.toolsData!.subjectList
          .map<DropdownMenuEntry<String>>((Subject subject) {
        return DropdownMenuEntry<String>(
          value: subject.subjectName,
          label: subject.subjectName,
        );
      }).toList();
    }

    return DropdownMenu<String>(
      onSelected: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          _selectedSubjectName = value!;
          print("$_selectedSubjectName << _selectedSubjectName");
        });
      },
      dropdownMenuEntries: dropdownEntries,
    );

    /*return DropdownMenu<String>(
      onSelected: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          _selectedSubjectName = value!;
          print("$_selectedSubjectName << _selectedSubjectName");
        });
      },
      dropdownMenuEntries: toolsDataProvider.toolsData?.subjectList
              .map<DropdownMenuEntry<String>>((Subject subject) {
            return DropdownMenuEntry<String>(
              value: subject.subjectName,
              label: subject.subjectName,
            );
          }).toList() ??
          [],
    );*/
  }

  void resetSelectedClassAndSubject() {
    setState(() {
      _selectedClassName =
          'null'; // Set it to the initial value or an appropriate default
      _selectedSubjectName =
          'null'; // Set it to the initial value or an appropriate default
    });
  }

  void resetLessonComponent() {
    setState(() {
      _lessonComponents = [];
    });
  }

  /*final controller = CropController(
    aspectRatio: 1,
    defaultCrop: const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9),
  );*/

  bool isSelected = false;
  bool isImagePicked = false;
  /*String dropdownValue = list.first;*/

  late String _selectedToolsCode;
  late String _selectedToolName = '';
  late String _selectedClassName = 'null';
  late String _selectedSubjectName = 'null';
  late String _question = '';
  late String _maxLine = '';
  final String _isMobile = 'Y';

  bool maxWordVisibility = false;
  bool subjectSelectionVisibility = false;
  bool mathKeyboardVisibility = false;

  /*COMMON TOOL BUTTONS*/
  ElevatedButton buildToolButton(
    String toolName,
    String toolsCode,
    int toolId,
    String subject,
    String maxWord,
    String mathKeyboard, {
    required VoidCallback onToolSelected,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
      ),
      onPressed: () {
        resetSelectedClassAndSubject();
        onToolSelected();
        setState(() {
          _selectedToolsCode = toolsCode;
          _selectedToolName = toolName;
        });
        if (maxWord == "Y") {
          setState(() {
            maxWordVisibility = true;
          });
        } else {
          setState(() {
            maxWordVisibility = false;
          });
        }
        if (mathKeyboard == "Y") {
          setState(() {
            mathKeyboardVisibility = true;
          });
        } else {
          setState(() {
            mathKeyboardVisibility = false;
          });
        }

        if (subject == "Y") {
          setState(() {
            subjectSelectionVisibility = true;
          });
        } else {
          setState(() {
            subjectSelectionVisibility = false;
          });
        }
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
    print("selected Tool : $_selectedToolName");

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Work Tools'),
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
                const SizedBox(
                  width: 10,
                ),
                /*EARNED POINTS*/

                Text(_selectedToolName),
              ],
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          /*Tools List*/
          Expanded(
            flex: 2,
            child: Container(
              height: double.infinity,
              color: AppColors.backgroundColorDark,
              child: Builder(builder: (context) {
                return FutureBuilder(
                  future:
                      toolsProvider.fetchTools(), // Call the fetchTools method
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      // Display your list of tools
                      return SingleChildScrollView(
                        child: Column(
                          children: toolsProvider.tools.map((tool) {
                            return Container(
                              width: double.infinity,
                              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                              height: 50,
                              child: buildToolButton(
                                tool.toolName,
                                tool.toolsCode,
                                tool.toolID,
                                tool.subject,
                                tool.maxWord,
                                tool.mathKeyboard,
                                onToolSelected: () {
                                  // Call the API when a tool is selected
                                  toolsDataProvider.fetchToolsData(
                                    userID,
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
                );
              }),
            ),
          ),
          /*TOLLS COMPONENTS VIEW*/
          Expanded(
            flex: 8,
            child: Container(
              margin: const EdgeInsets.all(10),
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
                  /*BOTTOM CONTROL*/
                  Column(
                    children: [
                      /*BOTTOM CONTROL 1ST ROW*/
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
                            /*SELECTED CLASS*/
                            Container(
                              padding: EdgeInsets.all(5),
                              child: Row(
                                children: [
                                  Text("Class "),
                                  Consumer<ToolsDataProvider>(
                                    builder:
                                        (context, toolsDataProvider, child) {
                                      return buildDropdownMenuClass();
                                    },
                                  )
                                ],
                              ),
                            ),
                            /*SELECTED SUBJECT*/
                            Visibility(
                              visible: subjectSelectionVisibility,
                              child: Container(
                                padding: EdgeInsets.all(5),
                                child: Row(
                                  children: [
                                    Text("Subject "),
                                    Consumer<ToolsDataProvider>(
                                      builder:
                                          (context, toolsDataProvider, child) {
                                        return buildDropdownMenuSubjects();
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ),
                            /*MAX LINES*/
                            Visibility(
                              visible: maxWordVisibility,
                              child: Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    maxLines: 1,
                                    cursorColor: AppColors.primaryColor,
                                    decoration: const InputDecoration(
                                      hintText:
                                          'Ender 1 to 50 word limit you want',
                                      border: OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                    ),
                                    onChanged: (value) {
                                      if (value.isNotEmpty) {
                                        int? intValue = int.tryParse(value);
                                        if (intValue == null) {
                                          // Show a Snackbar if the entered value is not a valid integer
                                          const snackBar = SnackBar(
                                            backgroundColor:
                                                AppColors.primaryColor,
                                            content: Text(
                                              'Enter a valid number',
                                              style: TextStyle(
                                                  color: AppColors
                                                      .backgroundColorDark,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        } else if (intValue > 50) {
                                          // Show a Snackbar if the entered value is greater than 50
                                          const snackBar = SnackBar(
                                            backgroundColor:
                                                AppColors.primaryColor,
                                            content: Text(
                                              'Enter a number less than or equal to 50',
                                              style: TextStyle(
                                                  color: AppColors
                                                      .backgroundColorDark,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        } else {
                                          // Store the valid value
                                          _maxLine = intValue.toString();
                                        }
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      /*BOTTOM CONTROL 2ND ROW*/
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
                            /*ADD DOCUMENT BUTTON*/
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
                            /*TYPE MESSAGE*/
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
                            /*BUTTON CONTROLS IMAGE, KEYBOARD, SEND*/
                            Container(
                              child: Row(
                                children: [
                                  /*IMAGE PICKER*/
                                  Visibility(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        _pickImage(context);
                                        setState(() {
                                          isImagePicked = true;
                                        });
                                      },
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
                                    visible: mathKeyboardVisibility,
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
                                        if (isImagePicked) {
                                          setState(() {
                                            _lessonComponents.add(
                                              generateComponentGettingImageResponse(
                                                  context,
                                                  _selectedImage!,
                                                  userID,
                                                  _question,
                                                  _selectedSubjectName,
                                                  _selectedClassName,
                                                  _selectedToolsCode,
                                                  _maxLine,
                                                  _isMobile),
                                            );
                                            // Clear the text in the TextField
                                            questionTextFieldController.clear();
                                          });
                                        } else {
                                          setState(() {
                                            _lessonComponents.add(
                                              generateComponentGettingResponse(
                                                  context,
                                                  userID,
                                                  _question,
                                                  _selectedSubjectName,
                                                  _selectedClassName,
                                                  _selectedToolsCode,
                                                  _maxLine,
                                                  _isMobile),
                                            );
                                            // Clear the text in the TextField
                                            questionTextFieldController.clear();
                                          });
                                        }
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

  Future<File?> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });

      print("file picked ${pickedFile.path}");
      return File(pickedFile.path);
    } else {
      print("nothing picked");
      return null;
    }
  }

  void _showCroppedImageDialog(BuildContext context, File croppedImage) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Cropped Image'),
          content: Image.file(croppedImage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _cropImage(File imageFile) async {
    ImageCropper cropper = ImageCropper();
    final croppedFile = await cropper.cropImage(
      sourcePath: imageFile.path,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      compressQuality: 100,
      maxWidth: 800,
      maxHeight: 800,
      androidUiSettings: const AndroidUiSettings(
        toolbarTitle: 'Crop Image',
        toolbarColor: Colors.blue,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false,
      ),
      iosUiSettings: IOSUiSettings(
        title: 'Crop Image',
      ),
    );

    if (croppedFile != null) {
      // Handle the cropped image file
      // You can save or process the cropped image as needed
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
}

Widget generateComponentGettingResponse(
    BuildContext context,
    int userid,
    String question,
    String selectedSubject,
    String selectedClass,
    String selectedToolsCode,
    String maxLine,
    String isMobile) {
  bool _isPressed = false;
  final toolsResponseProvider =
      Provider.of<ToolsResponseProvider>(context, listen: false);
  return FutureBuilder<void>(
    future: toolsResponseProvider.fetchToolsResponse(userid, question,
        selectedSubject, selectedClass, selectedToolsCode, maxLine, isMobile),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const CircularProgressIndicator(); // Loading state
      } else if (snapshot.hasError) {
        return Text('ErrorSnapshotFutureBuilder: ${snapshot.error}');
      } else {
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

Widget generateComponentGettingImageResponse(
    BuildContext context,
    File questionImage,
    int userid,
    String question,
    String selectedSubject,
    String selectedClass,
    String selectedToolsCode,
    String maxLine,
    String isMobile) {
  final toolsResponseProvider =
      Provider.of<ToolsResponseProvider>(context, listen: false);
  return FutureBuilder<void>(
    future: toolsResponseProvider.fetchImageToolsResponse(
        questionImage,
        userid,
        question,
        selectedSubject,
        selectedClass,
        selectedToolsCode,
        maxLine,
        isMobile),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const CircularProgressIndicator(); // Loading state
      } else if (snapshot.hasError) {
        return Text('ErrorSnapshotFutureBuilder: ${snapshot.error}');
      } else {
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
