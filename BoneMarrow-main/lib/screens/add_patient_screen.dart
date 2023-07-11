import 'dart:io';
// the first
import 'package:flutter/material.dart';
import 'package:g_project/api_final_edit.dart';
import 'package:g_project/classification_screen.dart';
import 'package:g_project/main_bottom_navigation_bar.dart';
import 'package:g_project/prediction_screen.dart';
import 'package:g_project/shared/constansts.dart/app_colors.dart';
import 'package:g_project/shared/constansts.dart/app_strings.dart';
import 'package:g_project/widget/fields.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../shared/constansts.dart/app_values.dart';

class AddPatientScreen extends StatefulWidget {
  final String screenName;
  const AddPatientScreen({Key? key, required this.screenName})
      : super(key: key);
  @override
  State<AddPatientScreen> createState() => _AddPatientScreenState();
}

class _AddPatientScreenState extends State<AddPatientScreen> {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var genderController = TextEditingController();
  var birthDateController = TextEditingController();
  var ageController = TextEditingController();
  var addressController = TextEditingController();
  var nationalIdController = TextEditingController();

  String? gender;
  String? _radioVal;
  final ImagePicker _picker = ImagePicker();
  File? pickedImage;

  CameraImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image == null) {
      return;
    }
    setState(() {
      pickedImage = File(
        image.path,
      );
    });
  }

  GalleryImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    setState(() {
      pickedImage = File(
        image.path,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: purple200,
        title: const Center(
          child: Text(
            "New Patient ",
            style: TextStyle(fontSize: 25),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  pickedImage == null
                      ? const CircleAvatar(
                          radius: 65, backgroundImage: AssetImage(mainPhoto))
                      : Image.file(pickedImage!), // SizedBox(
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () => chooseImageTypeDialog(),
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.white),
                        child: const Icon(LineAwesomeIcons.camera,
                            color: Colors.black, size: 25),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15.0,
              ),
              defaultTextField(
                label: " NID",
                type: TextInputType.number,
                pIcon: const Icon(Icons.edit),
                onSave: () => (String? val) {
                  setState(() {});
                },
                validate: () => (String? val) {
                  if (val!.isEmpty) {
                    return "this field can't be empty";
                  }
                },
                secureText: false,
                myController: nationalIdController,
              ),
              const SizedBox(
                height: 8.0,
              ),
              defaultTextField(
                hint: "Enter Patient name",
                label: " Name",
                type: TextInputType.text,
                pIcon: const Icon(Icons.person),
                onSave: () => (String? val) {
                  setState(() {});
                },
                validate: () => (String? val) {
                  if (val!.isEmpty) {
                    return "this field can't be empty";
                  }
                },
                secureText: false,
                myController: nameController,
              ),
              SizedBox(
                height: s_10,
              ),
              defaultTextField(
                hint: "Patient phone",
                label: "Phone",
                type: TextInputType.number,
                pIcon: const Icon(Icons.phone_android),
                onSave: () => (String? val) {
                  setState(() {});
                },
                validate: () => (String? val) {
                  if (val!.isEmpty) {
                    return "this field can't be empty";
                  }
                },
                secureText: false,
                myController: phoneController,
              ),
              SizedBox(
                height: s_10,
              ),
              defaultTextField(
                hint: "BirthDate",
                label: "BirthDate",
                type: TextInputType.number,
                pIcon: const Icon(Icons.baby_changing_station),
                onSave: () => (String? val) {
                  setState(() {});
                },
                validate: () => (String? val) {
                  if (val!.isEmpty) {
                    return "this field can't be empty";
                  }
                },
                secureText: false,
                myController: birthDateController,
              ),
              SizedBox(
                height: s_10,
              ),
              defaultTextField(
                hint: "Patient Age",
                label: "Age",
                type: TextInputType.number,
                pIcon: const Icon(Icons.edit),
                onSave: () => (String? val) {
                  setState(() {});
                },
                validate: () => (String? val) {
                  if (val!.isEmpty) {
                    return "this field can't be empty";
                  }
                },
                secureText: false,
                myController: ageController,
              ),
              SizedBox(
                height: s_10,
              ),
              defaultTextField(
                hint: "Patient Address",
                label: "Address",
                type: TextInputType.name,
                pIcon: const Icon(Icons.home_outlined),
                onSave: () => (String? val) {
                  setState(() {});
                },
                validate: () {},
                secureText: false,
                myController: addressController,
              ),
              Row(
                children: [
                  const Text(
                    "Gender ?",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: RadioListTile(
                      title: const Text("Male"),
                      value: "male",
                      groupValue: gender,
                      activeColor: Colors.purple,
                      onChanged: (value) {
                        setState(() {
                          gender = value.toString();
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile(
                      title: const Text("Female"),
                      value: "female",
                      groupValue: gender,
                      activeColor: Colors.purple,
                      onChanged: (value) {
                        setState(() {
                          gender = value.toString();
                        });
                      },
                    ),
                  ),
                ],
              ),
              MaterialButton(
                  minWidth: 30.0,
                  color: Colors.purple.shade300,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.purple.shade300),
                      borderRadius: BorderRadius.circular(15.0)),
                  onPressed: () {
                    ApiHelperFinalEdit.addPatient(
                      nid: nationalIdController.text.trim(),
                      address: addressController.text.trim(),
                      phoneNumber: phoneController.text.trim(),
                      gender: gender!,
                      profilePhoto: pickedImage,
                      age: ageController.text.trim(),
                      birthDate: birthDateController.text.trim(),
                      name: nameController.text.trim(),
                    );
                    if (widget.screenName == prediction) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PredictionScreen()));
                    } else if (widget.screenName == classification) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ClassificationScreen()));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MainBottomNavigationBar()));
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Create",
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  chooseImageTypeDialog() {
    var ad = AlertDialog(
      title: const Center(child: Text("Choose Image From")),
      //content: Text("Status:"),
      actions: [
        MaterialButton(
            minWidth: 30.0,
            color: Colors.purple.shade300,
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.purple.shade300),
                borderRadius: BorderRadius.circular(15.0)),
            onPressed: () {
              CameraImage();
              Navigator.pop(context);
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Camera",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            )),
        const SizedBox(width: 15),
        MaterialButton(
            minWidth: 30.0,
            color: Colors.purple.shade300,
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.purple.shade300),
                borderRadius: BorderRadius.circular(15.0)),
            onPressed: () {
              GalleryImage();
              Navigator.pop(context);
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Gallery",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ))
      ],
    );
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return ad;
        });
  }
}
