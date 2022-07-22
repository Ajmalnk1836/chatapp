import 'package:chatapp/app/modules/authenticationscreen/controllers/authenticationscreen_controller.dart';
import 'package:chatapp/app/modules/settingsscreen/views/widgets/editsection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/settingsscreen_controller.dart';

class SettingsscreenView extends GetView<SettingsscreenController> {
  final userName = FirebaseAuth.instance.currentUser!.email;
  SettingsscreenController controller = Get.put(SettingsscreenController());
  final editcontroller = TextEditingController();
  var currentUser = FirebaseAuth.instance.currentUser!.uid;
  final docUser = FirebaseFirestore.instance.collection("user").doc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 225, 221, 221),
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: Center(
            child: Text(
              "Profile",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        body: SafeArea(
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("user")
                    .where("uid", isEqualTo: currentUser)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    final user = snapshot.data!;

                    return Column(
                      children: snapshot.data!.docs.map((
                        DocumentSnapshot document,
                      ) {
                        Map<String, dynamic> data =
                            document.data() as Map<String, dynamic>;
                        return Column(
                          children: [
                            Stack(
                              children: [
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Center(
                                      child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.3,
                                          child: CircleAvatar(
                                              backgroundImage: data["image"] ==
                                                      null
                                                  ? NetworkImage(
                                                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQHshd2QQVfiwJcguEhHZxR0VioUAjdvsvK9ktsUxm9u5SYV-OVYu4NfS3spIrCxXawnKU&usqp=CAU")
                                                  : NetworkImage(
                                                      data["image"]))),
                                    ),
                                  ],
                                ),
                                Positioned(
                                  top: 160,
                                  left: 120,
                                  child: Container(
                                    height: MediaQuery.of(context).size.width *
                                        0.11,
                                    width: MediaQuery.of(context).size.height *
                                        0.33,
                                    child: CircleAvatar(
                                      backgroundColor:
                                          Color.fromARGB(255, 2, 147, 91),
                                      child: IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.camera_alt,
                                            color: Colors.white,
                                          )),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            ListTile(
                              leading: Icon(Icons.person),
                              title: Text("Name"),
                              subtitle: Text(data['user_name'].toString()),
                              trailing: IconButton(
                                  onPressed: () {
                                    Get.bottomSheet(
                                      EditSection(  
                                          name: data['user_name'].toString(),
                                          id: data['id'].toString()),
                                      backgroundColor: Colors.white,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    );
                                    //  Editsection();
                                    //openBottomsheet();
                                  },
                                  icon: Icon(Icons.edit)),
                            ),
                            ListTile(
                              leading: Icon(Icons.phone),
                              title: Text("Phone"),
                              subtitle: Text("+91 8594081836"),
                              trailing: IconButton(
                                  onPressed: () {}, icon: Icon(Icons.edit)),
                            ),
                            ListTile(
                              leading: Icon(Icons.email),
                              title: Text("email"),
                              subtitle: Text(data["email"].toString()),
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: TextButton.icon(
                                    onPressed: () {
                                      AuthenticationscreenController.instance
                                          .logout(); 
                                    },
                                    icon: Icon(
                                      Icons.logout,
                                      color: Colors.white,
                                    ),
                                    label: Text(
                                      "Log out",
                                      style: TextStyle(color: Colors.white),
                                    )))
                          ],
                        );
                      }).toList(),

                      // ],
                    );
                  }
                })));
  }
}


 
// class Editsection extends StatelessWidget {
//   const Editsection({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Get,
//     );
//   }
// }
