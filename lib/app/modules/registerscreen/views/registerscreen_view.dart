import 'package:chatapp/app/modules/authenticationscreen/controllers/authenticationscreen_controller.dart';
import 'package:chatapp/app/modules/login/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/registerscreen_controller.dart';

class RegisterscreenView extends GetView<RegisterscreenController> {
  final usernamecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  RegisterscreenController controller = Get.put(RegisterscreenController());
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  color: Colors.black,
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
            ),
            Center(
              child: Container(
                //color: Colors.red,
                height: height * 0.1,
                width: width * 0.5,
                child: Icon(
                  Icons.message,
                  color: Color.fromARGB(255, 4, 88, 156),
                  size: 120,
                ),
              ),
            ),
            SizedBox(height: 30,),
            Text("Chatter",
                style: GoogleFonts.montserrat(
                    fontSize: 30, fontWeight: FontWeight.w400)),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AuthenticationscreenController.instance.imageFile ==  null
                ?
                CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage("https://www.w3schools.com/howto/img_avatar.png")

                ):
                CircleAvatar(

                  radius: 60,  
                  // backgroundImage:AuthenticationscreenController.instance.imageFile == null? NetworkImage("https://www.w3schools.com/howto/img_avatar.png")
                  // : Image.file(file),
                  
                  child: Image.file(
                          AuthenticationscreenController.instance.imageFile!,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                ),
              
                IconButton(
                    onPressed: () {
                      Get.defaultDialog(
                        title: "",
                        content: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Camera"),
                                SizedBox(
                                  width: 10,
                                ),
                                IconButton(
                                    onPressed: () {
                                      AuthenticationscreenController.instance
                                          .selectImage();
                                    },
                                    icon: Icon(
                                      Icons.camera,
                                      color: Colors.black,
                                    ))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Gallery"),
                                SizedBox(
                                  width: 10,
                                ),
                                IconButton(
                                    onPressed: () {
                                      AuthenticationscreenController.instance
                                          .selectGallery();
                                    },
                                    icon: Icon(
                                      Icons.photo,
                                      color: Colors.black,
                                    ))
                              ],
                            )
                          ],   
                        ),
                      );
                      // AuthenticationscreenController.instance.selectImage();
                    },
                    icon: Icon(Icons.add))
              ],
            ),
              SizedBox(height: 10,), 
            Container(
              height: 50,
              width: width * 0.8,
              child: TextFormField(
                controller: usernamecontroller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    filled: true,
                    label: Text(
                      "Username",
                    ),
                    prefixIcon: Icon(Icons.person),
                    prefixIconColor: Colors.red,
                    fillColor: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              width: width * 0.8,
              child: TextFormField(
                controller: emailcontroller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    filled: true,
                    label: Text(
                      "Email",
                    ),
                    prefixIcon: Icon(Icons.email),
                    prefixIconColor: Colors.red,
                    fillColor: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              width: width * 0.8,
              child: TextFormField(
                controller: passwordcontroller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    filled: true,
                    label: Text(
                      "Password",
                    ),
                    prefixIcon: Icon(Icons.lock),
                    prefixIconColor: Colors.red,
                    fillColor: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                height: 50,
                width: width * 0.7,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        AuthenticationscreenController.instance.register(
                            emailcontroller.text.trim(),
                            passwordcontroller.text.trim(),
                            usernamecontroller.text.trim());
                      }
                    },
                    child: Text(
                      "REGISTER ",
                      style: TextStyle(color: Colors.white),
                    ))),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 1,
                  width: width * 0.3,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 10,
                ),
                Text("OR"),
                SizedBox(
                  width: 10,
                ),
                Container(
                  height: 1,
                  width: width * 0.3,
                  color: Colors.black,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                height: 50,
                width: width * 0.7,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.apple,
                      color: Colors.white,
                    ),
                    label: Text(
                      "Login with Apple",
                      style: TextStyle(color: Colors.white),
                    ))),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("You are already login ?"),
                TextButton(
                    onPressed: () {
                      Get.offAll(Loginscreen());
                    },
                    child: Text("Click here"))
              ],
            )
          ],
        ),
      ),
    )));
  }
}
