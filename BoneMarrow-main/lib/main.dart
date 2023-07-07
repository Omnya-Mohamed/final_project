import 'package:flutter/material.dart';
import 'package:g_project/api_final_edit.dart';
import 'package:g_project/diohelper.dart';
import 'package:g_project/shared_pref.dart';
import 'package:g_project/splash_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Prediction_Screen1.dart';
import 'addPatient_screen.dart';
//import 'homePage.dart';
import 'home_screen.dart';

late SharedPreferences shared;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  CashHelper.init();
  ApiHealperFinalEdit.editPatient(
      id: 5,
      address: "sssssssssssssss",
      phoneNumber: "55555",
      gender: "male",
      profilePhoto: null,
      age: 8,
      birthDate: "5-10-2001",
      name: "mmmm");
/* ApiHealperFinalEdit.addPatient(
      nid: "30201851238943",
      address: "bns",
      phoneNumber: "01150335243",
      gender: "female",
      profilePhoto: null,
      age: 21,
      birthDate: "5-1-2002",
      name: "oma");
  ApiHealperFinalEdit.getPatientsLists();

  shared = await SharedPreferences.getInstance();
  runApp(MyApp());*/
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: splashScreen());
  }
}
