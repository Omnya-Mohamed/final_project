import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:g_project/API.dart';
import 'package:g_project/add_patient_screen.dart';
import 'package:g_project/api_final_edit.dart';
import 'package:g_project/widget/fields.dart';

import 'prediction_full_result_screen.dart';

//import 'package:managment/data/model/add_date.dart';
//import 'package:hive_flutter/hive_flutter.dart';

class PredictionScreen extends StatefulWidget {
  const PredictionScreen({super.key});

  //const Prediction_Screen({super.key});

  @override
  State<PredictionScreen> createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  //final box = Hive.box<Add_data>('data');

  final DateTime _ProcessTime = DateTime.now();
  var ProcessTime;

  // String? selctedItem;
  String? selctedItemi;
  String fileName = '';

  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var genderController = TextEditingController();
  var ageController = TextEditingController();
  var addressController = TextEditingController();
  var nationalIdController = TextEditingController();
  bool isVisible = false;
  bool isAddPatientVisible = false;
  final _key = GlobalKey<FormState>();

  final List<String> _itemei = [
    'Male',
    "Femal",
  ];
  @override
  File? file;

  void loadPredictionFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        file = File(result.files.single.path!);
        fileName = result.names.first.toString();
      });
      print("file $fileName");
    } else {
      print("hasnt't added yet");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            background_container(context),
            Positioned(
              top: 120,
              child: main_container(),
            ),
          ],
        ),
      ),
    );
  }

  Container main_container() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
      ),
      height: 500,
      width: 340,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
            child: Row(
              children: [
                Expanded(
                  child: defaultTextField(
                    // hint: "Enter National ID",
                    label: " NID",
                    type: TextInputType.number,
                    pIcon: const Icon(Icons.edit),
                    onSave: () => (String? val) {
                      setState(() {
                        ApiHelperFinalEdit.searchInClassificationAndPrediction(
                            nationalId: nationalIdController.text);
                      });
                    },
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
                    var result = await ApiHelperFinalEdit
                        .searchInClassificationAndPrediction(
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
                  },
                  backgroundColor: Colors.purple,
                  child: const Icon(Icons.search),
                )
              ],
            ),
          ),
          isVisible
              ? InkWell(
                  onTap: isVisible ? () => loadPredictionFile() : null,
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: m_color!,
                      ),
                      height: 40,
                      width: 100,
                      child: const Center(
                          child: Text(
                        "upload files",
                        style: TextStyle(color: Colors.white),
                      ))),
                )
              : Container(),
          isAddPatientVisible
              ? InkWell(
                  onTap: isAddPatientVisible
                      ? () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AddPatientScreen(
                                        screenName: 'Prediction',
                                      )));
                        }
                      : null,
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: m_color!,
                      ),
                      height: 40,
                      width: 100,
                      child: const Center(
                          child: Text(
                        "Add Patient",
                        style: TextStyle(color: Colors.white),
                      ))),
                )
              : Container(),

          const SizedBox(height: 20),
          fileName.isNotEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(fileName),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            fileName = '';
                          });
                        },
                        icon: const Icon(Icons.close))
                  ],
                )
              : Container(),
          const SizedBox(height: 20),
          //Spacer(),
          StartProcess(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  GestureDetector StartProcess() {
    return GestureDetector(
      onTap: () {
        myDialog();
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.deepPurple[300],
        ),
        width: 130,
        height: 40,
        child: const Text(
          'Start Process',
          style: TextStyle(
            //fontFamily: 'f',
            fontWeight: FontWeight.w700,
            color: Colors.white,
            fontSize: 17,
          ),
        ),
      ),
    );
  }

  Column background_container(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 240,
          decoration: BoxDecoration(
            color: Colors.deepPurple[300],
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    const Text(
                      'Prediction',
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    const Icon(
                      Icons.notification_add,
                      color: Colors.white,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  myDialog() async {
    var predictionResult = await ApiHelper.uploadFilePrediction(
      file: file!,
      nationalId: nationalIdController.text.trim(),
    );
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
    Widget detailsButton = TextButton(
      child:
          const Text("Show in details", style: TextStyle(color: Colors.purple)),
      onPressed: () async {
        var result =
            await ApiHelperFinalEdit.searchInClassificationAndPrediction(
                nationalId: nationalIdController.text);
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
          return PredictionFullResultScreen(
            result: predictionResult,
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
      content: Text("Status: $predictionResult"),
      actions: [
        saveButton,
        cancelButton,
        detailsButton,
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
