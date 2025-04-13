import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  final String title;
  final String author;
  final int modules;

  const CourseCard({
    required this.title,
    required this.author,
    required this.modules,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigasi ke halaman detail
        print('Navigasi ke detail course');
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Thumbnail
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.blueAccent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.book_outlined, color: Colors.blueAccent),
            ),
            const SizedBox(width: 12),

            // Course info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    author,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.play_circle_fill,
                        size: 16,
                        color: Colors.redAccent,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "$modules Modules",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final List<Map<String, dynamic>> courses = [
  {"title": "Product Design", "author": "Robertson Connie", "modules": 1},
  {"title": "Quality Assurance", "author": "Nguyen Shane", "modules": 6},
  {"title": "Visual Design", "author": "Bert Pullman", "modules": 2},
  {"title": "Data Analyst", "author": "Bert Pullman", "modules": 4},
  {"title": "Data Science", "author": "Bert Pullman", "modules": 4},
  {"title": "Mobile Development", "author": "Alice Johnson", "modules": 5},
  {"title": "Web Development", "author": "John Doe", "modules": 3},
  {"title": "Cyber Security", "author": "Jane Smith", "modules": 7},
  {"title": "Machine Learning", "author": "Emily Davis", "modules": 8},
  {"title": "Cloud Computing", "author": "Michael Brown", "modules": 6},
  {"title": "Cloud Braize", "author": "Michael Brown", "modules": 6},
];
