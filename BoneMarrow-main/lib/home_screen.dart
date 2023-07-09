import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:g_project/classification_screen.dart';
import 'package:g_project/search_screen.dart';

//import 'package:widgets/utils/colors.dart';
//import 'package:widgets/view/home.dart';
//import 'package:widgets/widgets/reorderable_listview.dart';
//import 'package:widgets/widgets/spinkit_splash.dart';

import 'prediction_screen.dart';
import 'nav_drawer.dart';
import 'profileScreen.dart';
import 'widget/fields.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  int index = 0;
  final _bottomNavigationKey = GlobalKey<CurvedNavigationBarState>();

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      homeWidget(context),
      ProfileScreen(),
      const SearchPage(isappbar: false),
      const Center(
        child: Text("Statistics"),
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      //appBar: AppBar(title: Text(titles[index]),),
      appBar: AppBar(
        title: const Center(
            child: Text("Hello Doctor !",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 28))),
        backgroundColor: Colors.white,
        //elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black),
        //title:
      ),
      body: screens[index],
      drawer: NavDrawer(),
      bottomNavigationBar: CurvedNavigationBar(
        color: m_color!,
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

  Widget homeWidget(BuildContext context) {
    return ListView(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(100),
              bottomLeft: Radius.circular(100),
            )),
            child: const Column(children: [
              Text(
                "About  Processes",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(
                height: 14,
              ),
              Center(
                child: Text(
                  " Anatomy of the bone. The bone is made up of compact bone, spongy bone, and bone marrow. Compact bone makes up the outer layer of the bone. Spongy bone is found mostly at the ends of bones and contains red marrow. Bone marrow is found in the center of most bones and has many blood vessels. There are two types of bone marrow: red and yellow. Red marrow contains blood stem cells that can become red blood cells, white blood cells, or platelets. Yellow marrow is made mostly of fat.",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(
                height: 25,
              ),
            ]),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ClassificationScreen()));
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 40,
                  child: const Column(
                    children: [
                      CircleAvatar(
                          radius: 70,
                          backgroundImage: AssetImage(
                            'assets/images/cells.jpg',
                          )),
                      // ClipRRect(
                      //   borderRadius: const BorderRadius.only(
                      //     topLeft: Radius.circular(10),
                      //     topRight: Radius.circular(10),
                      //   ),
                      //   child: Image.asset(
                      //     "assets/images/cells.jpg",
                      //     height: 130,
                      //     width: MediaQuery.of(context).size.width,
                      //     fit: BoxFit.fill,
                      //   ),
                      // ),
                      ListTile(
                        title: Text(
                          'Classification',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        //   subtitle: Text("45K"),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: TextButton(
                      //     onPressed: () {
                      //       Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //               builder: (context) => Classification()));
                      //     },
                      //     style: TextButton.styleFrom(
                      //         backgroundColor: m_color,
                      //         minimumSize:
                      //             Size(MediaQuery.of(context).size.width, 40)),
                      //     child: const Text(
                      //       'Go Process',
                      //       style: TextStyle(color: Colors.white),
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 25,
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PredictionScreen()));
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 20,
                  child: const Column(
                    children: [
                      CircleAvatar(
                          radius: 70,
                          backgroundImage: AssetImage(
                            'assets/images/Bone_marrow_biopsy.jpg',
                          )),
                      // ClipRRect(
                      //   borderRadius: const BorderRadius.only(
                      //     topLeft: Radius.circular(10),
                      //     topRight: Radius.circular(10),
                      //   ),
                      //   child: Image.asset(
                      //     "assets/images/Bone_marrow_biopsy.jpg",
                      //     height: 130,
                      //     width: MediaQuery.of(context).size.width,
                      //     fit: BoxFit.fill,
                      //   ),
                      // ),
                      ListTile(
                        title: Text(
                          'Prediction',
                          style: TextStyle(fontSize: 20),
                        ),
                        // subtitle: Text(
                        //   '30 k',
                        // ),
                      ),
                      //               builder: (context) => Prediction_Screen()));
                      //     },
                      //     style: TextButton.styleFrom(
                      //         backgroundColor: m_color,
                      //         minimumSize:
                      //             Size(MediaQuery.of(context).size.width, 40)),
                      //     child: const Text(
                      //       'Go Process',
                      //       style: TextStyle(color: Colors.white),
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
