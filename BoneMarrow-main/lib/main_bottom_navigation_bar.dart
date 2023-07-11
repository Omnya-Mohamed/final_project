import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:g_project/screens/home_screen.dart';
import 'package:g_project/search_screen.dart';
import 'package:g_project/widget/fields.dart';
import 'api_final_edit.dart';
import 'nav_drawer.dart';
import 'profileScreen.dart';

class MainBottomNavigationBar extends StatefulWidget {
  MainBottomNavigationBar({super.key});

  @override
  State<MainBottomNavigationBar> createState() =>
      _MainBottomNavigationBarState();
}

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class _MainBottomNavigationBarState extends State<MainBottomNavigationBar> {
  int index = 0;
  int? patientsCount;
  @override
  void initState() {
    var result = ApiHelperFinalEdit.getPatientsCount().then((value) {
      setState(() {
        patientsCount = value;
      });
    });
    super.initState();
  }

  final _bottomNavigationKey = GlobalKey<CurvedNavigationBarState>();

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      HomeScreen(),
      ProfileScreen(),
      SearchPage(isappbar: false),
      Center(
        child: Text("Statistics"),
      ),
    ];

    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: (index == 0) ? true : false,
        key: scaffoldKey,
        backgroundColor: Colors.white,
        //appBar: AppBar(title: Text(titles[index]),),
        appBar: (index == 0)
            ? AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                iconTheme: IconThemeData(color: Colors.white),
                //title:
              )
            : AppBar(
                title: Center(
                    child: Text("Hello Doctor !",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 28))),
                backgroundColor: Colors.white,
                //elevation: 0.0,
                iconTheme: IconThemeData(color: Colors.black),
                //title:
              ),
        // : null,
        body: screens[index],
        drawer: NavDrawer(),
        bottomNavigationBar: CurvedNavigationBar(
          color: m_color!,
          backgroundColor: Colors.transparent,
          height: 50,
          index: index,
          items: [
            Icon(
              Icons.home,
              size: 20,
              color: Colors.white,
            ),
            Icon(
              Icons.person,
              size: 20,
              color: Colors.white,
            ),
            Icon(
              Icons.search,
              size: 20,
              color: Colors.white,
            ),
            Icon(
              Icons.stacked_bar_chart,
              size: 20,
              color: Colors.white,
            )
          ],
          key: _bottomNavigationKey,
          onTap: (index) => setState(() {
            this.index = index;
          }),
        ),
      ),
    );
  }
}
