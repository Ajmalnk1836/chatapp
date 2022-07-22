import 'package:chatapp/app/modules/settingsscreen/controllers/settingsscreen_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class EditSection extends StatelessWidget {
  final String? name;
  final String? id;
  EditSection({Key? key, this.name, this.id}) : super(key: key);
  final editCOntroller = TextEditingController();
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final docUse = FirebaseFirestore.instance.collection("user").doc();
  SettingsscreenController controller = Get.put(SettingsscreenController());

  @override
  Widget build(BuildContext context) {
    editCOntroller.text = name.toString();

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Center(
            child: Text(
              'Name',
              style: TextStyle(fontSize: 18),
            ),
          ),
          TextFormField(
            controller: editCOntroller,
            decoration: InputDecoration(border: OutlineInputBorder()),
          ),
          OutlinedButton(
            onPressed: () {
              final docUser =
                  FirebaseFirestore.instance.collection("user").doc(id);

              docUser.update({"user_name": editCOntroller.text});
              // controller.updatedata(editCOntroller.text, uid);

              print(id);
              Get.back();
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }
}