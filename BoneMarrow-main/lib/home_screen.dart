import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:g_project/classification_screen.dart';
import 'package:g_project/search_screen.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';
import 'package:readmore/readmore.dart';
import 'api_final_edit.dart';
import 'prediction_screen.dart';
import 'nav_drawer.dart';
import 'profileScreen.dart';
import 'widget/fields.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class _HomePageScreenState extends State<HomePageScreen> {
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
      homeWidget(context),
      const ProfileScreen(),
      const SearchPage(isappbar: false),
      const Center(
        child: Text("Statistics"),
      ),
    ];

    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        //appBar: AppBar(title: Text(titles[index]),),
        appBar: (index != 0)
            ? AppBar(
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
              )
            : null,
        body: screens[index],
        drawer: const NavDrawer(),
        bottomNavigationBar: CurvedNavigationBar(
          color: m_color!,
          backgroundColor: Colors.white,
          height: 50,
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

  Widget homeWidget(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Stack(
                children: [
                  ClipPath(
                    clipper: ProsteBezierCurve(
                      position: ClipPosition.bottom,
                      list: [
                        BezierCurveSection(
                          start: const Offset(0, 100),
                          top: Offset(screenWidth / 2, 70),
                          end: Offset(screenWidth, 100),
                        ),
                      ],
                    ),
                    child: Container(
                      height: 200,
                      color: Colors.deepPurple[300],
                    ),
                  ),
                  const Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Dashboard",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
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
                          child: Column(children: [
                            Row(
                              children: [
                                CircularPercentIndicator(
                                  radius: 80.0,
                                  lineWidth: 15.0,
                                  animation: true,
                                  percent: 0.7,
                                  center: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        patientsCount.toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0),
                                      ),
                                      const Text(
                                        "Patients",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17.0),
                                      ),
                                    ],
                                  ),
                                  circularStrokeCap: CircularStrokeCap.round,
                                  progressColor: Colors.deepPurple[300],
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                const Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        "About",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22.0),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      ReadMoreText(
                                        "Anatomy of the bone. The bone is made up of compact bone, spongy bone, and bone marrow. Compact bone makes up the outer layer of the bone. Spongy bone is found mostly at the ends of bones and contains red marrow. Bone marrow is found in the center of most bones and has many blood vessels. There are two types of bone marrow: red and yellow. Red marrow contains blood stem cells that can become red blood cells, white blood cells, or platelets. Yellow marrow is made mostly of fat.",
                                        trimLines: 6,
                                        colorClickableText: Colors.pink,
                                        trimMode: TrimMode.Line,
                                        trimCollapsedText: 'Show more',
                                        trimExpandedText: '..Show less',
                                        textAlign: TextAlign.justify,
                                        moreStyle: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Processes",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ClassificationScreen()));
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              elevation: 40,
                              child: Row(
                                children: [
                                  CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      radius: 50,
                                      child: Image.network(
                                        'https://cdn-icons-png.flaticon.com/512/5454/5454211.png',
                                        height: 80,
                                      )),
                                  const Expanded(
                                    child: ListTile(
                                      title: Text(
                                        'Classification',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text(
                                          'Accurately discerning the type of cell.'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const PredictionScreen()));
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              elevation: 20,
                              child: const Row(
                                children: [
                                  CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      radius: 50,
                                      backgroundImage: NetworkImage(
                                        'https://cdn-icons-png.flaticon.com/512/4745/4745817.png',
                                      )),
                                  Expanded(
                                    child: ListTile(
                                      title: Text(
                                        'Prediction',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text(
                                          "The degree of success and failure observed in the transplantation process."),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
