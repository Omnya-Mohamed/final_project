//import 'dart:html';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:g_project/widget/fields.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class Changepassword extends StatefulWidget {
  const Changepassword({Key? key}) : super(key: key);

  @override
  State<Changepassword> createState() => _ChangepasswordState();
}

class _ChangepasswordState extends State<Changepassword> {
  bool passvisible = false;
  bool passvisible1 = false;
  bool passvisible2 = false;
  var oldpasswordcontroler = TextEditingController();
  var newpasswordcontroler = TextEditingController();
  var confirmpasswordcontroler = TextEditingController();
  var password;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text(
          'Change password',
        ),
        backgroundColor: m_color,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              const SizedBox(height: 30),
              Form(
                child: Column(
                  children: [
                    defultTextFied(
                      hint: "Enter Password",
                      label: "Password",
                      type: TextInputType.visiblePassword,
                      pIcon: Icon(Icons.lock, color: Colors.purple.shade100),
                      sIcon: IconButton(
                        icon: Icon(
                          passvisible ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            passvisible = !passvisible;
                          });
                        },
                      ),
                      onSave: () => (String? val) {
                        setState(() {
                          //  password = passwordcontroler.text;
                        });
                      },
                      validate: () => (String? val) {
                        if (val!.isEmpty) {
                          return "this field can't be empty";
                        }
                      },
                      vall: passvisible,
                      mycontroler: oldpasswordcontroler,
                    ),
                    defultTextFied(
                      hint: "New Password",
                      label: "New Password",
                      type: TextInputType.visiblePassword,
                      pIcon: Icon(Icons.lock, color: Colors.purple.shade100),
                      sIcon: IconButton(
                        icon: Icon(
                          passvisible ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            passvisible1 = !passvisible1;
                          });
                        },
                      ),
                      onSave: () => (String? val) {
                        setState(() {
                          //  password = passwordcontroler.text;
                        });
                      },
                      validate: () => (String? val) {
                        if (val!.isEmpty) {
                          return "this field can't be empty";
                        }
                      },
                      vall: passvisible1,
                      mycontroler: newpasswordcontroler,
                    ),
                    const SizedBox(height: 16),
                    defultTextFied(
                      hint: "Confirm ",
                      label: "Confirm Password",
                      type: TextInputType.visiblePassword,
                      pIcon: Icon(Icons.lock, color: Colors.purple.shade100),
                      sIcon: IconButton(
                        icon: Icon(
                          passvisible ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            passvisible2 = !passvisible2;
                          });
                        },
                      ),
                      onSave: () => (String? val) {
                        setState(() {
                          //  password = passwordcontroler.text;
                        });
                      },
                      validate: () => (String? val) {
                        if (val!.isEmpty) {
                          return "this field can't be empty";
                        }
                      },
                      vall: passvisible2,
                      mycontroler: confirmpasswordcontroler,
                    ),

                    const SizedBox(height: 16),
                    // -- Form Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                            side: BorderSide.none,
                            shape: const StadiumBorder()),
                        child: const Text('Change',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 1),
                    // -- Created Date and Delete Button
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}
