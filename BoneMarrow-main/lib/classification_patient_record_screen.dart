import 'package:flutter/material.dart';
import 'package:g_project/api_final_edit.dart';
import 'package:g_project/prediction_screen.dart';
import 'package:g_project/update_patient_record_screen.dart';
import 'package:g_project/classification_screen.dart';
import 'package:g_project/widget/fields.dart';

class ClassificationPatientRecordScreen extends StatefulWidget {
  final String? nid;
  final String? predictionName;
  final String? result;
  final String? gender;
  final String? age;
  final String? image;
  final String? address;
  final String? phoneNumber;
  final String? birthDate;
  const ClassificationPatientRecordScreen({
    Key? key,
    this.nid,
    this.age,
    this.gender,
    this.birthDate,
    this.address,
    this.predictionName,
    this.result,
    this.image,
    this.phoneNumber,
  }) : super(key: key);

  @override
  State<ClassificationPatientRecordScreen> createState() =>
      _ClassificationPatientRecordScreenState();
}

class _ClassificationPatientRecordScreenState
    extends State<ClassificationPatientRecordScreen> {
  // String? patientId;
  // @override
  // void initState() {
  //   patientId = widget.nid;
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_typing_uninitialized_variables
    var historyDiseases;

    getHistoryDiseases() async {
      await ApiHelperFinalEdit.searchInPatientRecords(
              nationalId: "${widget.nid}")
          .then((value) {
        historyDiseases = value;
        print(value);
      });
      return historyDiseases;
    }

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          child: Icon(Icons.arrow_back, color: m_color),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Center(
          child: Text("Classification Patient Record",
              style: TextStyle(color: Colors.black)),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(children: [
        SizedBox(
          // height: 200.0,
          width: 400.0,
          child: Row(
            children: [
              Image.asset(
                "assets/images/doctor4.jpg",
                height: 170,
                width: 140,
                fit: BoxFit.fill,
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name: ${widget.predictionName}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: t_calor,
                      ),
                    ),
                    Text(
                      "NID: ${widget.nid}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: t_calor,
                      ),
                    ),
                    Text(
                      "Age: ${widget.age}",
                      style: t_style,
                    ),
                    Text(
                      "Gender: ${widget.gender}",
                      style: t_style,
                    ),
                    Text(
                      "Birth_Date: ${widget.birthDate}",
                      style: t_style,
                    ),
                    Text(
                      "Phone: ${widget.phoneNumber}",
                      style: t_style,
                    ),
                    Text(
                      "Address: ${widget.address}",
                      style: t_style,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text("About History Diseases",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            )),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: FutureBuilder(
            future: ApiHelperFinalEdit.searchInPatientClassifications(
                nationalId: widget.nid.toString()),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(); // Show a loading indicator while data is being fetched
              } else if (snapshot.hasError) {
                return Text(
                    'Error: ${snapshot.error}'); // Show an error message if there's an error
              } else {
                // Data is available, build the ListView
                List<dynamic> classifications = snapshot.data ??
                    []; // Retrieve the classifications data from the snapshot

                return ListView.builder(
                  itemBuilder: (context, index) {
                    // Build each item in the ListView using the retrieved data
                    Map<String, dynamic> classification =
                        classifications[index];
                    String? classificationResult;
                    switch (classification['result']) {
                      case "EBO":
                        classificationResult = "EBO: Erythroblast";
                        break;
                      case "PLM":
                        classificationResult = "PLM: Plasma Cell";
                        break;
                      case "NGB":
                        classificationResult = "NGB: Neutrophil";
                        break;
                      case "EOS":
                        classificationResult = "EOS: Eosinophil";
                        break;
                      case "LYT":
                        classificationResult = "LYT: Lymphocyte";
                        break;
                      case "MON":
                        classificationResult = "MON: Monocyte";
                        break;
                      default:
                    }

                    return Container(
                      margin: const EdgeInsets.all(12),
                      height: 150,
                      width: 400,
                      decoration: BoxDecoration(
                        border: Border.all(color: b_color!, width: 2),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Process Type : ${classification['process_type']}",
                                style: t_style,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Result : $classificationResult",
                                style: t_style,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: classifications
                      .length, // Set the number of items in the ListView
                );
              }
            },
          ),
        )
      ]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: m_color,
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("What Do You Want :"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(m_color!),
                      ),
                      onPressed: () async {
                        var result = await ApiHelperFinalEdit
                            .searchInClassificationAndPrediction(
                                nationalId: widget.nid!);
                        Navigator.of(context)
                            .pushReplacement(MaterialPageRoute(builder: (_) {
                          return UpdatePatientRecordScreen(
                            name: result['name'],
                            // image: 'pickedImage',
                            nid: result['national_id'].toString(),
                            age: result['age'].toString(),
                            gender: result['gender'],
                            address: result['address'],
                            phone: result['phone_number'].toString(),
                            birthDate: result['birth_date'].toString(),
                          );
                        }));
                      },
                      child: const Text("Edit"),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(m_color!),
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                  title:
                                      const Text("Which process do You Want:"),
                                  content: Row(
                                    children: [
                                      InkWell(
                                          child: const Text(
                                            "Classification",
                                            style: TextStyle(
                                              color: Colors.deepPurple,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const ClassificationScreen()))),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      InkWell(
                                          child: const Text(
                                            "Prediction",
                                            style: TextStyle(
                                              color: Colors.deepPurple,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const PredictionScreen()))),
                                    ],
                                  ));
                            });
                      },
                      child: const Text("Add Process"),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(m_color!),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text("Delete Record"),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

// void FlatDesign(BuildContext context) async {
//   await showMenu(
//     context: context,
//     position: RelativeRect.fromLTRB(25.0, 25.0, 0.0, 0.0),
//     items: [
//       PopupMenuItem(
//         child: Text("Button 1"),
//         value: 1,
//       ),
//       PopupMenuItem(
//         child: Text("Button 2"),
//         value: 2,
//       ),
//       PopupMenuItem(
//         child: Text("Button 3"),
//         value: 3,
//       ),
//     ],
//     elevation: 8.0,
//   ).then((value) {
//     switch (value) {
//       case 1:
//         print("Button 1 clicked");
//         break;
//       case 2:
//         print("Button 2 clicked");
//         break;
//       case 3:
//         print("Button 3 clicked");
//         break;
//     }
//   });
// }
}
