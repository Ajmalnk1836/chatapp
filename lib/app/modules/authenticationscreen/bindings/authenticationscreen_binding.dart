import 'package:get/get.dart';

import '../controllers/authenticationscreen_controller.dart';

class AuthenticationscreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthenticationscreenController>(
      () => AuthenticationscreenController(),
    );
  }
}
