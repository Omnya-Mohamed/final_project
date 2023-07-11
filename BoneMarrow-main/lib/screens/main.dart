import 'package:flutter/material.dart';
import 'package:g_project/core/repos/dio_helper.dart';
import 'package:g_project/core/repos/shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'homePage.dart';
import 'main_bottom_navigation_bar.dart';
import 'not_refactored/splash_Screen.dart';

late SharedPreferences shared;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  CacheHelper.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: splashScreen());
  }
}
