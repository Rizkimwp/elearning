import 'package:elearning/app/components/custom_appbar.dart';
import 'package:elearning/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/course_controller.dart';

class CourseView extends GetView<CourseController> {
  const CourseView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
   appBar: CustomAppBar(
        showAvatar: true,
        onAvatarTap: () => Get.toNamed(Routes.ACCOUNT),
      ),
      body: const Center(
        child: Text(
          'CourseView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
