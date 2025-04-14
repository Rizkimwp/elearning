import 'package:elearning/app/modules/course/controllers/course_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCourseForm extends StatelessWidget {
  static final courseController = Get.put<CourseController>(CourseController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController orderController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.03,
              ),
              width: 100,
              height: 4,
              color: Colors.black,
            ),
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Course Title',
                hintText: 'Enter the course title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.grey[200],
                prefixIcon: Icon(Icons.title),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: descriptionController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Course Description',
                hintText: 'Enter the course description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.grey[200],
                prefixIcon: Icon(Icons.description),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a description';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: orderController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Course Order',
                hintText: 'Enter the order of the course',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.grey[200],
                prefixIcon: Icon(Icons.format_list_numbered),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an order number';
                }
                if (int.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            SizedBox(
              width:
                  double
                      .infinity, // Membuat lebar tombol penuh secara horizontal
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    String title = titleController.text;
                    String description = descriptionController.text;
                    int order = int.parse(orderController.text);
                    courseController.addPost(title, description, order);
                    Navigator.pop(
                      context,
                    ); // Menutup bottom sheet setelah submit
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Simpan',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
