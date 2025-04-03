import 'package:get/get.dart';

import '../controllers/modules_intro_controller.dart';

class ModulesIntroBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ModulesIntroController>(
      () => ModulesIntroController(),
    );
  }
}
