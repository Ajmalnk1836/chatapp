import 'package:get/get.dart';

import '../controllers/settingsscreen_controller.dart';

class SettingsscreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsscreenController>(
      () => SettingsscreenController(),
    );
  }
}
