import 'package:get/get.dart';

import '../controllers/peopelesscreen_controller.dart';

class PeopelesscreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PeopelesscreenController>(
      () => PeopelesscreenController(),
    );
  }
}
