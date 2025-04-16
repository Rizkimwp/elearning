import 'package:elearning/app/data/meeting/meeting.dart';
import 'package:elearning/app/data/quiz/controller/quiz_controller.dart';
import 'package:elearning/app/modules/course/views/add_course.dart';
import 'package:elearning/app/modules/course/views/add_quiz.dart';
import 'package:elearning/app/modules/course/views/quiz_detail_guru.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CourseDetailGuruPage extends StatelessWidget {
  final Meeting meeting;

  const CourseDetailGuruPage({super.key, required this.meeting});
  @override
  Widget build(BuildContext context) {
    final quizController = Get.put<QuizController>(QuizController());
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFFE3F4FF), // light blue background
      appBar: AppBar(backgroundColor: Color(0xFFE3F4FF)),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.yellow[700],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        topRight: Radius.circular(80), // tajam
                        bottomRight: Radius.circular(80), // tajam
                      ),
                    ),

                    child: Text(
                      meeting.title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    meeting.description,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            // White Card Section
            Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.01,
              ),
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.02,
              ),
              height: MediaQuery.of(context).size.height * 0.73,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.05,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          meeting.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black87,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '4 Sesi Materi',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),

                  // List Modul
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.06,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Obx(() {
                              final quiz = quizController.quiz.firstWhereOrNull(
                                (q) => q.meeting?.id == meeting.id,
                              );

                              return buildLessonItem(
                                "01",
                                "Quiz",
                                true,
                                quiz != null ? Icons.remove_red_eye : Icons.add,
                                () {
                                  if (quiz != null) {
                                    Get.to(() => QuizDetailPage(quiz: quiz));
                                  } else {
                                    Get.to(() => AddQuizForm(meeting: meeting));
                                  }
                                },
                              );
                            }),

                            SizedBox(height: screenHeight * 0.02),
                            buildLessonItem(
                              "02",
                              "Pengenalan Materi",
                              false,
                              Icons.add,
                              () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) {
                                    return Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                          1.8,
                                      child: AddCourseForm(),
                                    );
                                  },
                                );
                              },
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            buildLessonItem(
                              "03",
                              "Modul Pembelajaran",
                              false,
                              Icons.add,
                              () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) {
                                    return Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                          1.8,
                                      child: AddCourseForm(),
                                    );
                                  },
                                );
                              },
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            buildLessonItem(
                              "04",
                              "Diskusi",
                              false,
                              Icons.add,
                              () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) {
                                    return Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                          1.8,
                                      child: AddCourseForm(),
                                    );
                                  },
                                );
                              },
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            buildLessonItem(
                              "05",
                              "Tugas ",
                              false,
                              Icons.add,
                              () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) {
                                    return Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                          1.8,
                                      child: AddCourseForm(),
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLessonItem(
    String number,
    String title,
    bool completed,
    IconData icons,
    VoidCallback onTap,
  ) {
    return Row(
      children: [
        Text(
          number,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.normal,
            fontFamily: 'Poppins',
            color: Colors.black,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  color: Colors.black,
                ),
              ),
              Row(
                children: [
                  Text(
                    "Assignments",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Poppins',
                      color: Colors.black,
                    ),
                  ),
                  if (completed)
                    Icon(
                      Icons.check_circle,
                      color: Color(0xFF3C5EFF),
                      size: 16,
                    ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(width: 8),
        ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF3C5EFF),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Icon(icons, color: Colors.white),
        ),
      ],
    );
  }
}
