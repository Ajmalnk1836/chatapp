import 'package:chatapp/app/modules/authenticationscreen/controllers/authenticationscreen_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/forgotpassword_controller.dart';

class ForgotpasswordView extends GetView<ForgotpasswordController> {
  final forgotpassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Center(
              child: Container(
                //color: Colors.red,
                height: height * 0.2,
                width: width * 0.3,
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
                controller: forgotpassword,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    filled: true,
                    hintText: "Email",
                    prefixIcon: Icon(
                      Icons.mail,
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
                height: 44,
                width: width * 0.7,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 6, 64, 111),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        AuthenticationscreenController.instance
                            .sendPasswrodReset(forgotpassword.text);
                      }
                    },
                    child: Text("Reset Password"))),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    )));
  }
}
