import 'package:flutter/material.dart';
import 'package:g_project/all_patient_records_screen.dart';
import 'package:g_project/api_final_edit.dart';
import 'package:g_project/widget/fields.dart';

import 'screens/add_patient_screen.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key, required this.isappbar}) : super(key: key);
  final bool isappbar;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? searchValue;
  var searchController = TextEditingController();
  bool isVisible = false;
  bool isAddPatientVisible = false;
  @override
  Widget build(BuildContext context) {
    var result =
        ApiHelperFinalEdit.searchInPatientRecords(nationalId: '30110202200103');
    print(result);
    return Scaffold(
      appBar: widget.isappbar
          ? AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back, color: Colors.black),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
            )
          : null,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10, right: 16, left: 16),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: searchController,
                    showCursor: true,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: 'NID...',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: m_color!, width: 1.2)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: m_color!, width: 1.2)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: m_color!, width: 1.2),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                FloatingActionButton.small(
                  onPressed: () async {
                    var result = await ApiHelperFinalEdit
                        .searchInClassificationAndPrediction(
                            nationalId: searchController.text.trim());
                    setState(() {
                      setState(() {
                        if (result.isEmpty) {
                          isAddPatientVisible = !isAddPatientVisible;
                          !isVisible;
                        } else {
                          isVisible = !isVisible;
                          !isAddPatientVisible;
                        }
                      });
                    });
                  },
                  backgroundColor: m_color,
                  child: Icon(Icons.search),
                ),
              ],
            ),
          ),
          Expanded(
            child: isVisible
                ? FutureBuilder(
                    future:
                        ApiHelperFinalEdit.searchInClassificationAndPrediction(
                            nationalId: searchController.text.trim()),
                    // shrinkWrap: true,
                    // padding:  EdgeInsets.only(right: 16, left: 16, top: 10),
                    builder: (context, snapshot) {
                      return Card(
                        // color: Colors.blue,
                        elevation: 10,
                        child: ListTile(
                          title: Text(
                              "Patient Name: ${snapshot.data?.values.elementAt(2)}"),
                          subtitle:
                              Text("ID: ${snapshot.data?.values.elementAt(1)}"),
                          trailing: MaterialButton(
                              minWidth: 20.0,
                              color: m_color,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(15.0)),
                              onPressed: () async {
                                var result = await ApiHelperFinalEdit
                                    .searchInClassificationAndPrediction(
                                        nationalId: searchController.text);
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (_) {
                                  return AllPatientRecordsScreen(
                                    name: result['name'],
                                    nid: result['national_id'].toString(),
                                    age: result['age'].toString(),
                                    gender: result['gender'],
                                    address: result['address'],
                                    phone: result['phone_number'].toString(),
                                    birthDate: result['birth_date'].toString(),
                                  );
                                }));
                              },
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "PRecord",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )),
                        ),
                      );
                    },
                  )
                : SizedBox(
                    height: 100,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'OR',
                          style: t_style.copyWith(fontSize: 16),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: !isVisible
                              ? () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AddPatientScreen(
                                                screenName: 'Home',
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
                              child: Center(
                                  child: Text(
                                "Add Patient",
                                style: TextStyle(color: Colors.white),
                              ))),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
