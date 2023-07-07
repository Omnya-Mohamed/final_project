import 'package:flutter/material.dart';
import 'package:g_project/api_final_edit.dart';
import 'package:g_project/diohelper.dart';
import 'package:g_project/shared_pref.dart';
import 'package:g_project/splash_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'prediction_screen.dart';
import 'addPatient_screen.dart';
//import 'homePage.dart';
import 'home_screen.dart';

late SharedPreferences shared;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  CashHelper.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: splashScreen());
  }
}
