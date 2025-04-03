import 'package:elearning/app/modules/account/views/account_view.dart';
import 'package:elearning/app/modules/course/views/course_view.dart';
import 'package:elearning/app/modules/home/views/home_view.dart';
import 'package:elearning/app/modules/message/views/message_view.dart';
import 'package:elearning/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavController extends GetxController {
  var selectedIndex = 0.obs;
  final List<Widget> pageRoutes = [
    HomeView(),
    CourseView(),
    MessageView(),
    AccountView()
  ];

  late Widget currentPage;

  @override
  void onInit() {
    super.onInit();
    currentPage = pageRoutes[selectedIndex.value];
    ever(selectedIndex, (index) {
      currentPage = pageRoutes[index as int];
      update(); // Notify listeners to rebuild
    });
  }

  void changePage(int index) {
    selectedIndex.value = index;
  }
}
