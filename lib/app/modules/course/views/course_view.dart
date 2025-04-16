import 'package:elearning/app/components/course_card.dart';
import 'package:elearning/app/components/custom_appbar.dart';
import 'package:elearning/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/course_controller.dart';

class CourseView extends GetView<CourseController> {
  static final courseController = Get.put<CourseController>(CourseController());
  const CourseView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Modul',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      color: Colors.black,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.ACCOUNT);
                    },
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/avatar/profile.png'),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: SearchBar(),
            ),
            Container(child: FilterButtons()),
            Expanded(
              child: Obx(() {
                // Menunggu data atau menampilkan loading indicator
                if (courseController.isLoading.isTrue) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (courseController.meeting.isEmpty) {
                  return const Center(
                    child: Text(
                      "Belum ada pertemuan",
                      style: TextStyle(fontSize: 15),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: courseController.meeting.length,
                  itemBuilder: (context, index) {
                    // Ambil data post dari list
                    var meeting = courseController.meeting[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: CourseCard(
                        title: meeting.title, // Menampilkan title dari meeting
                        author:
                            meeting
                                .description, // Menampilkan description sebagai author (atau ganti sesuai data yang diinginkan)
                        modules:
                            meeting
                                .order,
                        onTap:
                            () {}, // Menampilkan order sebagai modules (atau ganti sesuai data yang diinginkan)
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Cari Modul",
        hintStyle: TextStyle(color: Colors.grey.shade400),
        filled: true,
        fillColor: Colors.grey.shade100,
        prefixIcon: Icon(Icons.search, color: Colors.grey.shade400),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class FilterButtons extends StatefulWidget {
  @override
  _FilterButtonsState createState() => _FilterButtonsState();
}

class _FilterButtonsState extends State<FilterButtons> {
  int selectedIndex = 0;
  final List<String> filters = ["Semua", "Terbaru", "Sudah Lama"];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(filters.length, (index) {
        return Padding(
          padding: const EdgeInsets.only(right: 10),
          child: ChoiceChip(
            label: Text(filters[index]),
            selected: selectedIndex == index,
            onSelected: (bool selected) {
              setState(() {
                selectedIndex = index;
              });
            },
            selectedColor: Colors.blue,
            labelStyle: TextStyle(
              color: selectedIndex == index ? Colors.white : Colors.black54,
            ),
            backgroundColor: Colors.grey.shade200,
          ),
        );
      }),
    );
  }
}
