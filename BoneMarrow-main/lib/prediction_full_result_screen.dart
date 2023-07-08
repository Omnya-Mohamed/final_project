import 'package:flutter/material.dart';
import 'package:g_project/prediction_patient_record_screen.dart';
import 'package:g_project/widget/fields.dart';

class PredictionFullResultScreen extends StatefulWidget {
  final String? nid;
  final String? predictionName;
  final String? result;
  final String? gender;
  final String? age;
  final String? image;
  final String? address;
  final String? phoneNumber;
  final String? birthDate;

  const PredictionFullResultScreen(
      {super.key,
      this.predictionName,
      this.result,
      this.gender,
      this.age,
      this.image,
      this.nid,
      this.address,
      this.phoneNumber,
      this.birthDate});

  @override
  State<PredictionFullResultScreen> createState() =>
      _PredictionFullResultScreenState();
}

class _PredictionFullResultScreenState
    extends State<PredictionFullResultScreen> {
  var id;
  bool SwitchColor = false;
  bool lSwitch = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Final Rasult of Process")),
        backgroundColor: Colors.purple.withOpacity(0.7),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(16),
            height: 300,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFFffffff),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 15.0, // soften the shadow
                  spreadRadius: 5.0, //extend the shadow
                  offset: Offset(
                    5.0, // Move to right 5  horizontally
                    5.0, // Move to bottom 5 Vertically
                  ),
                )
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Result : ${widget.result}", style: t_style),
                Text("Patient Name : ${widget.predictionName} ",
                    style: t_style),
                Text("Patient Age : ${widget.age}", style: t_style),
                Text("Gender : ${widget.gender}", style: t_style),
                Text("Address : ${widget.address}", style: t_style),
                Text("Phone Number : ${widget.phoneNumber}", style: t_style),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Expanded(
              child: MaterialButton(
                  minWidth: 200,
                  color: SwitchColor ? Colors.purple.shade300 : Colors.white,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.purple.shade300),
                      borderRadius: BorderRadius.circular(15.0)),
                  onPressed: () {
                    setState(() {
                      SwitchColor = !SwitchColor;
                    });
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => PredictionPatientRecordScreen(
                              name: widget.predictionName,
                              age: widget.age,
                              address: widget.address,
                              gender: widget.gender,
                              birthDate: widget.birthDate,
                              phone: widget.phoneNumber,
                              nid: widget.nid,
                            )));
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Continue",
                      style: TextStyle(color: Colors.black),
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
