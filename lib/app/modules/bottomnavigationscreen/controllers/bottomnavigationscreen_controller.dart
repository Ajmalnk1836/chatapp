import 'package:chatapp/app/modules/calls/views/calls_view.dart';
import 'package:chatapp/app/modules/homescreen/views/homescreen_view.dart';
import 'package:chatapp/app/modules/peopelesscreen/views/peopelesscreen_view.dart';
import 'package:chatapp/app/modules/settingsscreen/views/settingsscreen_view.dart';
import 'package:get/get.dart';

class BottomnavigationscreenController extends GetxController {
  //TODO: Implement BottomnavigationscreenController
int tabindex = 0;
final List screens = [
  HomescreenView(),
  CallsView(),
  PeopelesscreenView(),
  SettingsscreenView()

];

void ontap(int value){
  tabindex = value;
  update();
}

  final count = 0.obs;
  @override
  void onInit() {
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
