// ignore_for_file: avoid_types_as_parameter_names, file_names

import 'package:arabic_font/arabic_font.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rayab2bupdated/Screens/HomeScreen.dart';
import 'package:rayab2bupdated/Screens/ShoppingCardScreen.dart';
import 'package:rayab2bupdated/Constants/Constants.dart';
import 'CategoriesScreen.dart';
import 'OrdersScreen.dart';
import 'ProfileScreen.dart';

class BottomNavMenu extends StatefulWidget {
  const BottomNavMenu(
      {Key? key,
      required this.token,
      required this.email,
      required this.mobile,
      required this.firstname,
      required this.customerId})
      : super(key: key);
  final String token, email, mobile, firstname, customerId;

  @override
  State<BottomNavMenu> createState() => _BottomNavMenuState();
}

class _BottomNavMenuState extends State<BottomNavMenu> {
  final PageController _myPage = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        height: 50,
        color: MyColorsSample.teal,
        items: [
          Container(
            height: MediaQuery.of(context).size.height / 15,
            child: Column(
              children: <Widget>[
                Image.asset(
                  'assets/home.png',
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.height / 30,
                ),
                Text("الرئيسيه",
                    style: ArabicTextStyle(
                        arabicFont: ArabicFont.avenirArabic,
                        fontSize: 12,
                        color: Colors.white)),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 16,
            child: Column(
              children: <Widget>[
                Image.asset(
                  'assets/shopping.png',
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.height / 35,
                ),
                Text(
                  "العربه",
                  style: ArabicTextStyle(
                      arabicFont: ArabicFont.avenirArabic,
                      fontSize: 12,
                      color: Colors.white),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 16,
            child: Column(
              children: <Widget>[
                Image.asset(
                  'assets/category.png',
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.height / 35,
                ),
                Text(
                  "الاقسام",
                  style: ArabicTextStyle(
                      arabicFont: ArabicFont.avenirArabic,
                      fontSize: 12,
                      color: Colors.white),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 16,
            child: Column(
              children: <Widget>[
                Image.asset(
                  'assets/order.png',
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.height / 35,
                ),
                Text(
                  "طلباتي",
                  style: ArabicTextStyle(
                      arabicFont: ArabicFont.avenirArabic,
                      fontSize: 12,
                      color: Colors.white),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 16,
            child: Column(
              children: [
                Image.asset(
                  'assets/profile.png',
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.height / 35,
                ),
                Text(
                  "حسابي",
                  style: ArabicTextStyle(
                      arabicFont: ArabicFont.avenirArabic,
                      fontSize: 12,
                      color: Colors.white),
                ),
              ],
            ),
          ),
        ],
        onTap: (index) {
          _myPage.jumpToPage(index);
        },
      ),
      body: PageView(
        allowImplicitScrolling: false,
        pageSnapping: true,
        reverse: false,
        physics: const NeverScrollableScrollPhysics(),
        controller: _myPage,
        onPageChanged: (int) {
          setState(() {});
          if (kDebugMode) {
            print('Page Changes to index $int');
          }
        },
        children: <Widget>[
          HomeScreen(
            token: widget.token,
            mobile: widget.mobile,
            firstname: widget.firstname,
            email: widget.email,
            customerId: widget.customerId,
          ),
          ShoppingCardScreen(
            token: widget.token,
            email: widget.email,
            firstname: widget.firstname,
            mobile: widget.mobile,
            customerId: widget.customerId,
          ),
          CategoriesScreen(
            token: widget.token,
            mobile: widget.mobile,
            firstname: widget.firstname,
            email: widget.email,
            customerId: widget.customerId,
          ),
          OrdersScreen(
            token: widget.token,
            mobile: widget.mobile,
            firstname: widget.firstname,
            email: widget.email,
            customerId: widget.customerId,
            orderId: '',
          ),
          ProfileScreen(
            token: widget.token,
            email: widget.email,
            mobile: widget.mobile,
            firstname: widget.firstname,
            customerId: widget.customerId,
          )
        ],
      ),
    );
  }
}
