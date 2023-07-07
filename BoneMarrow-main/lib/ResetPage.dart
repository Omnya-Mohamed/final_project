import 'package:flutter/material.dart';

import 'login+_screen.dart';

class ResetPage extends StatelessWidget {
  const ResetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "We Have sent virification link to this email check to reset your password",
              style:TextStyle(
              //  color: Colors.purple,
                fontSize: 20,
                fontWeight: FontWeight.w600
              ),
            textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16,),
            MaterialButton(
              // minWidth: 30.0,
                color: Colors.purple.shade300,
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.purple.shade300),
                    borderRadius: BorderRadius.circular(10.0)),
                onPressed: () {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => const Login_Screen()));
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0,vertical: 12),
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
