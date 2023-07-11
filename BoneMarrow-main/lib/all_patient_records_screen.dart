import 'package:flutter/material.dart';
import 'package:g_project/api_final_edit.dart';
import 'package:g_project/main_bottom_navigation_bar.dart';
import 'package:g_project/prediction_screen.dart';
import 'package:g_project/edit_patient_record_screen.dart';
import 'package:g_project/classification_screen.dart';
import 'package:g_project/shared/constansts.dart/app_values.dart';
import 'package:g_project/widget/fields.dart';

class AllPatientRecordsScreen extends StatefulWidget {
  final String? name;
  final String? nid;
  final String? age;
  final String? gender;
  final String? birthDate;
  final String? phone;
  final String? address;
  AllPatientRecordsScreen({
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
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MainBottomNavigationBar()));
          },
        ),
        title: Center(
          child: Text("All Patient Records",
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
              SizedBox(
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
                      "Phone: ${widget.phone}",
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
        SizedBox(
          height: s_10,
        ),
        Text("About History Diseases",
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
            future: ApiHelperFinalEdit.searchInPatientRecords(
                nationalId: widget.nid.toString()),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(); // Show a loading indicator while data is being fetched
              } else if (snapshot.hasError) {
                return Text(
                    'Error: ${snapshot.error}'); // Show an error message if there's an error
              } else {
                // Data is available, build the ListView
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
                    // var result = record['result'];
                    return Container(
                      margin: EdgeInsets.all(12),
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
                                "Process Type : ${record['process_type']}",
                                style: t_style,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Result : $result",
                                style: t_style,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          SizedBox(
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
        backgroundColor: m_color,
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("What Do You Want :"),
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
                      child: Text("Edit"),
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
                                  title: Text("Which process do You Want:"),
                                  content: Row(
                                    children: [
                                      InkWell(
                                          child: Text(
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
                                                      ClassificationScreen()))),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      InkWell(
                                          child: Text(
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
                      child: Text("Add Process"),
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
                      child: Text("Delete Record"),
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
