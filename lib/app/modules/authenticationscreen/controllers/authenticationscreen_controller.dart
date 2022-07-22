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
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

class AuthenticationscreenController extends GetxController {
  //TODO: Implement AuthenticationscreenController

  RegisterscreenController controller = Get.put(RegisterscreenController());
  static AuthenticationscreenController instance = Get.find();
  late Rx<User?> _user;

  FirebaseAuth auth = FirebaseAuth.instance;
  GoogleSignIn googleSign = GoogleSignIn(scopes: ['email']);

  File? imageFile;
  String? downloadUrl;
  @override
  void onInit() {
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
      final docUser = FirebaseFirestore.instance.collection("user").doc();
      await uploaDImage();

      final usermodel = Usermodel(
          id: docUser.id,
          uid: user.uid,
          email: email,
          uname: username,
          image: downloadUrl);
      final json = usermodel.toJson();
      await docUser.set(json); 

      Get.snackbar("Suucessfull", "congrats",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green);
      Get.off(BottomnavigationscreenView());
      downloadUrl = '';

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

  void sendPasswrodReset(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email).then((value) => {
            Get.offAll(Loginscreen()),
            Get.snackbar("Password reset email link is been sent", "Success")
          });
    } catch (e) {
      print(e);
      Get.snackbar(e.toString(), "Youe enterd mail is error");
    }
  }

  void logout() async {
    await auth.signOut();
  }

  void googleSigning() async {
    final GoogleSignInAccount? googleuser = await googleSign.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleuser!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );
    final User? users = await auth
        .signInWithCredential(credential)
        .then((value) => Get.offAll(BottomnavigationscreenView()));
  }

  void googleSignout() async {
    await googleSign.signOut();
  }

  final count = 0.obs;

  @override
  void onClose() {}
  void increment() => count.value++;
}
