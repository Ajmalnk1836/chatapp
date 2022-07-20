import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/authenticationscreen_controller.dart';

class AuthenticationscreenView extends GetView<AuthenticationscreenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AuthenticationscreenView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'AuthenticationscreenView is working',
          style: TextStyle(fontSize: 20),  
        ),
      ),
    );
  }
}
