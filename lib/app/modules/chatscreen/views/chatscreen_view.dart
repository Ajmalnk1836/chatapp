import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/chatscreen_controller.dart';

class ChatscreenView extends GetView<ChatscreenController> {
  // final String? freindUid;
  // final String? freindName;
  // final String? imageurl;
  // final email;

  // ChatscreenView(this.freindUid, this.freindName, this.imageurl, this.email);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ChatscreenView'),
        centerTitle: true,
      ),
      body: Center( 
        child: Text(
          "${Get.arguments["freind_name"]}",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
