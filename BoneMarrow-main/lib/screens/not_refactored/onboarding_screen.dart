import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'welcome_page.dart';

class OnboardingScreen extends StatefulWidget {
  OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 38.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );
    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      pages: [
        PageViewModel(
          title: "Bone Marrow Transplantation\n(BMPC)",
          body:
              "Stride is a social network for skaters - discover, share and get inspired.",
          image: Image.asset('assets/images/Splash 4.jpeg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "About App",
          body:
              " Share pictures of your latest tricks and challenges with other users, find out about upcoming events, or ask them for tips.",
          image: Image.asset('assets/images/splash6.jpeg'),
          // footer: Padding(
          //   padding:  EdgeInsets.fromLTRB(15.0, 65.0, 15.0, 0.0),
          //   child: ElevatedButton(
          //     onPressed: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => FirstPage()),
          //       );
          //     },
          //     child:  Text(
          //       'GET STARTED',
          //       style: TextStyle(
          //           color: Colors.white,
          //           fontWeight: FontWeight.bold,
          //           fontSize: 20),
          //     ),
          //     style: ElevatedButton.styleFrom(
          //       minimumSize:  Size.fromHeight(55), // NEW
          //       primary: Colors.purple.shade200,
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(8.0),
          //       ),
          //     ),
          //   ),
          // ),
          decoration: pageDecoration,
        ),
      ],
      showSkipButton: false,
      showDoneButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: true,
      skip: Text('skip',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black)),
      back: Text('Back',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black)),
      next: Text('Next',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black)),
      done: Text('Done',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black)),
      onDone: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WelcomePage()),
      ),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: EdgeInsets.all(26),
      controlsPadding: EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: DotsDecorator(
        size: Size(8.0, 8.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(15.0, 5.0),
        activeColor: Colors.black,
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
