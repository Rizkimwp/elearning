import 'package:elearning/app/modules/bottom_nav/views/bottom_nav_view.dart';
import 'package:elearning/app/modules/splash/views/splash_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      home: const BottomNavView(), // Added const for better performance if BottomNavView is immutable
    ),
  );
}
