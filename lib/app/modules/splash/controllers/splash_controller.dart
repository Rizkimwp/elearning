import 'package:elearning/utils/auth_helper.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:get_storage/get_storage.dart';

class SplashController extends GetxController {
  void startSplash() {
  
    Future.delayed(Duration(seconds: 6), () {
      
      
     
      if (AuthHelper.isLoggedIn) {
        // Jika token ada, arahkan ke halaman utama
        print("Navigasi ke Home...");
        Get.offNamed('/bottom-nav');
      } else {
        print("Navigasi ke Home...");
        Get.offNamed('/intro');
      }
    });
  }

  @override
  void onInit() {
    super.onInit();
    startSplash();
  }
}
