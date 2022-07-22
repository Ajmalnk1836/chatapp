import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatscreenController extends GetxController {
  //TODO: Implement ChatscreenController

dynamic argumentData = Get.arguments;

final String freindUid = Get.arguments["freind_uid"];
final String freindName =  Get.arguments["freind_name"];
final currentUSer = FirebaseAuth.instance.currentUser?.uid;
 CollectionReference chats = FirebaseFirestore.instance.collection("chats");
 var chatId;

  final count = 0.obs;
  @override
  void onInit() {
    chats
        .where("user", isEqualTo: {freindUid: null, currentUSer: null})
        .limit(1)
        .get() //feature and provide callback
        .then((QuerySnapshot querysnapshot) {
          if (querysnapshot.docs.isNotEmpty) {
            chatId = querysnapshot.docs.single.id;
          } else {
            chats.add({
              "user": {freindUid: null, currentUSer: null},
              "names": {
                currentUSer: FirebaseAuth.instance.currentUser?.displayName,
                freindUid: freindName
              }
            }).then((value) => {chatId = value});
          }
        })
        .catchError((error) {});
        

       
    super.onInit(); 
  }

  //Stream<QuerySnapshot>  readChats()=> 


void sendMessage(String message) {
    if (message.isEmpty) {
      return;
    } else {
      chats.doc(chatId).collection("messages").add({
        "createdOn":
            FieldValue.serverTimestamp(), //the value gegt form firebase
        "uid": currentUSer,
        "friendName": freindName,
        "msg": message
      }).then((value) {
        message = '';
      });
    }
  }

  bool isSender(String freind) {
    return freind == currentUSer;
  }

  Alignment getAlignment(String freind) {
    if (freind == currentUSer) {
      return Alignment.topRight;
    } else {
      return Alignment.topLeft;
    }
  }
  

  

  @override
  void onReady() {   
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
