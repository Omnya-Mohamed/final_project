//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:g_project/API.dart';
import 'package:g_project/widget/fields.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool passvisible = false;
  bool passvisible1 = false;
  bool passvisible2 = false;
  var oldpasswordcontroler = TextEditingController();
  var newPasswordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
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
                    defaultTextField(
                      hint: "Enter Password",
                      label: "Enter Password",
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
                      secureText: passvisible,
                      myController: oldpasswordcontroler,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultTextField(
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
                      secureText: passvisible1,
                      myController: newPasswordController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultTextField(
                      hint: "Confirm ",
                      label: "Confirm New Password",
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
                      secureText: passvisible2,
                      myController: confirmPasswordController,
                    ),

                    const SizedBox(height: 16),
                    // -- Form Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          await ApiHelper.changePassword(
                            newPassword: newPasswordController.text.trim(),
                            confirmNewPassword:
                                confirmPasswordController.text.trim(),
                          );
                          const snackBar = SnackBar(
                            content: Text('Changed Password Successfully'),
                            backgroundColor: Color.fromARGB(255, 37, 238, 51),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple[300],
                            side: BorderSide.none,
                            shape: const StadiumBorder()),
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text('Change',
                              style: TextStyle(color: Colors.white)),
                        ),
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
