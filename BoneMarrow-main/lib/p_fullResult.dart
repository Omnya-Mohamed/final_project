import 'package:flutter/material.dart';
import 'package:g_project/widget/fields.dart';

import 'home_screen.dart';
import 'p_Record.dart';
class FullResult extends StatefulWidget {
 // final String PName;
 // final String result;
   var Gender;
   var age;
   var image;

  @override
  State<FullResult> createState() => _FullResultState();
}

class _FullResultState extends State<FullResult> {
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
      body:Column(
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
            //  mainAxisAlignment: MainAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
             // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              Text("Result : ",style:t_style),
                //SizedBox(height:10,),
                Text("Patient Name :  ",style:t_style),
                //SizedBox(height: 3,),
                Text("Patient Age :",style:t_style),
               // SizedBox(height: 3,),
                Text("Gender :",style:t_style),
               // SizedBox(height: 3,),
                Text("phone :",style:t_style),
               // SizedBox(height: 3,),
                Text("Address :",style:t_style),
              ],
            ),
          ),
          const SizedBox(height: 16,),
          Row(
            //mainAxisAlignment:MainAxisAlignment.center ,
            //crossAxisAlignment: CrossAxisAlignment.center,
             children: [
              Expanded(
                child: MaterialButton(
                  minWidth: 200,
                    color:SwitchColor? Colors.purple.shade300:Colors.white,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.purple.shade300),
                        borderRadius: BorderRadius.circular(15.0)),
                    onPressed:(){
                      setState(() {
                        SwitchColor =! SwitchColor;
                      });
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Save",
                        style: TextStyle(color: Colors.black),
                      ),
                    )),
              ),
              const SizedBox(width: 10,),
              Expanded(child: MaterialButton(
                  minWidth: 200.0,
                  color: SwitchColor? Colors.purple.shade300:Colors.white,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.purple.shade300),
                      borderRadius: BorderRadius.circular(15.0)),
                  onPressed:(){
                    setState(() {
                      SwitchColor =! SwitchColor;
                    });
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) =>HomePage()

                    ));
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Don't save",
                      style: TextStyle(color: Colors.black),
                    ),
                  )),),
              const SizedBox(width: 10,),
              Expanded(child: MaterialButton(
                  minWidth: 200,
                  color:SwitchColor? Colors.purple.shade300:Colors.white,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.purple.shade300),
                      borderRadius: BorderRadius.circular(15.0)),
                  onPressed:(){
                    setState(() {
                      SwitchColor =! SwitchColor;
                    });
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) =>
                       PatientRecord()
                      ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Continue",
                      style: TextStyle(color: Colors.black),
                    ),
                  )),)
          ],),
        ],
      ) ,
    );
  }
}
