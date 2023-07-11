import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:g_project/core/repos/api_helper.dart';
import 'package:g_project/screens/add_patient_screen.dart';
import 'package:g_project/shared/components/default_text_form_field.dart';
import 'package:g_project/shared/constansts/app_colors.dart';
import 'package:readmore/readmore.dart';

import 'prediction_full_result_screen.dart';

//import 'package:managment/data/model/add_date.dart';
//import 'package:hive_flutter/hive_flutter.dart';

class PredictionScreen extends StatefulWidget {
  PredictionScreen({super.key});

  // Prediction_Screen({super.key});

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
    "Female",
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
      // appBar: AppBar(title:  Text('Classification')),
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
            padding: EdgeInsets.all(16.0),
            child: ReadMoreText(
              "For survival outcome prediction, the mobile app leverages a machine learning model trained on a large dataset containing patient information, treatment variables, and post-transplant outcomes. By inputting relevant patient data into the app, healthcare professionals can obtain real-time predictions regarding the likelihood of survival after BMT. This predictive capability aids in treatment decision-making and allows physicians to customize patient care plans.",
              trimLines: 3,
              colorClickableText: Colors.pink,
              trimMode: TrimMode.Line,
              trimCollapsedText: 'Show more',
              trimExpandedText: '..Show less',
              textAlign: TextAlign.justify,
              moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Expanded(
                  child: defaultTextField(
                    // hint: "Enter National ID",
                    label: " NID",
                    type: TextInputType.number,
                    pIcon: Icon(Icons.edit),
                    onSave: () => (String? val) {
                      setState(() {
                        ApiHelper.searchInClassificationAndPrediction(
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
                SizedBox(
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
                  child: Icon(Icons.search),
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
                        color: purple300!,
                      ),
                      height: 40,
                      width: 100,
                      child: Center(
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
                                  builder: (context) => AddPatientScreen(
                                        screenName: 'Prediction',
                                      )));
                        }
                      : null,
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: purple300!,
                      ),
                      height: 40,
                      width: 100,
                      child: Center(
                          child: Text(
                        "Add Patient",
                        style: TextStyle(color: Colors.white),
                      ))),
                )
              : Container(),

          SizedBox(height: 20),
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
                        icon: Icon(Icons.close))
                  ],
                )
              : Container(),
          SizedBox(height: 20),
          //Spacer(),
          StartProcess(),
          SizedBox(height: 20),
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
        child: Text(
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
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 40),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    Text(
                      'Prediction',
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    Icon(
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
      child: Text(
        "Save",
        style: TextStyle(color: Colors.purple),
      ),
      onPressed: () {},
    );
    Widget cancelButton = TextButton(
      child: Text("Cancel", style: TextStyle(color: Colors.purple)),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget detailsButton = TextButton(
      child: Text("Show in details", style: TextStyle(color: Colors.purple)),
      onPressed: () async {
        var result = await ApiHelper.searchInClassificationAndPrediction(
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
      title: Center(child: Text("Result")),
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
