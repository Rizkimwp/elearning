import 'package:get/get.dart';
import 'dart:async';

class SplashController extends GetxController {

  void startSplash() {
    print("Splash screen dimulai...");
    Future.delayed(Duration(seconds: 6), () {
      print("Navigasi ke Home...");
      Get.offNamed('/intro');
    });
  }

  @override
  void onInit() {
    super.onInit();
    startSplash();
  }
}
