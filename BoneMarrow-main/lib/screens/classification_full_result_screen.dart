import 'package:flutter/material.dart';
import 'package:g_project/shared/constansts/app_colors.dart';
import 'package:g_project/shared/constansts/app_values.dart';
import 'package:g_project/shared/constansts/text_styles.dart';

import 'classification_patient_record_screen.dart';

class ClassificationFullResultScreen extends StatefulWidget {
  final String? nid;
  final String? predictionName;
  final String? result;
  final String? gender;
  final String? age;
  final String? image;
  final String? address;
  final String? phoneNumber;
  final String? birthDate;
  const ClassificationFullResultScreen(
      {Key? key,
      this.nid,
      this.predictionName,
      this.result,
      this.gender,
      this.age,
      this.image,
      this.address,
      this.phoneNumber,
      this.birthDate})
      : super(key: key);

  @override
  State<ClassificationFullResultScreen> createState() =>
      _ClassificationFullResultScreenState();
}

class _ClassificationFullResultScreenState
    extends State<ClassificationFullResultScreen> {
  bool SwitchColor = false;
  bool lSwitch = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: purple300,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(70),
                ),
                color: purple300),
            child: Stack(
              children: [
                Positioned(
                  top: 10,
                  left: 0,
                  child: Container(
                    height: 100,
                    width: 280,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(50),
                          topRight: Radius.circular(50),
                        )),
                  ),
                ),
                Positioned(
                    top: 40,
                    left: 20,
                    child: Text(
                      "Final Result",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: greyText,
                      ),
                    ))
              ],
            ),
          ),
          SizedBox(
            height: s_10,
          ),
          SizedBox(
            height: 250,
            child: Stack(
              children: [
                Positioned(
                    top: 30,
                    left: 15,
                    right: 15,
                    child: Material(
                      child: Container(
                        height: 250,
                        width: 370,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(0.8),
                            boxShadow: [
                              BoxShadow(
                                  //color: Colors.grey[200],
                                  color: Colors.grey.withOpacity(0.3),
                                  offset: const Offset(-10.0, 10.0),
                                  blurRadius: 20.0,
                                  spreadRadius: 40)
                            ]),
                      ),
                    )),
                Positioned(
                  top: 10,
                  left: 15,
                  child: Card(
                    elevation: 10.0,
                    //shadowColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Container(
                      height: 180,
                      width: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: const DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("assets/images/doctor2.jpg"),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 35,
                  left: 160,
                  child: SizedBox(
                    height: 210,
                    width: 200,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Patient Data",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                        const Divider(
                          color: Colors.purple,
                        ),
                        Text(
                          "Name: ${widget.predictionName}",
                          style: greyTextStyle.copyWith(fontSize: 18),
                        ),
                        Text(
                          "Age: ${widget.age}",
                          style: greyTextStyle.copyWith(fontSize: 18),
                        ),
                        Text(
                          "Gender: ${widget.gender}",
                          style: greyTextStyle.copyWith(fontSize: 18),
                        ),
                        Text(
                          "Birth Date: ${widget.birthDate}".trim(),
                          style: greyTextStyle.copyWith(fontSize: 18),
                        ),
                        Text(
                          "NID: ${widget.nid}",
                          style: greyTextStyle.copyWith(fontSize: 18),
                        ),
                        Text(
                          "Status: ${widget.result}",
                          style: greyTextStyle.copyWith(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Expanded(
              child: MaterialButton(
                  // minWidth: 100,
                  color: purple300,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.purple.shade300),
                      borderRadius: BorderRadius.circular(15.0)),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => ClassificationPatientRecordScreen(
                              result: widget.result,
                              predictionName: widget.predictionName,
                              image: widget.image,
                              nid: widget.nid,
                              age: widget.age,
                              gender: widget.gender,
                              address: widget.address,
                              phoneNumber: widget.phoneNumber,
                              birthDate: widget.birthDate,
                            )));
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Continue",
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
            ),
          ),
        ]),
      ),
    );
  }
}
