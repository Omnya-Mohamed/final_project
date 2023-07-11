//import 'dart:html';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:g_project/core/repos/api_helper.dart';
import 'package:g_project/screens/classification_full_result_screen.dart';
import 'package:g_project/shared/components/add_patient_button.dart';
import 'package:g_project/shared/components/custom_button.dart';
import 'package:g_project/shared/components/default_text_form_field.dart';
import 'package:g_project/shared/components/show_more_text.dart';
import 'package:g_project/shared/constansts/app_strings.dart';
import 'package:g_project/shared/constansts/app_values.dart';
import 'package:image_picker/image_picker.dart';


class ClassificationScreen extends StatefulWidget {
  const ClassificationScreen({Key? key}) : super(key: key);

  @override
  State<ClassificationScreen> createState() => _ClassificationScreenState();
}

//final ImagePicker _picker = ImagePicker();

class _ClassificationScreenState extends State<ClassificationScreen> {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var genderController = TextEditingController();
  var ageController = TextEditingController();
  var addressController = TextEditingController();
  var nationalIdController = TextEditingController();
  final _key = GlobalKey<FormState>();
  var gender;
  String? _radioVal;
  bool isVisible = false;
  bool isAddPatientVisible = false;
  final DateTime _ProcessTime = DateTime.now();
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[200],
        title: const Text(
          classification,
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
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ShowMoreText(
              text:
                  "The mobile app uses a deep learning model trained on patient data to classify image of bone marrow cell to be easy for doctors to identify type of cell",
              lines: 1,
            ),
          ),
          SizedBox(
            height: s_10,
          ),
          Row(
            children: [
              Expanded(
                child: defaultTextField(
                  label: " NID",
                  type: TextInputType.number,
                  pIcon: const Icon(Icons.edit),
                  onSave: () => (String? val) {},
                  validate: () => (String? val) {
                    if (val!.isEmpty) {
                      return "this field can't be empty";
                    }
                  },
                  secureText: false,
                  myController: nationalIdController,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              FloatingActionButton.small(
                onPressed: () async {
                  if (nationalIdController.text.isEmpty) {
                    setState(() {
                      isAddPatientVisible = !isAddPatientVisible;
                      !isVisible;
                    });
                  } else {
                    var result =
                        await ApiHelper.searchInClassificationAndPrediction(
                            nationalId: nationalIdController.text);
                    setState(() {
                      if (result.isEmpty) {
                        isAddPatientVisible = !isAddPatientVisible;
                        !isVisible;
                      } else {
                        isVisible = !isVisible;
                        !isAddPatientVisible;
                      }
                    });
                  }
                },
                backgroundColor: Colors.purple,
                child: const Icon(Icons.search),
              )
            ],
          ),
          SizedBox(
            height: isVisible ? 10 : 0,
          ),
          Column(
            children: [
              isAddPatientVisible
                  ? AddPatientButton(
                      isAddPatientVisible: isAddPatientVisible,
                      context: context,
                      screenName: classification,
                    )
                  : Container(),
              // onPressed: isVisible ? fitchImage : null,
              CustomButton(
                text: 'Upload Image',
                onPressed: isVisible ? fitchImage : null,
              ),
              SizedBox(
                height: s_10,
              ),
              Container(
                width: 350,
                height: 300,
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
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
              SizedBox(
                height: s_10,
              ),
              CustomButton(
                text: 'Start Processing',
                onPressed: () {
                  ProcessTime = _ProcessTime;
                  if (_key.currentState!.validate()) {
                    myDialog();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  myDialog() async {
    var classificationResult = await ApiHelper.uploadFileClassification(
        nationalId: nationalIdController.text, file: pickedImage!);

    Widget cancelButton = TextButton(
      child: const Text("Cancel", style: TextStyle(color: Colors.purple)),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget datailsButton = TextButton(
      child:
          const Text("Show in details", style: TextStyle(color: Colors.purple)),
      onPressed: () async {
        var result = await ApiHelper.searchInClassificationAndPrediction(
            nationalId: nationalIdController.text);
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
          return ClassificationFullResultScreen(
            result: classificationResult,
            predictionName: result['name'],
            image: 'pickedImage',
            nid: result['national_id'].toString(),
            age: result['age'].toString(),
            gender: result['gender'],
            address: result['address'],
            phoneNumber: result['phone_number'].toString(),
            birthDate: result['birth_date'].toString(),
          );
        }));
      },
    );
    var ad = AlertDialog(
      title: const Center(child: Text("Result")),
      content: Text("Status: $classificationResult"),
      actions: [
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
