import 'package:chatapp/app/modules/authenticationscreen/controllers/authenticationscreen_controller.dart';
import 'package:chatapp/app/modules/registerscreen/views/registerscreen_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/home_controller.dart';

class Loginscreen extends GetView<HomeController> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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
            SizedBox(
              height: 90,
            ),
            Center(
              child: Container(
                //color: Colors.red,
                height: height * 0.2,
                width: width * 0.5,
                child: Icon(
                  Icons.message,
                  color: Color.fromARGB(255, 4, 88, 156),
                  size: 120,
                ),
              ),
            ),
            Text("Chatter",
                style: GoogleFonts.montserrat(
                    fontSize: 30, fontWeight: FontWeight.w400)),
            SizedBox(
              height: 7,
            ),
            Text(
              "WORLD MOST SECURE CHAT APP ",
              style: GoogleFonts.montserrat(
                color: Color.fromARGB(255, 20, 107, 178),
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.83,
              height: 60,
              child: TextFormField(
                controller: emailcontroller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    filled: true,
                    hintText: "Email",
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
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
              width: MediaQuery.of(context).size.width * 0.83,
              height: 60,
              child: TextFormField(
                controller: passwordcontroller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    filled: true,
                    hintText: "Password",
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.black,
                    ),
                    fillColor: Colors.white),
                obscureText: true,
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
                height: 44,
                width: width * 0.7,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 6, 64, 111),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        AuthenticationscreenController.instance.login(
                            emailcontroller.text.trim(),
                            passwordcontroller.text.trim());
                      }
                    },
                    child: Text("Login"))),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("you don't have an account ? "),
                TextButton(
                    onPressed: () {
                      Get.to(RegisterscreenView());
                    },
                    child: Text("Click Here "))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 1.0,
                  width: 110.0,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 5,
                ),
                Text("OR"),
                SizedBox(
                  width: 5,
                ),
                Container(
                  height: 1.0,
                  width: 110.0,
                  color: Colors.black,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                height: 45,
                width: width * 0.7,
                decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.apple,
                      color: Colors.white,
                    ),
                    label: Text(
                      "Sign with apple",
                      style: TextStyle(color: Colors.white),
                    )))
          ],
        ),
      ),
    )));
  }
}
