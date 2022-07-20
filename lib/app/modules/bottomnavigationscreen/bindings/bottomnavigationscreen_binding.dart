import 'package:get/get.dart';

import '../controllers/bottomnavigationscreen_controller.dart';

class BottomnavigationscreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomnavigationscreenController>(
      () => BottomnavigationscreenController(),
    );
  }
}
