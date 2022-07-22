import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_6.dart';
import 'package:get/get.dart';
import '../controllers/chatscreen_controller.dart';

class ChatscreenView extends GetView<ChatscreenController> {
  ChatscreenController controller = Get.put(ChatscreenController());
 
  @override
  Widget build(BuildContext context) {
     final width =  MediaQuery.of(context).size.width ;
    final sendtextController = TextEditingController();

    return Scaffold(
        backgroundColor: Colors.grey,
        body: SafeArea(
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("chats")
                  .doc(controller.chatId)
                  .collection("messages")
                  .orderBy("createdOn", descending: true) 
                  .snapshots(),
              builder: (BuildContext context, 
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                return Column(
                  children: [ 
                    Container(
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: ListTile(
                          leading: Wrap(children: [
                            IconButton(
                                onPressed: () {
                                  print(Text(
                                      "freind uid == ${Get.arguments["freind_uid"]}"));
                                  print(Text(
                                      "freind name == ${Get.arguments["freind_name"]}"));
                                  Get.back();
                                },
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: Colors.black,
                                )),
                            CircleAvatar(
                              backgroundImage:
                                  NetworkImage(Get.arguments["image"]),
                            ),
                          ]),
                          title: Text(Get.arguments["freind_name"]),
                          subtitle: Text(Get.arguments["email"]),
                          trailing: IconButton(
                              onPressed: () {}, icon: Icon(Icons.call)),
                        )),
                    Expanded(
                        child: GetBuilder<ChatscreenController>(
                          builder: (context) { 
                            return ListView(
                      reverse: true,
                      children: snapshot.data!.docs.map((
                            DocumentSnapshot document,
                      ) {
                            Map<String, dynamic> data =
                                document.data() as Map<String, dynamic>;
                            // var data = document['uid'];
                            // var msg = document['msg'];
                            return ChatBubble(
                              clipper: ChatBubbleClipper6(
                                  nipSize: 0,
                                  radius: 0,
                                  type: BubbleType.receiverBubble),
                              alignment:
                                  controller.getAlignment(data['uid'].toString()),
                              margin: EdgeInsets.only(top: 20),
                              backGroundColor:
                                  controller.isSender(data['uid'].toString())
                                      ? Colors.green      
                                      : Colors.red,   
                              child: Container(
                                constraints: BoxConstraints(
                                  maxWidth: width * 0.7,  
                                ),
                                child: Column(
                                  children: [
                                    Row( 
                                      mainAxisAlignment: MainAxisAlignment.start,       
                                      children: [
                                        Text(
                                          data['msg'].toString(),
                                          style: TextStyle(
                                              color: controller.isSender(
                                                      data['uid'].toString())
                                                  ? Colors.white
                                                  : Colors.black),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                      }).toList(),
                    );
                          }
                        )),
                    Container(
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: ListTile(
                          leading: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.add),
                            iconSize: 34,
                          ),
                          title: Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey,
                            ),
                            child: TextField(
                                controller: sendtextController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "  Type Anything")),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              controller.sendMessage(sendtextController.text);
                            },
                            icon: Icon(Icons.send_sharp, color: Colors.black),
                            iconSize: 34,
                          ),
                        )),
                  ],
                );
              }
              ),
        ));
  }
}
