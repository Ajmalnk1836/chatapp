import 'package:chatapp/app/data/models/user.dart';
import 'package:chatapp/app/modules/authenticationscreen/controllers/authenticationscreen_controller.dart';
import 'package:chatapp/app/modules/chatscreen/views/chatscreen_view.dart';
import 'package:chatapp/app/modules/peopelesscreen/views/widgets/searchsection.dart';
import 'package:chatapp/app/modules/searchscreen/views/searchscreen_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/peopelesscreen_controller.dart';

class PeopelesscreenView extends GetView<PeopelesscreenController> {
  var currentUser = FirebaseAuth.instance.currentUser!.uid;

  PeopelesscreenController controller = Get.put(PeopelesscreenController());
  bool iconPressed = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Peoples",
          style: GoogleFonts.montserrat(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: MysearchDelegate());
              },
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ))
        ],
      ),
      body: SafeArea(
        child:
            // Visibility(visible: controller.iconPressed, child: Text("dscsd"))
            StreamBuilder<List<Usermodel>>(
                stream: controller.readUsers(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    final users = snapshot.data!;
                    return ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (BuildContext context, index) {
                          //final userses = users[index];
                          String imageurl = users[index].image!;
                          return Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 222, 219, 219),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                // child:imageurl ==  null
                                // ? Text("dcsd")
                                // :
                                backgroundImage: NetworkImage(imageurl),

                                //Image.network(imageurl),
                              ),
                              title: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(users[index].uname!),
                              ),
                              subtitle: Text(users[index].email!),
                              trailing: IconButton(
                                  onPressed: () {
                                    Get.to(() => ChatscreenView(), arguments: {
                                      "freind_name": users[index].uname,
                                      "freind_uid": users[index].uid,
                                      "email": users[index].email,
                                      "image": imageurl
                                    });
                                  },
                                  icon: Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: Colors.black,
                                  )),
                            ),
                          );
                        });
                  }
                }), 
      ),
    );
  }
}

// class mysearchDelegate extends SearchDelegate {
//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [
//       IconButton(
//         onPressed: () {
//           query = '';
//         },
//         icon: Icon(Icons.clear),
//       ),   
//     ];  
//   }

//   @override
//   Widget? buildLeading(BuildContext context) {
//     return IconButton(
//       onPressed: () {
//         close(context, null);
//       },
//       icon: Icon(Icons.arrow_back),
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//    return Text("csd");
//   }     

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     // TODO: implement buildSuggestions
//     throw UnimplementedError();
//   }
// }