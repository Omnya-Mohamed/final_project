import 'package:carousel_slider/carousel_slider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  final _bottomNavigationKey = GlobalKey<CurvedNavigationBarState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.deepPurple[300],
        leading:
            IconButton(icon: Icon(Icons.menu), onPressed: () => print("menu")),
        actions: [
          IconButton(icon: Icon(Icons.settings), onPressed: () => print("menu"))
        ],
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              color: Colors.deepPurple[300],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 200,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
            ),
          ),
          Column(
           //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Align(
                  alignment: Alignment.topCenter,
                  child: CardList()
              ),
              //LastInvestment(),
             // Deposits(),
              SizedBox(height: 25,),
              Text("about process"),
              ],
          ),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.purple.shade200,
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
}

class CardList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CarouselSlider.builder(
        itemCount:2,
        itemBuilder: (BuildContext context, int i, int itemIndex) {
          return Container(
            color: Colors.red,
          );
        },
        options: CarouselOptions(
             initialPage: 0,
            enableInfiniteScroll: false,
            enlargeCenterPage: true),
      ),
    );
  }
}

