import 'package:chatapp/app/modules/authenticationscreen/controllers/authenticationscreen_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp()
   .then((value) => Get.put(AuthenticationscreenController()));

  runApp(
    GetMaterialApp( 
      title: "Application",
      debugShowCheckedModeBanner: false, 
      initialRoute: AppPages.INITIAL,      
      getPages: AppPages.routes,
    ),
  );    
}       
  