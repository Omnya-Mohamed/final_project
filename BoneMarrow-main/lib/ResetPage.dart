import 'package:flutter/material.dart';
import 'package:g_project/shared/constansts.dart/app_colors.dart';

import 'login+_screen.dart';

class ResetPage extends StatelessWidget {
  ResetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          "We Have sent virification link to this email check to reset your password",
          style: TextStyle(
              //  color: Colors.purple,
              fontSize: 20,
              fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 16,
        ),
        MaterialButton(
            // minWidth: 30.0,
            color: Colors.purple.shade300,
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.purple.shade300),
                borderRadius: BorderRadius.circular(10.0)),
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => Login_Screen()));
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
              child: Text(
                "ok",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ))
      ]),
    );
  }
}
