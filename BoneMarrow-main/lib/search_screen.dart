import 'package:flutter/material.dart';
import 'package:g_project/api_final_edit.dart';
import 'package:g_project/widget/fields.dart';

import 'classification_patient_record_screen.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key, required this.isappbar}) : super(key: key);
  final bool isappbar;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? searchValue;
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isappbar
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
                const SizedBox(
                  width: 15,
                ),
                FloatingActionButton.small(
                  onPressed: () {
                    ApiHelperFinalEdit.searchInClassificationAndPrediction(
                        nationalId: searchController.text);
                  },
                  backgroundColor: m_color,
                  child: const Icon(Icons.search),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.only(right: 16, left: 16, top: 10),
              itemBuilder: (context, i) {
                return Card(
                  // color: Colors.blue,
                  elevation: 10,
                  child: ListTile(
                    title: const Text("Patient Name"),
                    subtitle: const Text("ID:"),
                    trailing: MaterialButton(
                        minWidth: 20.0,
                        color: m_color,
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(15.0)),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const ClassificationPatientRecordScreen()));
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
            ),
          ),
        ],
      ),
    );
  }
}
