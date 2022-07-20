import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RegisterscreenController extends GetxController {
  //TODO: Implement RegisterscreenController

  // File? imageFile;
  // String? downloadUrl;
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    
  }

  // Future uploaDImage() async {
  //   final postId = DateTime.now().microsecondsSinceEpoch.toString();
  //   final userId = FirebaseAuth.instance.currentUser!.uid;
  //   FirebaseFirestore firebasefirestore = FirebaseFirestore.instance;

  //   Reference ref = FirebaseStorage.instance
  //       .ref()
  //       .child("${userId}/ dpImages")
  //       .child("post$postId");
  //   await ref.putFile(imageFile!);
  //   downloadUrl = await ref.getDownloadURL();
  //   print(downloadUrl);
  // }

  // Future selectImage() async {
  //   final pickedImage =
  //       await ImagePicker().pickImage(source: ImageSource.camera);

  //   imageFile = File(pickedImage!.path);
  //   print(imageFile);

  //   update();
  // }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
