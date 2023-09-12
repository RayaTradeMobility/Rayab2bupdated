// ignore_for_file: file_names

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:rayab2bupdated/API/API.dart';
import 'package:rayab2bupdated/Screens/NavScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  API api = API();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    api.checkNetwork();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedSplashScreen(
          splash: Image.asset("assets/splashscreen1.png"),
          nextScreen: const NavScreen(),
          duration: 3000,
          splashTransition: SplashTransition.rotationTransition,
        ),
      ),
    );
  }
}