import 'package:flutter/material.dart';

class CourseDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                      "Pertemuan 2",
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
                    "Pengantar Algoritma",
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
                          'Product Design',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black87,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '5 Sesi Materi',
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
                        horizontal: screenWidth * 0.05,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            buildLessonItem("01", "Introduction", true),
                            SizedBox(height: screenHeight * 0.02),
                            buildLessonItem("02", "Process overview", false),
                            SizedBox(height: screenHeight * 0.02),
                            buildLessonItem("03", "User Flow", false),
                            SizedBox(height: screenHeight * 0.02),
                            buildLessonItem("04", "Wireframe", false),
                            SizedBox(height: screenHeight * 0.02),
                            buildLessonItem("05", "Final Review", false),
                            SizedBox(height: screenHeight * 0.02),
                            buildLessonItem("05", "Final Review", false),
                            SizedBox(height: screenHeight * 0.02),
                            buildLessonItem("05", "Final Review", false),
                            SizedBox(height: screenHeight * 0.02),
                            buildLessonItem("05", "Final Review", false),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Tombol Join No
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLessonItem(String number, String title, bool completed) {
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
        CircleAvatar(
          backgroundColor: Color(0xFF3C5EFF),
          child: Icon(Icons.play_arrow, color: Colors.white),
        ),
      ],
    );
  }
}
