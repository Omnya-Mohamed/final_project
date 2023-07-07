import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:g_project/registerScreen.dart';

import 'login+_screen.dart';
class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  bool SwitchColor = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          ClipPath(
            clipper: WaveClipperOne(),
            child: Container(
              height: 400,
              color: Colors.purple.shade300,
              child: Center(child:Image.asset("assets/images/F_image.png",width: 350,height: 350,)),
            ),
          ),
          SizedBox(height: 30.0),
         Center(
           child: Container(
             child:Text("Welcome Doctor..",
                 style: TextStyle(fontSize: 30,color: Colors.purple)) ,
           ),
         ),


          SizedBox(height: 30.0),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    width: 165,
                    height: 45,
                    child: MaterialButton(
                      //  minWidth: 20.0,
                        color: SwitchColor? Colors.purple.shade300:Colors.white,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(30.0)),
                        onPressed:(){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                const Login_Screen()),
                          );
                         // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => DoctorRegist()));
                          setState(() {
                            SwitchColor =! SwitchColor;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Login ",
                            style: TextStyle(color: Colors.black),
                          ),
                        )),
                  ),
                ),
                SizedBox(width: 20),
               Expanded(child:  Container(
                 width: 165,
                 height: 45,
                 child: MaterialButton(
                   //minWidth: 20.0,
                     color: SwitchColor? Colors.white:Colors.purple.shade300,
                     shape: RoundedRectangleBorder(
                         side: BorderSide(color: Colors.white),
                         borderRadius: BorderRadius.circular(15.0)),
                     onPressed:(){
                       Navigator.push(
                         context,
                         MaterialPageRoute(
                             builder: (context) =>
                             const DoctorRegist()),
                       );
                       setState(() {
                         SwitchColor =! SwitchColor;
                       });
                     },
                     child: Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Text(
                         "Sing Up",
                         style: TextStyle(color: Colors.black,fontWeight:
                         FontWeight.bold
                         ),
                       ),
                     )),
               ),)
              ],
            ),
          ),
        ],
      ),
    );
  }
}


