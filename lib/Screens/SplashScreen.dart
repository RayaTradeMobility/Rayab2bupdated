import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:rayab2bupdated/API/API.dart';
import 'package:rayab2bupdated/Screens/NavScreen.dart';
import '../Constants/Constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  API api = API();

  @override
  void initState() {
    super.initState();
    api.checkNetwork();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.centerRight,
                colors: [
                  MyColorsSample.primary,
                  MyColorsSample.primary.withOpacity(0.9),
                  MyColorsSample.teal.withOpacity(0.85),
                  MyColorsSample.teal,
                ],
              ),
            ),
          ),
          AnimatedSplashScreen(
            backgroundColor: Colors.transparent,
            splash: Image.asset("assets/splashscreen1.png"),
            nextScreen: const NavScreen(),
            duration: 3000,
            splashTransition: SplashTransition.rotationTransition,
            splashIconSize: 900,
          ),
        ],
      ),
    );
  }
}
