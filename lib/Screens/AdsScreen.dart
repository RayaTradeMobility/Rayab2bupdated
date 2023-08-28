// ignore_for_file: file_names

import 'package:flutter/material.dart';

class AdsScreen extends StatefulWidget {
  const AdsScreen({Key? key}) : super(key: key);

  @override
  State<AdsScreen> createState() => _AdsScreenState();
}

class _AdsScreenState extends State<AdsScreen> {
  final int _fontColor = 0xFF031639;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image.asset(
          'assets/logo-raya.png',
          width: 70.0,
          height: 70.0,
        ),
        centerTitle: true,
        leading: TextButton(
          onPressed: () {},
          child: const Text("تخطي"),
        ),
      ),
      body: Column(children: [
        Image.asset("assets/imgoffer.png"),
        const SizedBox(
          height: 30,
        ),
        Text(
          " العرض ",
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Color(_fontColor)),
        )
      ]),
    );
  }
}
