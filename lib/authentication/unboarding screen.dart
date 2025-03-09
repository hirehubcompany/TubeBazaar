import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:tubebazaar/authentication/landing.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: IntroductionScreen(
        pages: [

          PageViewModel(
            title: "Welcome to TubeBazaar!",
            body: "Buy and sell YouTube channels securely with our escrow system.",
            image: Center(
              child: Image.asset("assets/images/logo.png", height: 250),
            ),
            decoration: PageDecoration(
              titleTextStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              bodyTextStyle: TextStyle(fontSize: 16),
            ),
          ),

          PageViewModel(
            title: "Welcome to TubeBazaar!",
            body: "Buy and sell YouTube channels securely with our escrow system.",
            image: Center(
              child: Image.asset("assets/images/logo.png", height: 250),
            ),
            decoration: PageDecoration(
              titleTextStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              bodyTextStyle: TextStyle(fontSize: 16),
            ),
          ),

          PageViewModel(
            title: "Welcome to TubeBazaar!",
            body: "Buy and sell YouTube channels securely with our escrow system.",
            image: Center(
              child: Image.asset("assets/images/logo.png", height: 250),
            ),
            decoration: PageDecoration(
              titleTextStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              bodyTextStyle: TextStyle(fontSize: 16),
            ),
          ),

          PageViewModel(
            title: "Welcome to TubeBazaar!",
            body: "Buy and sell YouTube channels securely with our escrow system.",
            image: Center(
              child: Image.asset("assets/images/logo.png", height: 250),
            ),
            decoration: PageDecoration(
              titleTextStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              bodyTextStyle: TextStyle(fontSize: 16),
            ),
          ),
        ],
        done: Text("Get Started", style: TextStyle(fontWeight: FontWeight.w600)),
        onDone: () {
          // Navigate to home or login screen
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return LandingPage();
          }));
        },
        showSkipButton: true,
        skip: Text("Skip"),
        next: Icon(Icons.arrow_forward),
        dotsDecorator: DotsDecorator(
          size: Size(10.0, 10.0),
          color: Colors.grey,
          activeSize: Size(22.0, 10.0),
          activeColor: Colors.blue,
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
      ),
    );
  }
}
