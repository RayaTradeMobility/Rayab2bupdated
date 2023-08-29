// ignore_for_file: avoid_types_as_parameter_names, file_names

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
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
      required this.lastname,
      required this.customerId})
      : super(key: key);
  final String token, email, mobile, firstname, lastname, customerId;

  @override
  State<BottomNavMenu> createState() => _BottomNavMenuState();
}

class _BottomNavMenuState extends State<BottomNavMenu> {
  final PageController _myPage = PageController(initialPage: 0);
  final Color _iconColor = Colors.white;
  final Color _iconColor2 = Colors.white;
  final Color _iconColor3 = Colors.white;
  final Color _iconColor4 = Colors.white;
  final Color _iconColor5 = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        height: 50,
        color: MyColorsSample.fontColor,
        items: [
          Icon(LineAwesomeIcons.home, size: 30.0, color: _iconColor),
          Icon(
            LineAwesomeIcons.shopping_cart,
            size: 30.0,
            color: _iconColor2,
          ),
          Icon(LineAwesomeIcons.archive, size: 30.0, color: _iconColor4),
          Icon(LineAwesomeIcons.table, size: 30.0, color: _iconColor3),
          Icon(LineAwesomeIcons.user, size: 30.0, color: _iconColor5),
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
            lastname: widget.lastname,
            firstname: widget.firstname,
            email: widget.email,
            customerId: widget.customerId,
          ),
          ShoppingCardScreen(
            token: widget.token,
            email: widget.email,
            firstname: widget.firstname,
            lastname: widget.lastname,
            mobile: widget.mobile,
            street: '',
            city: '',
            customerId: widget.customerId,
          ),
          CategoriesScreen(
            token: widget.token,
            mobile: widget.mobile,
            lastname: widget.lastname,
            firstname: widget.firstname,
            email: widget.email,
            customerId: widget.customerId,
          ),
          OrdersScreen(
            token: widget.token,
            mobile: widget.mobile,
            lastname: widget.lastname,
            firstname: widget.firstname,
            email: widget.email,
            customerId: widget.customerId,
            orderId: '',
          ),
          ProfileScreen(
            token: widget.token,
            email: widget.email,
            mobile: widget.mobile,
            lastname: widget.lastname,
            firstname: widget.firstname,
            customerId: widget.customerId,
          )
        ],
        // physics: NeverScrollableScrollPhysics(), // Comment this if you need to use Swipe.
      ),
    );
  }
}
