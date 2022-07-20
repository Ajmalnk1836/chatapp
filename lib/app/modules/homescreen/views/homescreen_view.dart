import 'package:chatapp/app/modules/authenticationscreen/controllers/authenticationscreen_controller.dart';
import 'package:chatapp/app/modules/login/views/login_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/homescreen_controller.dart';

class HomescreenView extends GetView<HomescreenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextButton(onPressed: (){
          AuthenticationscreenController.instance.logout();
          Get.offAll(Loginscreen());
        }, child: Text("Logout",style: TextStyle(color: Colors.black), )),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'HomescreenView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
