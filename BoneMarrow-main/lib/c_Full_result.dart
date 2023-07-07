import 'package:flutter/material.dart';
import 'package:g_project/widget/fields.dart';

import 'home_screen.dart';
import 'p_Record.dart';

class C_FullResult extends StatefulWidget {
  const C_FullResult({Key? key}) : super(key: key);

  @override
  State<C_FullResult> createState() => _C_FullResultState();
}

class _C_FullResultState extends State<C_FullResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: m_color,
        leading: IconButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: const Text('Alert'),
                      content: const Text(
                          'Are you sure to close  this process .. !'),
                      actions: [
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('Save'),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()));
                            },
                            child: const Text('ignore'))
                      ],
                    ));
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
                color: m_color),
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
                        color: t_calor,
                      ),
                    ))
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 250,
            child: Stack(
              children: [
                Positioned(
                    top: 30,
                    left: 15,
                    right: 15,
                    child: Material(
                      child: Container(
                        height: 200,
                        width: 370,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(0.8),
                            boxShadow: [
                              new BoxShadow(
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
                      height: 210,
                      width: 150,
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
                  top: 45,
                  left: 180,
                  child: Container(
                    height: 200,
                    width: 160,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Patient Data:",
                          style: t_style,
                        ),
                        const Divider(
                          color: Colors.purple,
                        ),
                        Text(
                          "Name :",
                          style: t_style,
                        ),
                        Text(
                          "Age    :",
                          style: t_style,
                        ),
                        // Text(
                        //   "Address:",
                        //   style: t_style,
                        // ),
                        Text(
                          "Gender :",
                          style: t_style,
                        ),
                        Text(
                          "Date     :",
                          style: t_style,
                        ),
                        Text(
                          "NID :",
                          style: t_style,
                        ),
                        Text(
                          "Status :",
                          style: t_style,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          // Container(
          //   // height: 200.0,
          //   width: 400.0,
          //   decoration: const BoxDecoration(
          //     boxShadow: [
          //       BoxShadow(
          //         color: Colors.grey,
          //         blurRadius: 15.0, // soften the shadow
          //         spreadRadius: 5.0, //extend the shadow
          //         offset: Offset(
          //           5.0, // Move to right 5  horizontally
          //           5.0, // Move to bottom 5 Vertically
          //         ),
          //       )
          //     ],
          //   ),
          //   child: Row(
          //     children: [
          //       Image.asset(
          //         "assets/images/doctor4.jpg",
          //         height: 170,
          //         width: 140,
          //         fit: BoxFit.fill,
          //       ),
          //       const SizedBox(
          //         width: 10,
          //       ),
          //       SizedBox(
          //         height: 160,
          //         //width: 160,
          //         child: Column(
          //           // mainAxisAlignment: MainAxisAlignment.start,
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Text(
          //               "Name :",
          //               style: TextStyle(
          //                 fontSize: 20,
          //                 fontWeight: FontWeight.bold,
          //                 color: t_calor,
          //               ),
          //             ),
          //             Text(
          //               "Age    :",
          //               style: t_style,
          //             ),
          //             Text(
          //               "Gender :",
          //               style: t_style,
          //             ),
          //             Text(
          //               "Bith_Date :",
          //               style: t_style,
          //             ),
          //             Text(
          //               "Phone :",
          //               style: t_style,
          //             ),
          //             Text(
          //               "Adreess :",
          //               style: t_style,
          //             ),
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: MaterialButton(
                    //minWidth: 100,
                    color: m_color,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.purple.shade300),
                        borderRadius: BorderRadius.circular(15.0)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
              ),
              const SizedBox(
                width: 10,
              ),
              // MaterialButton(
              //     minWidth: 200.0,
              //     color: m_color,
              //     shape: RoundedRectangleBorder(
              //         side: BorderSide(color: Colors.purple.shade300),
              //         borderRadius: BorderRadius.circular(15.0)),
              //     onPressed: () {
              //       Navigator.pop(context);
              //     },
              //     child: const Padding(
              //       padding: EdgeInsets.all(8.0),
              //       child: Text(
              //         "Don't save",
              //         style: TextStyle(color: Colors.white),
              //       ),
              //     )),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: MaterialButton(
                    // minWidth: 100,
                    color: m_color,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.purple.shade300),
                        borderRadius: BorderRadius.circular(15.0)),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const PatientRecord()));
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Continue",
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
