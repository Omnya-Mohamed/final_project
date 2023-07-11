import 'package:flutter/material.dart';
import 'package:g_project/screens/all_patient_records_screen.dart';
import 'package:g_project/shared/constansts/app_colors.dart';
import 'package:g_project/shared/constansts/text_styles.dart';

import '../../core/repos/api_helper.dart';
import '../add_patient_screen.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key, required this.isAppBar}) : super(key: key);
  final bool isAppBar;

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
    var result = ApiHelper.searchInPatientRecords(nationalId: '30110202200103');
    print(result);
    return Scaffold(
      appBar: widget.isAppBar
          ? AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back, color: Colors.black),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
            )
          : null,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 16, left: 16),
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
                          borderSide: BorderSide(color: purple300, width: 1.2)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: purple300, width: 1.2)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: purple300, width: 1.2),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                FloatingActionButton.small(
                  onPressed: () async {
                    var result =
                        await ApiHelper.searchInClassificationAndPrediction(
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
                  backgroundColor: purple300,
                  child: const Icon(Icons.search),
                ),
              ],
            ),
          ),
          Expanded(
            child: isVisible
                ? FutureBuilder(
                    future: ApiHelper.searchInClassificationAndPrediction(
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
                              color: purple300,
                              shape: RoundedRectangleBorder(
                                  side: const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(15.0)),
                              onPressed: () async {
                                var result = await ApiHelper
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
                              child: const Padding(
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
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'OR',
                          style: greyTextStyle.copyWith(fontSize: 16),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: !isVisible
                              ? () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const AddPatientScreen(
                                                screenName: 'Home',
                                              )));
                                }
                              : null,
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: purple300,
                              ),
                              height: 40,
                              width: 100,
                              child: const Center(
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
