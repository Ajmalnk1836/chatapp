import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_6.dart';
import 'package:get/get.dart';

class ChatScreen extends StatefulWidget {
  final String? freindUid;
  final String? freindName;
  final String? imageurl;
  final email;
  const ChatScreen(
      {Key? key, this.freindUid, this.freindName, this.email, this.imageurl})
      : super(key: key);

  @override
  State<ChatScreen> createState() =>
      _ChatScreenState(freindUid!, freindName!, email!, imageurl!);
}

class _ChatScreenState extends State<ChatScreen> {
  final sendtextController = TextEditingController();
  CollectionReference chats = FirebaseFirestore.instance.collection("chats");
  final String freindUid;
  final String freindName;
  final String? email;
  final String? imageurl;

  var chatId;

  final currentUSer = FirebaseAuth.instance.currentUser?.uid;

  _ChatScreenState(this.freindUid, this.freindName, this.email, this.imageurl);

  @override
  void initState() {
    // TODO: implement initState
    super.initState(); //gettin specefic chats

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        body: SafeArea(
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("chats")
                  .doc(chatId)
                  .collection("messages")
                  .orderBy("createdOn", descending: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                // if (snapshot.hasError) {
                //   return Center(
                //     child: Text("Error"),
                //   );
                // }

                // if (snapshot.connectionState == ConnectionState.waiting) {
                //   return Center(
                //     child: Text("Loading"),
                //   );
                // }
                // if (snapshot.hasData) {
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
                                  Get.back();
                                },
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: Colors.black,
                                )),
                            CircleAvatar(
                              backgroundImage: NetworkImage(imageurl!),
                            ),
                          ]),
                          title: Text(freindName),
                          subtitle: Text(email.toString()),
                          trailing: IconButton(
                              onPressed: () {}, icon: Icon(Icons.call)),
                        )),
                    Expanded(
                        child: ListView(
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
                          alignment: getAlignment(data['uid'].toString()),
                          margin: EdgeInsets.only(top: 20),
                          backGroundColor: isSender(data['uid'].toString())
                              ? Colors.green
                              : Colors.red,
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.7,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      data['msg'].toString(),
                                      style: TextStyle(
                                          color:
                                              isSender(data['uid'].toString())
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
                              sendMessage(sendtextController.text);
                            },
                            icon: Icon(Icons.send_sharp, color: Colors.black),
                            iconSize: 34,
                          ),
                        )),
                  ],
                );
              }

              // final users = snapshot.data!;
              // if(!snapshot.hasData){
              //   return Center(child: Text("Something went wrong"));
              // }
              ),
        ));
  }

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
        sendtextController.text = '';
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
}
