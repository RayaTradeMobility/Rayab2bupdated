// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:rayab2bupdated/API/API.dart';
import 'package:rayab2bupdated/Constants/Constants.dart';
import 'package:rayab2bupdated/Screens/BottomNavMenu.dart';
import 'package:rayab2bupdated/Screens/NavScreen.dart';
import 'package:rayab2bupdated/Screens/NotificationScreen.dart';

import 'AboutScreen.dart';
import 'ContactScreen.dart';
import 'SettingsScreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen(
      {super.key,
      required this.token,
      required this.email,
      required this.mobile,
      required this.firstname,
      required this.lastname,
      required this.customerId});

  final String token, email, mobile, firstname, lastname, customerId;

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  API api = API();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return BottomNavMenu(
              token: widget.token,
              email: widget.email,
              mobile: widget.mobile,
              firstname: widget.firstname,
              lastname: widget.lastname,
              customerId: widget.customerId,
            );
          }));
          return true;
        },
        child: Scaffold(
            body: Center(
          child: Padding(
            padding: const EdgeInsets.only(
                top: 95.0, right: 15, left: 15, bottom: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                    child: Row(
                  children: [
                    const Text(
                      "اهلا بك, ",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.firstname,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                  ],
                )),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 10,
                  color: Colors.white70,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return NotificationScreen(token: widget.token , customerId : widget.customerId);
                          }));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: MyColorsSample.primaryDark
                                      .withOpacity(0.2)),
                              child: const Icon(LineAwesomeIcons.bell)),
                          const SizedBox(
                            width: 10.0,
                          ),
                          const Center(
                              child: Text(
                            "الاشعارات",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                          const Icon(LineAwesomeIcons.angle_left),

                        ],
                      ),
                    ),
                  ),
                ),
                // TextButton(
                //   child: Card(
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(15.0),
                //     ),
                //     elevation: 10,
                //     color: Colors.white70,
                //     child: Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: Row(
                //         crossAxisAlignment: CrossAxisAlignment.center,
                //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //         children: const [
                //           Icon(CupertinoIcons.square_list_fill),
                //           SizedBox(width: 10.0,),
                //           Center(child: Text("Price List",style: TextStyle(fontWeight: FontWeight.bold,),)),
                //           Icon(LineAwesomeIcons.angle_left),
                //         ],
                //       ),
                //     ),
                //   ),
                //   onPressed: (){
                //   },
                // ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 10,
                  color: Colors.white70,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return AboutScreen(token: widget.token);
                      }));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: MyColorsSample.primaryDark
                                      .withOpacity(0.2)),
                              child: const Icon(LineAwesomeIcons.info)),
                          const SizedBox(
                            width: 10.0,
                          ),
                          const Center(
                              child: Text(
                            "حول التطبيق",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                          const Icon(LineAwesomeIcons.angle_left),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 10,
                  color: Colors.white70,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const ContactUsScreen();
                      }));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: MyColorsSample.primaryDark
                                      .withOpacity(0.2)),
                              child: const Icon(LineAwesomeIcons.user_check)),
                          const SizedBox(
                            width: 10.0,
                          ),
                          const Center(
                              child: Text(
                            "تواصل معنا",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                          const Icon(LineAwesomeIcons.angle_left),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 10,
                  color: Colors.white70,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return SettingsScreen(token: widget.token);
                      }));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: MyColorsSample.primaryDark
                                      .withOpacity(0.2)),
                              child: const Icon(LineAwesomeIcons.cog)),
                          const SizedBox(
                            width: 10.0,
                          ),
                          const Center(
                              child: Text(
                            "الاعدادات",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                          const Icon(LineAwesomeIcons.angle_left),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Row(
                    children: [
                      Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color:
                                  MyColorsSample.primaryDark.withOpacity(0.2)),
                          child: const Icon(
                            LineAwesomeIcons.alternate_sign_out,
                          )),
                      TextButton(
                        onPressed: () {
                          api.logOut(widget.token);
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return const NavScreen();
                          }));
                        },
                        child: const Text(
                          "تسجيل الخروج",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )));
  }
}
