import 'package:get/get.dart';

class ChatscreenController extends GetxController {
  //TODO: Implement ChatscreenController

dynamic argumentData = Get.arguments;

  final count = 0.obs;
  @override
  void onInit() {
    // print(argumentData[0]["FRINDUID"]);
    super.onInit();
  }

  @override
  void onReady() {   
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
