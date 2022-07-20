import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/bottomnavigationscreen_controller.dart';

class BottomnavigationscreenView
    extends GetView<BottomnavigationscreenController> {
  BottomnavigationscreenController controller =
      Get.put(BottomnavigationscreenController());      
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          //SafeArea(child: Text("dfcs")),
          GetBuilder<BottomnavigationscreenController>(builder: (context) {
        return controller.screens[controller.tabindex];
      }),
      //Text("sdax");

      bottomNavigationBar: GetBuilder<BottomnavigationscreenController>(
        builder: (context) {
          return BottomNavigationBar(
              onTap: ((value) => controller.ontap(value)),
              currentIndex: controller.tabindex,
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.grey,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.message ),
                  label: 'Chats',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.call),
                  label: 'Call', 
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.people ),
                  label: 'Peoples ',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',  
                ),
              ]);
        }
      ),
    );
  }
}
