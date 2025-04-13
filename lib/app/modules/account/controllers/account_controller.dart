import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AccountController extends GetxController {
  void logout() async {
    final box = GetStorage();

    // Menghapus token dari GetStorage
    await box.remove('jwt_token');

    // Pastikan navigasi terjadi setelah token dihapus
    Future.delayed(Duration(milliseconds: 100), () {
      Get.offAllNamed('/auth');
    });
  }
}
