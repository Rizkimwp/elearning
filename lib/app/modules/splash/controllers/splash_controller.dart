import 'package:get/get.dart';
import 'dart:async';

import 'package:get_storage/get_storage.dart';

class SplashController extends GetxController {
  void startSplash() {
  
    Future.delayed(Duration(seconds: 6), () {
      final box = GetStorage();
      final token = box.read('jwt_token');
     
      if (token != null) {
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
    GetStorage.init();
    startSplash();
  }
}
