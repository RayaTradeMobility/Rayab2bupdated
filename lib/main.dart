import 'package:flutter/material.dart';

import 'Screens/SplashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import '../API/API.dart';

API api = API();
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await  Firebase.initializeApp();
  await  api.initNotification();
  runApp(
    MaterialApp(
      builder: (context, child) {
        return Directionality(textDirection: TextDirection.rtl, child: child!);
      },
      home: const MyApp(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}
