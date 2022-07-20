

import 'package:chatapp/app/data/models/user.dart';
import 'package:chatapp/app/modules/chatscreen/views/chatscreen_view.dart';
import 'package:chatapp/app/modules/peopelesscreen/views/widgets/chatscreen.dart';
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
        title:
            // controller.iconPressed == true
            //     ?
            //      Container(
            //         height: 35,
            //         width: double.infinity,
            //         decoration: BoxDecoration(
            //           color: Colors.grey.withOpacity(0.25),
            //           borderRadius: BorderRadius.circular(15),
            //         ),
            //         child: TextField(
            //           decoration: InputDecoration(
            //               border: InputBorder.none,
            //               hintText: "Search",
            //               prefixIcon: Icon(Icons.search)),
            //         ),
            //       )
            //     :
            Text(
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
                //  controller.showSearch();
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
                          String imageurl =users[index].image!;
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
                                    // Get.to(() => ChatScreen(
                                    //       freindName: users[index].uname,
                                    //       freindUid: users[index].uid,
                                    //       email: users[index].email,
                                    //       imageurl: imageurl ,
                                    //     ),);
                                    Get.to(ChatscreenView(),arguments: {
                                      "freind_name" : users[index].uname,
                                      
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
