import 'package:chatapp/app/data/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SettingsscreenController extends GetxController {
  //TODO: Implement SettingsscreenController

  final count = 0.obs;
  var currentUser = FirebaseAuth.instance.currentUser!.uid;
  @override
  void onInit() {
    super.onInit();
  }

  Stream<List<Usermodel>> readUseronly() => FirebaseFirestore.instance
      .collection("user")
      .where("uid", isEqualTo: currentUser)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Usermodel.fromJson(doc.data())).toList());

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
