import 'package:flutter/material.dart';
import 'package:g_project/screens/edit_patient_record_screen.dart';
import 'package:g_project/screens/classification_screen.dart';
import 'package:g_project/shared/constansts/app_colors.dart';
import 'package:g_project/shared/constansts/app_values.dart';
import 'package:g_project/shared/constansts/text_styles.dart';

import '../core/repos/api_helper.dart';
import 'main_bottom_navigation_bar.dart';
import 'not_refactored/prediction_screen.dart';

class AllPatientRecordsScreen extends StatefulWidget {
  final String? name;
  final String? nid;
  final String? age;
  final String? gender;
  final String? birthDate;
  final String? phone;
  final String? address;
  const AllPatientRecordsScreen({
    Key? key,
    this.name,
    this.nid,
    this.age,
    this.gender,
    this.birthDate,
    this.phone,
    this.address,
  }) : super(key: key);

  @override
  State<AllPatientRecordsScreen> createState() =>
      _AllPatientRecordsScreenState();
}

class _AllPatientRecordsScreenState extends State<AllPatientRecordsScreen> {
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_typing_uninitialized_variables
    var historyDiseases;

    getHistoryDiseases() async {
      await ApiHelper.searchInPatientRecords(nationalId: "${widget.nid}")
          .then((value) {
        historyDiseases = value;
        print(value);
      });
      return historyDiseases;
    }

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          child: Icon(Icons.arrow_back, color: purple300),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MainBottomNavigationBar()));
          },
        ),
        title: const Center(
          child: Text("All Patient Records",
              style: TextStyle(color: Colors.black)),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(children: [
        SizedBox(
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
                      "Name: ${widget.name}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: greyText,
                      ),
                    ),
                    Text(
                      "NID: ${widget.nid}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: greyText,
                      ),
                    ),
                    Text(
                      "Age: ${widget.age}",
                      style: greyTextStyle,
                    ),
                    Text(
                      "Gender: ${widget.gender}",
                      style: greyTextStyle,
                    ),
                    Text(
                      "Birth_Date: ${widget.birthDate}",
                      style: greyTextStyle,
                    ),
                    Text(
                      "Phone: ${widget.phone}",
                      style: greyTextStyle,
                    ),
                    Text(
                      "Address: ${widget.address}",
                      style: greyTextStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: s_10,
        ),
        const Text("About History Diseases",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            )),
        SizedBox(
          height: s_10,
        ),
        Expanded(
          child: FutureBuilder(
            future: ApiHelper.searchInPatientRecords(
                nationalId: widget.nid.toString()),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(); // Show a loading indicator while data is being fetched
              } else if (snapshot.hasError) {
                return Text(
                    'Error: ${snapshot.error}'); // Show an error message if there's an error
              } else {
                List<dynamic> classificationsAndPredictions = snapshot.data
                            ?.elementAt(0) +
                        snapshot.data?.elementAt(1) ??
                    []; // Retrieve the classifications data from the snapshot

                return ListView.builder(
                  itemBuilder: (context, index) {
                    // Build each item in the ListView using the retrieved data
                    Map<String, dynamic> record =
                        classificationsAndPredictions[index];
                    String? result;
                    switch (record['result']) {
                      case "EBO":
                        result = "EBO: Erythroblast";
                        break;
                      case "PLM":
                        result = "PLM: Plasma Cell";
                        break;
                      case "NGB":
                        result = "NGB: Neutrophil";
                        break;
                      case "EOS":
                        result = "EOS: Eosinophil";
                        break;
                      case "LYT":
                        result = "LYT: Lymphocyte";
                        break;
                      case "MON":
                        result = "MON: Monocyte";
                        break;
                      case "1":
                        result = "Dead";
                        break;
                      case "0":
                        result = "Alive";
                        break;
                      case "":
                        result = "Sth went wrong, Upload again!";
                        break;
                      default:
                    }
                    return Container(
                      margin: const EdgeInsets.all(12),
                      height: 150,
                      width: 400,
                      decoration: BoxDecoration(
                        border: Border.all(color: deepPurple200!, width: 2),
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
                                "Process Type : ${record['process_type']}",
                                style: greyTextStyle,
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
                                "Result : $result",
                                style: greyTextStyle,
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
                  itemCount: classificationsAndPredictions
                      .length, // Set the number of items in the ListView
                );
              }
            },
          ),
        )
      ]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: purple300,
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
                            MaterialStateProperty.all<Color>(purple300),
                      ),
                      onPressed: () async {
                        var result =
                            await ApiHelper.searchInClassificationAndPrediction(
                                nationalId: widget.nid!);
                        Navigator.of(context)
                            .pushReplacement(MaterialPageRoute(builder: (_) {
                          return EditPatientRecordScreen(
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
                            MaterialStateProperty.all<Color>(purple300),
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
                                                      PredictionScreen()))),
                                    ],
                                  ));
                            });
                      },
                      child: const Text("Add Process"),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(purple300),
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
}
