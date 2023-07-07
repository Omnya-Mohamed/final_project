import 'package:flutter/material.dart';
import 'package:g_project/Prediction_Screen1.dart';
import 'package:g_project/UpdateRecord.dart';
import 'package:g_project/classification_screen.dart';
import 'package:g_project/widget/fields.dart';

class PatientRecord extends StatefulWidget {
  const PatientRecord({Key? key}) : super(key: key);

  @override
  State<PatientRecord> createState() => _PatientRecordState();
}

class _PatientRecordState extends State<PatientRecord> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          child: Icon(Icons.arrow_back, color: m_color),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Center(
          child: Text("Patient Record", style: TextStyle(color: Colors.black)),
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
                //height: 160,
                //width: 160,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name :",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: t_calor,
                      ),
                    ),
                    Text(
                      "NID :",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: t_calor,
                      ),
                    ),
                    Text(
                      "Age    :",
                      style: t_style,
                    ),
                    Text(
                      "Gender :",
                      style: t_style,
                    ),
                    Text(
                      "Bith_Date :",
                      style: t_style,
                    ),
                    Text(
                      "Phone :",
                      style: t_style,
                    ),
                    Text(
                      "Adreess :",
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
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: ListView.builder(
            //shrinkWrap: true,
            itemBuilder: (context, index) => Container(
              margin: EdgeInsets.all(12),
              height: 150,
              width: 400,
              decoration:
                  BoxDecoration(border: Border.all(color: b_color!, width: 2)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Process Type :",
                        style: t_style,
                      ),
                      Text("Classification "),
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
                        "Result : ",
                        style: t_style,
                      ),
                      const Text("Positive"),
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
            ),
            itemCount: 10, // ايتغير ع حسب العدد اللي جي
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
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UpdateRecord()));
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
                              return  AlertDialog(
                                  title: Text("Which process do You Want:"),
                                  content: Row(
                                    children:[
                                      InkWell(
                                        child: const Text("Classification",
                                          style:TextStyle(
                                            color: Colors.deepPurple,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        onTap:() => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Classification()))
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      InkWell(
                                          child: const Text("Prediction",
                                            style:TextStyle(
                                            color: Colors.deepPurple,
                                              fontWeight: FontWeight.bold,
                                          ),
                                          ),
                                          onTap:() => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>Prediction_Screen()))
                                      ),
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
