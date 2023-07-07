//import 'dart:html';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:g_project/api_final_edit.dart';
import 'package:g_project/shared_pref.dart';
import 'package:g_project/widget/fields.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import 'c_Full_result.dart';

class UpdateRecord extends StatefulWidget {
  const UpdateRecord({Key? key}) : super(key: key);

  @override
  State<UpdateRecord> createState() => _UpdateRecordState();
}

//final ImagePicker _picker = ImagePicker();

class _UpdateRecordState extends State<UpdateRecord> {
  var namecontroler = TextEditingController();
  var phonecontroler = TextEditingController();
  var gendercontroler = TextEditingController();
  var agecontroler = TextEditingController();
  var addresscontroler = TextEditingController();
  var nidcontroler = TextEditingController();
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

  DateTime _ProcessTime = DateTime.now();
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
              const CircleAvatar(
                  radius: 65,
                  backgroundImage: AssetImage(
                      'assets/images/Bone_marrow_biopsy.jpg')), // SizedBox(
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
          defultTextFied(
            // hint: "Enter Patient name",
            label: " Name",
            type: TextInputType.text,
            pIcon: const Icon(Icons.person),
            onSave: () => (String? val) {
              setState(() {});
            },
            validate: () => (String? val) {},
            vall: false,
            mycontroler: namecontroler,
          ),
          const SizedBox(
            height: 15,
          ),
          defultTextFied(
            // hint: "Patient Age",
            label: "Age",
            type: TextInputType.number,
            pIcon: const Icon(Icons.edit),
            onSave: () => (String? val) {
              setState(() {});
            },
            validate: () => (String? val) {},
            vall: false,
            mycontroler: agecontroler,
          ),
          const SizedBox(
            height: 10,
          ),
          defultTextFied(
            hint: "Patient phone",
            label: "Phone",
            type: TextInputType.number,
            pIcon: const Icon(Icons.phone_android),
            onSave: () => (String? val) {
              setState(() {});
            },
            validate: () => (String? val) {},
            vall: false,
            mycontroler: phonecontroler,
          ),
          const SizedBox(
            height: 15,
          ),
          defultTextFied(
            hint: "Patient Address",
            label: "Address",
            type: TextInputType.number,
            pIcon: const Icon(Icons.home_outlined),
            onSave: () => (String? val) {
              setState(() {});
            },
            validate: () => (String? val) {},
            vall: false,
            mycontroler: addresscontroler,
          ),
          const SizedBox(
            height: 15,
          ),
          defultTextFied(
            // hint: "Enter National ID",
            label: " BirthDate",
            type: TextInputType.number,
            pIcon: const Icon(Icons.edit),
            onSave: () => (String? val) {
              setState(() {});
            },
            validate: () => (String? val) {},
            vall: false,
            mycontroler: nidcontroler,
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
            onPressed: () {
              ApiHealperFinalEdit.editPatient(
                  id: 1,
                  address: addresscontroler.text,
                  phoneNumber: phonecontroler.text,
                  gender: gender,
                  profilePhoto: pickedImage == null ? null : pickedImage!.path,
                  age: int.parse(agecontroler.text),
                  name: namecontroler.text,
                  birthDate: nidcontroler.text);

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UpdateRecord()));
            },
            child: Text("Edit"),
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
      title: Center(child: Text("Chose Image From")),
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
        SizedBox(width: 15),
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
