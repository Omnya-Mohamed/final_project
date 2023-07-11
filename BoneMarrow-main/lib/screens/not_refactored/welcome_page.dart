import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:g_project/screens/not_refactored/registerScreen.dart';

import '../login_screen.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
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
              child: Center(
                  child: Image.asset(
                "assets/images/F_image.png",
                width: 350,
                height: 350,
              )),
            ),
          ),
          SizedBox(height: 30.0),
          Center(
            child: Container(
              child: Text("Welcome Doctor..",
                  style: TextStyle(fontSize: 30, color: Colors.purple)),
            ),
          ),
          SizedBox(height: 30.0),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: SizedBox(
                    width: 165,
                    height: 45,
                    child: MaterialButton(
                        //  minWidth: 20.0,
                        color:
                            SwitchColor ? Colors.purple.shade300 : Colors.white,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(30.0)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Login_Screen()),
                          );
                          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => DoctorRegist()));
                          setState(() {
                            SwitchColor = !SwitchColor;
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Login ",
                            style: TextStyle(color: Colors.black),
                          ),
                        )),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: SizedBox(
                    width: 165,
                    height: 45,
                    child: MaterialButton(
                        //minWidth: 20.0,
                        color:
                            SwitchColor ? Colors.white : Colors.purple.shade300,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(15.0)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DoctorRegisterScreen()),
                          );
                          setState(() {
                            SwitchColor = !SwitchColor;
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Sing Up",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
