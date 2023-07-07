import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:g_project/widget/fields.dart';

import 'nav_drawer.dart';

//import 'package:managment/data/model/add_date.dart';
//import 'package:hive_flutter/hive_flutter.dart';

class Home_Page extends StatefulWidget {
  //const Prediction_Screen({super.key});

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  final _bottomNavigationKey = GlobalKey<CurvedNavigationBarState>();
  int index = 0;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            background_container(context),
            Positioned(
              top: 120,
              child: main_container(),
            ),
          ],
        ),
      ),
      drawer: NavDrawer(),
      bottomNavigationBar: CurvedNavigationBar(
        color:b_color!,
        backgroundColor: Colors.white,
        height: 30,
        index: index,
        items: const [
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
          // Icon(
          //   Icons.settings,
          //   size: 20,
          //   color: Colors.white,
          // ),
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
    );
  }

  Container main_container() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
      ),
      height: 400,
      width: 340,
      child: const Column(
        children:[
          SizedBox(
            height: 10,
          ),
          Column(
            children: [
              CircleAvatar(
                  radius: 70,
                  backgroundImage:
                      AssetImage('assets/images/Bone_marrow_biopsy.jpg')),
              Text("Classification",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25, ),)
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            children: [
              CircleAvatar(
                  radius: 70,
                  backgroundImage:
                      AssetImage('assets/images/Bone_marrow_biopsy.jpg')),
              Text(
                "Prediction",
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25, ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Column background_container(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 240,
          decoration: BoxDecoration(
            color: b_color!,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 40),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    Text(
                      'Patient Information',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    Icon(
                      Icons.notification_add,
                      color: Colors.white,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
