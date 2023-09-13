// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'LoginScreen.dart';
import 'RegisterScreen.dart';

class NavScreen extends StatelessWidget {
  final int _fontcolor = 0xFF031639;

  const NavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/background.jpeg"), fit: BoxFit.fill),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20.0),
              const Expanded(
                child: Padding(
                    padding: EdgeInsets.only(left: 250.0),
                    child: const Text(
                      '',
                      style: TextStyle(fontSize: 18.0),
                    )),
              ),
              const SizedBox(
                height: 280,
              ),
              Expanded(
                  child: Text(
                'اهلا بك في رايه للتوزيع',
                style: TextStyle(color: Color(_fontcolor), fontSize: 20.0),
              )),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                  child: Text(
                'تسوق الان واشتري منتجات وتمتع بالعروض ',
                style: TextStyle(color: Color(_fontcolor), fontSize: 16.0),
              )),
              const SizedBox(
                height: 10.0,
              ),
              SizedBox(
                width: 300.0,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const LoginScreen();
                    }));
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color(_fontcolor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                  child: const Text("تسجيل الدخول"),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const RegisterScreen();
                    }));
                  },
                  style:
                      TextButton.styleFrom(foregroundColor: Color(_fontcolor)),
                  child: const Text('تسجيل حساب جديد'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
