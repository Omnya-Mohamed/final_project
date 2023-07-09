//import 'dart:html';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:g_project/api_final_edit.dart';
import 'package:g_project/widget/fields.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class EditPatientRecordScreen extends StatefulWidget {
  final String? name;
  final String? nid;
  final String? age;
  final String? gender;
  final String? birthDate;
  final String? phone;
  final String? address;
  const EditPatientRecordScreen(
      {Key? key,
      this.name,
      this.nid,
      this.age,
      this.gender,
      this.birthDate,
      this.phone,
      this.address})
      : super(key: key);

  @override
  State<EditPatientRecordScreen> createState() =>
      _EditPatientRecordScreenState();
}

//final ImagePicker _picker = ImagePicker();

class _EditPatientRecordScreenState extends State<EditPatientRecordScreen> {
  late final nameController = TextEditingController(text: widget.name);
  late final phoneController = TextEditingController(text: widget.phone);
  late final genderController = TextEditingController(text: widget.gender);
  late final ageController = TextEditingController(text: widget.age);
  late final addressController = TextEditingController(text: widget.address);
  late final nationalIdController = TextEditingController(text: widget.nid);
  final _key = GlobalKey<FormState>();
  var gender;
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
  //late DateTime _startTime;

  final DateTime _ProcessTime = DateTime.now();
  var ProcessTime;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[200],
        title: const Center(
          child: Text(
            "Patient Information",
            style: TextStyle(fontSize: 25),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: PatientData(),
        ),
      ),
    );
  }

  Form PatientData() {
    return Form(
      key: _key,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              pickedImage == null
                  ? const CircleAvatar(
                      radius: 65,
                      backgroundImage:
                          AssetImage('assets/images/Bone_marrow_biopsy.jpg'))
                  : Image.file(pickedImage!), // SizedBox(
              //   width: 120,
              //   height: 120,
              //   child: ClipRRect(
              //       borderRadius: BorderRadius.circular(50),
              //       child:  pickedImage == null
              //           ? Image(
              //           image: AssetImage('assets/images/doctor2.jpg'))
              //           : Image.file(
              //         pickedImage!,
              //         // width: 400,
              //         // height: 400,
              //       )
              //
              //       ),
              // ),
              Positioned(
                bottom: 0,
                right: 0,
                child: InkWell(
                  onTap: () => myDialog(),
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
          const SizedBox(
            height: 10,
          ),
          defaultTextField(
            // hint: "Enter Patient name",
            label: "Name",
            // initialValue: widget.name ?? "Name",
            type: TextInputType.text,

            pIcon: const Icon(Icons.person),
            onSave: () => (String? val) {
              setState(() {});
            },
            validate: () => (String? val) {},
            secureText: false,
            myController: nameController,
          ),
          const SizedBox(
            height: 15,
          ),
          defaultTextField(
            // hint: "Patient Age",
            label: "Age",
            type: TextInputType.number,
            pIcon: const Icon(Icons.edit),
            // initialValue: widget.age ?? "Age",

            onSave: () => (String? val) {
              setState(() {});
            },
            validate: () => (String? val) {},
            secureText: false,
            myController: ageController,
          ),
          const SizedBox(
            height: 10,
          ),
          defaultTextField(
            hint: "Patient phone",
            label: "Phone",
            type: TextInputType.number,
            // initialValue: widget.phone ?? "Phone",
            pIcon: const Icon(Icons.phone_android),
            onSave: () => (String? val) {
              setState(() {});
            },
            validate: () => (String? val) {},
            secureText: false,
            myController: phoneController,
          ),
          const SizedBox(
            height: 15,
          ),
          defaultTextField(
            hint: "Patient Address",
            label: "Address",
            type: TextInputType.text,
            // initialValue: widget.address ?? "Address",
            pIcon: const Icon(Icons.home_outlined),
            onSave: () => (String? val) {
              setState(() {});
            },
            validate: () => (String? val) {},
            secureText: false,
            myController: addressController,
          ),
          const SizedBox(
            height: 15,
          ),
          defaultTextField(
            // hint: "Enter National ID",
            label: " BirthDate",
            type: TextInputType.number,
            // initialValue: widget.birthDate ?? "BirthDate",

            pIcon: const Icon(Icons.edit),
            onSave: () => (String? val) {
              setState(() {});
            },
            validate: () => (String? val) {},
            secureText: false,
            myController: nationalIdController,
          ),
          Row(
            children: [
              const Text(
                "Gender ?",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
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
          ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              backgroundColor: MaterialStateProperty.all<Color>(m_color!),
            ),
            onPressed: () async {
              var result =
                  await ApiHelperFinalEdit.searchInClassificationAndPrediction(
                      nationalId: nationalIdController.text);
              ApiHelperFinalEdit.editPatient(
                  id: result['id'],
                  address: addressController.text,
                  phoneNumber: phoneController.text,
                  gender: gender,
                  profilePhoto: pickedImage,
                  age: int.parse(ageController.text),
                  name: nameController.text,
                  nationalId: nationalIdController.text);
              Navigator.pop(context);
            },
            child: const Text("Edit"),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  myDialog() {
    var ad = AlertDialog(
      title: const Center(child: Text("Chose Image From")),
      //content: Text("Status:"),
      actions: [
        MaterialButton(
            minWidth: 30.0,
            color: Colors.purple.shade300,
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.purple.shade300),
                borderRadius: BorderRadius.circular(15.0)),
            onPressed: () => CameraImage(),
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
            onPressed: () => GalleryImage(),
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
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return ad;
        });
  }
}
