import 'package:flutter/material.dart';
import 'package:g_project/prediction_screen.dart';
import 'package:g_project/shared/components/bezier_draw.dart';
import 'package:g_project/shared/components/patients_progress_indicator.dart';
import 'package:g_project/shared/components/show_more_text.dart';
import 'package:g_project/shared/constansts.dart/app_strings.dart';

import '../api_final_edit.dart';
import '../classification_screen.dart';
import '../shared/constansts.dart/app_values.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? patientsCount;
  @override
  void initState() {
    var result = ApiHelperFinalEdit.getPatientsCount().then((value) {
      setState(() {
        patientsCount = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            children: [
              BezierDraw(),
              Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      dashboard,
                      style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Column(children: [
                      Row(
                        children: [
                          PatientsProgressIndicator(),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  about,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22.0),
                                ),
                                SizedBox(
                                  height: s_10,
                                ),
                                ShowMoreText(
                                  text: aboutDescription,
                                  lines: 5,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ]),
                    const SizedBox(
                      height: 40,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Processes",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                        SizedBox(
                          height: s_10,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ClassificationScreen()));
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 40,
                            child: Row(
                              children: [
                                CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 50,
                                    child: Image.network(
                                      'https://cdn-icons-png.flaticon.com/512/5454/5454211.png',
                                      height: 80,
                                    )),
                                const Expanded(
                                  child: ListTile(
                                    title: Text(
                                      'Classification',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                        'Accurately discerning the type of cell.'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PredictionScreen()));
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 20,
                            child: const Row(
                              children: [
                                CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 50,
                                    backgroundImage: NetworkImage(
                                      'https://cdn-icons-png.flaticon.com/512/4745/4745817.png',
                                    )),
                                Expanded(
                                  child: ListTile(
                                    title: Text(
                                      'Prediction',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                        "The degree of success and failure observed in the transplantation process."),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: s_10,
          ),
        ],
      ),
    );
  }
}
