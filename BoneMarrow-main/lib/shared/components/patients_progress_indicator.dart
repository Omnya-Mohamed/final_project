import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';

import '../../api_final_edit.dart';
import '../constansts.dart/app_strings.dart';
import '../constansts.dart/app_values.dart';

class PatientsProgressIndicator extends StatefulWidget {
  PatientsProgressIndicator({super.key});

  @override
  State<PatientsProgressIndicator> createState() =>
      _PatientsProgressIndicatorState();
}

class _PatientsProgressIndicatorState extends State<PatientsProgressIndicator> {
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
    return CircularPercentIndicator(
      radius: 80.0,
      lineWidth: 15.0,
      animation: true,
      percent: 0.7,
      center: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: s_10,
          ),
          Text(
            patientsCount.toString(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          ),
          Text(
            patients,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
          ),
        ],
      ),
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: Colors.deepPurple[300],
    );
  }
}
