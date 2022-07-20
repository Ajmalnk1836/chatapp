import 'package:chatapp/app/data/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class PeopelesscreenController extends GetxController {
  //TODO: Implement PeopelesscreenController
  var currentUser = FirebaseAuth.instance.currentUser!.uid;
  Stream<List<Usermodel>> readUsers() => FirebaseFirestore.instance
      .collection("user")
      .where("uid", isNotEqualTo: currentUser)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Usermodel.fromJson(doc.data())).toList());
  bool iconPressed = false;
  void showSearch() { 
    iconPressed =  !iconPressed     ;     
    print(iconPressed);
    update();   
  }

  final count = 0.obs;
  @override
  void onInit() {
    showSearch();
    super.onInit();
  }  

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
