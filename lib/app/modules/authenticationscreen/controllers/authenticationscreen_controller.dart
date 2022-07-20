import 'dart:io';
import 'package:chatapp/app/data/models/user.dart';
import 'package:chatapp/app/modules/bottomnavigationscreen/views/bottomnavigationscreen_view.dart';
import 'package:chatapp/app/modules/login/views/login_view.dart';
import 'package:chatapp/app/modules/registerscreen/controllers/registerscreen_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AuthenticationscreenController extends GetxController {
  //TODO: Implement AuthenticationscreenController

  RegisterscreenController controller = Get.put(RegisterscreenController());
  static AuthenticationscreenController instance = Get.find();
  late Rx<User?> _user;

  FirebaseAuth auth = FirebaseAuth.instance;

  File? imageFile;
  String? downloadUrl;
@override
  void onInit() {
    waiting();
   
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());

    ever(_user, _initailscreen);
  }

  void _initailscreen(User? user) {
    user == null
        ? Get.offAll(Loginscreen())
        : Get.offAll(BottomnavigationscreenView());
  }

  void login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      Get.snackbar("About Login", "Login message",
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            "Login failed ",
            style: TextStyle(color: Colors.white),
          ),
          messageText: Text(
            e.toString(),
            style: TextStyle(color: Colors.white),
          ));
    }
  }

  Future uploaDImage() async {
    final postId = DateTime.now().microsecondsSinceEpoch.toString();
    final userId = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore firebasefirestore = FirebaseFirestore.instance;

    Reference ref = FirebaseStorage.instance
        .ref()
        .child("${userId}dpImages")
        .child("post$postId");
    await ref.putFile(imageFile!);
    downloadUrl = await ref.getDownloadURL();
    print(downloadUrl);
  }

  Future selectImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    imageFile = File(pickedImage!.path);
    print(imageFile);

    update();
  }

  Future selectGallery() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    imageFile = File(pickedImage!.path);
    print(imageFile);

    update();
  }

  void register(String email, String password, String username) async {
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user!;
      await uploaDImage();
      final docUSer = FirebaseFirestore.instance.collection("user").doc();
      final usermodel = Usermodel(
          uid: user.uid, email: email, uname: username, image: downloadUrl);
      final json = usermodel.toJson();
      await docUSer.set(json);

      Get.snackbar("Suucessfull", "congrats",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green);
      Get.off(BottomnavigationscreenView());
    } catch (e) {
      Get.snackbar("About user", "Not matcthed",
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            "Account creation failed",
            style: TextStyle(color: Colors.white),
          ),
          messageText: Text(
            e.toString(),
            style: TextStyle(color: Colors.white),
          ));
    }
  }

  void logout() async {
    await auth.signOut();
  }
 waiting()   async{
  final time =  await Future.delayed(Duration(seconds: 5));
 }
 final count = 0.obs;
  

  @override
  void onClose() {}
  void increment() => count.value++;
}
