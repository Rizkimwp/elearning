import 'package:elearning/app/modules/account/views/account_guru.dart';
import 'package:elearning/app/modules/account/views/account_view.dart';
import 'package:elearning/app/modules/course/views/course_guru.dart';
import 'package:elearning/app/modules/course/views/course_view.dart';
import 'package:elearning/app/modules/home/views/home_view.dart';
import 'package:elearning/app/modules/home/views/home_view_guru.dart';
import 'package:elearning/app/modules/message/views/message_guru.dart';
import 'package:elearning/app/modules/message/views/message_view.dart';
import 'package:elearning/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class BottomNavController extends GetxController {
  var selectedIndex = 0.obs;

  final box = GetStorage();
  late String role;

  final List<Widget> guruPages = [
    HomeGuruView(),
    CourseGuruView(),
    MessageGuruView(),
    AccountGuruView(),
  ];

  final List<Widget> siswaPages = [
    HomeView(),
    CourseView(),
    MessageView(),
    AccountView(),
  ];

  List<Widget> get activePages => role == 'guru' ? guruPages : siswaPages;

  Widget get currentPage => activePages[selectedIndex.value];

  @override
  void onInit() {
    super.onInit();
    _initRole();
  }

  void _initRole() {
    String token = box.read('jwt_token') ?? '';

    if (token.isNotEmpty && JwtDecoder.isExpired(token) == false) {
      Map<String, dynamic> decoded = JwtDecoder.decode(token);
      role = decoded['role'] ?? 'siswa'; // default to 'siswa' if null
      Get.log('Role ditemukan: $role');
    } else {
      role = 'siswa';
      Get.log('Token tidak valid atau kosong, default ke siswa');
    }
  }

  void changePage(int index) {
    selectedIndex.value = index;
  }
}
