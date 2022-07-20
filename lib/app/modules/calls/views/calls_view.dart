import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/calls_controller.dart';

class CallsView extends GetView<CallsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CallsView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'CallsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
