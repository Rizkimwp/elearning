import 'package:elearning/app/components/course_card.dart';
import 'package:elearning/app/data/diskusi/controller/diskusi_controller.dart';
import 'package:elearning/app/modules/course/controllers/course_controller.dart';
import 'package:elearning/app/modules/course/views/course_detail_guru.dart';
import 'package:elearning/app/modules/course/views/diskusi_detail_guru.dart';
import 'package:elearning/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/message_controller.dart';

class MessageGuruView extends GetView<MessageController> {
  static final diskusiController = Get.put<DiskusiController>(
    DiskusiController(),
  );
  static final courseController = Get.put<CourseController>(CourseController());
  const MessageGuruView({super.key});

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
                    'Diskusi',
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
                return RefreshIndicator(
                  onRefresh: diskusiController.refreshData,
                  child:
                      diskusiController.diskusi.isEmpty
                          ? ListView(
                            // Supaya tetap bisa discroll walau kosong
                            children: const [
                              SizedBox(
                                height: 400, // kasih tinggi biar bisa digeser
                                child: Center(
                                  child: Text(
                                    "Belum ada Diskusi",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                              ),
                            ],
                          )
                          : ListView.builder(
                            itemCount: diskusiController.diskusi.length,
                            itemBuilder: (context, index) {
                              final diskusi = diskusiController.diskusi[index];
                              return Dismissible(
                                key: Key(diskusi.id.toString()),
                                direction: DismissDirection.endToStart,
                                background: Container(
                                  alignment: Alignment.centerRight,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  color: Colors.red,
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                                confirmDismiss: (direction) async {
                                  return await showDialog<bool>(
                                    context: context,
                                    builder:
                                        (context) => AlertDialog(
                                          title: const Text("Konfirmasi"),
                                          content: const Text(
                                            "Yakin ingin menghapus meeting ini?",
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed:
                                                  () => Navigator.of(
                                                    context,
                                                  ).pop(false),
                                              child: const Text("Batal"),
                                            ),
                                            TextButton(
                                              onPressed:
                                                  () => Navigator.of(
                                                    context,
                                                  ).pop(true),
                                              child: const Text("Hapus"),
                                            ),
                                          ],
                                        ),
                                  );
                                },
                                onDismissed: (direction) {
                                  courseController.deletePost(diskusi.id);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('${diskusi.title} dihapus'),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: CourseCard(
                                    title: diskusi.title,
                                    author: diskusi.content,
                                    createAt: diskusi.createdAt,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) => DiskusiDetailGuru(
                                                diskusi: diskusi,
                                              ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
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
        hintText: "Cari Diskusi",
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
