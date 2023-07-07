//import 'dart:html';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:g_project/widget/fields.dart';
import 'package:image_picker/image_picker.dart';

import 'c_Full_result.dart';

class Classification extends StatefulWidget {
  const Classification({Key? key}) : super(key: key);

  @override
  State<Classification> createState() => _ClassificationState();
}

//final ImagePicker _picker = ImagePicker();

class _ClassificationState extends State<Classification> {
  var namecontroler = TextEditingController();
  var phonecontroler = TextEditingController();
  var gendercontroler = TextEditingController();
  var agecontroler = TextEditingController();
  var addresscontroler = TextEditingController();
  var nidcontroler = TextEditingController();
  final _key = GlobalKey<FormState>();
  var gender;
  String? _radioVal;
  bool isVissible = false;

  //late DateTime _startTime;

  DateTime _ProcessTime = DateTime.now();
  var ProcessTime;

  final ImagePicker _picker = ImagePicker();
  File? pickedImage;

  fitchImage() async {
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[200],
        title: const Text(
          "Hello! Doctor",
          style: TextStyle(fontSize: 25),
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
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Expanded(
                child: defultTextFied(
                  // hint: "Enter National ID",
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
                  vall: false,
                  mycontroler: nidcontroler,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              FloatingActionButton.small(
                onPressed: () {
                  setState(() {
                    isVissible = !isVissible;
                  });
                },
                backgroundColor: Colors.purple,
                child: const Icon(Icons.search),
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Column(
            children: [
              MaterialButton(
                  minWidth: 30.0,
                  color: Colors.purple.shade300,
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(15.0)),
                  onPressed: isVissible? fitchImage:null,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Upload Image",
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: 350,
                height: 300,
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  //color: Colors.yellow[100],
                    border: Border.all(
                      color: Colors.purple.shade100,
                      width: 3,
                    )),
                child: Center(
                    child: pickedImage == null
                        ? CircularProgressIndicator(
                      color: Colors.purple.shade200,
                    )
                        : Image.file(
                      pickedImage!,
                      width: 400,
                      height: 400,
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              MaterialButton(
                  minWidth: 30.0,
                  color: Colors.purple.shade300,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.purple.shade300),
                      borderRadius: BorderRadius.circular(15.0)),
                  onPressed: () {
                    ProcessTime = _ProcessTime;
                    if (_key.currentState!.validate()) {
                      myDialog();
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Start processing",
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }

  myDialog() {
    Widget saveButton = TextButton(
      child: const Text(
        "Save",
        style: TextStyle(color: Colors.purple),
      ),
      onPressed: () {},
    );
    Widget cancelButton = TextButton(
      child: const Text("Cancel", style: TextStyle(color: Colors.purple)),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget datailsButton = TextButton(
      child:
          const Text("Show in details", style: TextStyle(color: Colors.purple)),
      onPressed: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
          /* return FullResult(
            result: "Nigative",
            PName: "${namecontroler.text}",
            image: pickedImage,
            id: idcontroler.text,
            age: agecontroler.text,
            Gender: gendercontroler.text,
          );*/
          return const C_FullResult();
        }));
      },
    );
    var ad = AlertDialog(
      title: const Center(child: Text("Result")),
      content: const Text("Status:"),
      actions: [
        saveButton,
        cancelButton,
        datailsButton,
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
