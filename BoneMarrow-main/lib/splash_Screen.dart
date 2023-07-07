import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'onboarding_screen.dart';

class splashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
          splashIconSize: 600,
          duration: 5000,
          splash: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/S_image.png',
                width: 400,
                height: 400,
                fit: BoxFit.fill,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Loading",style: TextStyle(fontSize: 25),),
                  Lottie.asset("assets/images/loading.json",
                      width: 200, height: 200),
                ],
              )
            ],
          ),
          nextScreen: const OnboardingScreen(),
          // splashTransition: SplashTransition.fadeTransition,
          // pageTransitionType: PageTransitionType.scale,
          backgroundColor: Colors.white),
    );
  }
}
