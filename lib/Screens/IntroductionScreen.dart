// ignore_for_file: file_names

import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import '../Constants/Constants.dart';
import 'BottomNavMenu.dart';

class IntroductionScreens extends StatelessWidget {
  const IntroductionScreens(
      {Key? key,
      required this.token,
      required this.email,
      required this.mobile,
      required this.firstname,
      required this.customerId})
      : super(key: key);
  final String token, email, mobile, firstname, customerId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height / 16),
        child: AppBar(
          backgroundColor: MyColorsSample.fontColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(50),
            ),
          ),
          centerTitle: true,
          title: Center(
            child: const Text(
              "مقدمه",
              style: ArabicTextStyle(arabicFont: ArabicFont.avenirArabic),
            ),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  MyColorsSample.primary,
                  MyColorsSample.teal,
                ],
              ),
            ),
          ),
        ),
      ),
      body: IntroductionScreen(
          pages: [
            PageViewModel(
              title: '  ',
              body: 'رايه للتوزيع برنامج لتجاره البضاعه و صناعه الارباح',
              image: buildImage(
                'assets/panel1.png',
              ),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: '',
              body: 'رايه للتوزيع برنامج لتجاره البضاعه و صناعه الارباح',
              image: buildImage("assets/About_Img.jpeg"),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: '',
              body: 'رايه للتوزيع برنامج لتجاره البضاعه و صناعه الارباح',
              image: buildImage("assets/aboutimg3.jpg"),
              decoration: getPageDecoration(),
            ),
          ],
          onDone: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return BottomNavMenu(
                token: token,
                email: email,
                firstname: firstname,
                mobile: mobile,
                customerId: customerId.toString(),
              );
            }));
          },
          onSkip: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return BottomNavMenu(
                token: token,
                email: email,
                firstname: firstname,
                mobile: mobile,
                customerId: customerId.toString(),
              );
            }));
          },
          scrollPhysics: const ClampingScrollPhysics(),
          showDoneButton: true,
          showNextButton: true,
          showSkipButton: true,
          skip:
              const Text("Skip", style: TextStyle(fontWeight: FontWeight.w600)),
          next: const Icon(Icons.forward),
          done:
              const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
          dotsDecorator: getDotsDecorator()),
    );
  }

  Widget buildImage(String imagePath) {
    return Center(
        child: Image.asset(
      imagePath,
      width: 450,
      height: 200,
    ));
  }

  PageDecoration getPageDecoration() {
    return const PageDecoration(
      imagePadding: EdgeInsets.only(top: 120),
      pageColor: Colors.white,
      bodyPadding: EdgeInsets.only(top: 8, left: 20, right: 20),
      titlePadding: EdgeInsets.only(top: 50),
      bodyTextStyle: TextStyle(color: Colors.black54, fontSize: 15),
    );
  }

  DotsDecorator getDotsDecorator() {
    return const DotsDecorator(
      spacing: EdgeInsets.symmetric(horizontal: 2),
      activeColor: Colors.indigo,
      color: Colors.grey,
      activeSize: Size(12, 5),
      activeShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
    );
  }
}
