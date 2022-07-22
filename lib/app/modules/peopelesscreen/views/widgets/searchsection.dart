
import 'package:chatapp/app/modules/chatscreen/views/chatscreen_view.dart';
import 'package:chatapp/app/modules/peopelesscreen/controllers/peopelesscreen_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class MysearchDelegate extends SearchDelegate {
  PeopelesscreenController controller = Get.put(PeopelesscreenController());
  CollectionReference collection =
      FirebaseFirestore.instance.collection("user"); 

  @override
  List<Widget>? buildActions(BuildContext context) {  
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: collection.snapshots().asBroadcastStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.data!.docs
                .where((QueryDocumentSnapshot<Object?> element) =>
                    element["user_name"]
                        .toString()
                        .toLowerCase()
                        .contains(query.toLowerCase()))
                .isEmpty) {
              return Center(
                child: Text("No search query found"),
              );
            } else {
              return ListView(
                children: [
                  ...snapshot.data!.docs
                      .where((QueryDocumentSnapshot<Object?> element) =>
                          element["user_name"]
                              .toString()
                              .toLowerCase()
                              .contains(query.toLowerCase()))
                      .map((QueryDocumentSnapshot<Object?> data) {
                    final String title = data.get("user_name");
                    final String email = data["email"];
                    final String image = data["image"];
                    return ListTile(
                      onTap: () {
                        Get.to(() => ChatscreenView(), arguments: {
                          "freind_name": data["user_name"],
                          "freind_uid": data["uid"],
                          "email": data["email"],
                          "image": data["image"]
                        });
                      },
                      leading:
                          CircleAvatar(backgroundImage: NetworkImage(image)),
                      title: Text(title),
                      subtitle: Text(email),
                    );
                  })
                ],
              );
            }
          }
        });
    // return StreamBuilder<List<Usermodel>>(
    //             stream: controller.readUsers(),
    //             builder: (context, snapshot) {
    //               if (!snapshot.hasData) {
    //                 return Center(child: CircularProgressIndicator());
    //               } else {

    //                 final users = snapshot.data!;
    //                 return ListView.builder(
    //                     itemCount: users.length,
    //                     itemBuilder: (BuildContext context, index) {
    //                       //final userses = users[index];
    //                       String imageurl = users[index].image!;
    //                       return Container(
    //                         decoration: BoxDecoration(
    //                           color: Color.fromARGB(255, 222, 219, 219),
    //                           borderRadius: BorderRadius.circular(10),
    //                         ),
    //                         child: ListTile(
    //                           leading: CircleAvatar(
    //                             // child:imageurl ==  null
    //                             // ? Text("dcsd")
    //                             // :
    //                             backgroundImage: NetworkImage(imageurl),

    //                             //Image.network(imageurl),
    //                           ),
    //                           title: Padding(
    //                             padding: const EdgeInsets.all(8.0),
    //                             child: Text(users[index].uname!),
    //                           ),
    //                           subtitle: Text(users[index].email!),
    //                           trailing: IconButton(
    //                               onPressed: () {
    //                                 Get.to(() => ChatscreenView(), arguments: {
    //                                   "freind_name": users[index].uname,
    //                                   "freind_uid": users[index].uid,
    //                                   "email": users[index].email,
    //                                   "image": imageurl
    //                                 });
    //                               },
    //                               icon: Icon(
    //                                 Icons.arrow_forward_ios_outlined,
    //                                 color: Colors.black,
    //                               )),
    //                         ),
    //                       );
    //                     });
    //               }
    //             });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: collection.snapshots().asBroadcastStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.data!.docs
                .where((QueryDocumentSnapshot<Object?> element) =>
                    element["user_name"]
                        .toString()
                        .toLowerCase()
                        .contains(query.toLowerCase()))
                .isEmpty) {
              return Center(
                child: Text("No search query found"),
              );
            } else {
              return ListView(
                children: [
                  ...snapshot.data!.docs
                      .where((QueryDocumentSnapshot<Object?> element) =>
                          element["user_name"]
                              .toString()
                              .toLowerCase()
                              .contains(query.toLowerCase()))
                      .map((QueryDocumentSnapshot<Object?> data) {
                    final String title = data.get("user_name");
                    final String email = data["email"];
                    final String image = data["image"];
                    return ListTile(
                      onTap: () {
                        Get.to(() => ChatscreenView(), arguments: {
                          "freind_name": data["user_name"],
                          "freind_uid": data["uid"],
                          "email": data["email"],
                          "image": data["image"]
                        });
                      },
                      leading:
                          CircleAvatar(backgroundImage: NetworkImage(image)),
                      title: Text(title),
                      subtitle: Text(email),
                    );
                  })
                ],
              );
            }
          }
        });

    // List<String> matchQuery = [];
    // for (var fruit in searchTerms) {
    //   if (fruit.toLowerCase().contains(query.toLowerCase())) {
    //     matchQuery.add(fruit);
    //   }
    // }
    // return ListView.builder(
    //   itemCount: matchQuery.length,
    //   itemBuilder: (context, index) {
    //     var result = matchQuery[index];
    //     return ListTile(
    //       title: Text(result),
    //     );
    //   },
    // );
  }
}