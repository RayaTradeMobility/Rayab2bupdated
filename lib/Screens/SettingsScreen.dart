// ignore_for_file: file_names

import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Constants/Constants.dart';
import 'AccountSettingsScreen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen(
      {super.key,
      required this.token,
      required this.mobile,
      required this.name});

  final String token, mobile, name;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final int _fontcolor = 0xFF031639;
  bool isSwitched = true;

  // void unsubscribeFromAllTopics() async {
  //   FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  //   RemoteMessage? initialMessage = await _firebaseMessaging.getInitialMessage();
  //   if (initialMessage != null) {
  //     Map<String, dynamic> data = initialMessage.data;
  //     if (data.containsKey('collapse_key')) {
  //       String collapseKey = data['collapse_key'];
  //       await _firebaseMessaging.unsubscribeFromTopic(collapseKey);
  //     }
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height / 16),
        child: AppBar(
          backgroundColor: MyColorsSample.fontColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(50),
            ),
          ),
          centerTitle: true,
          title: Center(
              child: const Text(
            "الاعدادات",
            style: ArabicTextStyle(arabicFont: ArabicFont.avenirArabic),
          )),
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
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextButton(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 10,
                color: Colors.white70,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(CupertinoIcons.settings),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Center(
                          child: Text(
                        "اعدادات الحساب",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(_fontcolor)),
                      )),
                      const Icon(Icons.arrow_right),
                    ],
                  ),
                ),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return AccountSettingScreen(
                    token: widget.token,
                    name: widget.name,
                    mobile: widget.mobile,
                  );
                }));
              },
            ),
            const Divider(
              thickness: 2.0,
            ),
            Row(
              children: [
                const Icon(Icons.notifications_active),
                Text(
                  'اعدادات الاشعارات',
                  style: TextStyle(
                      color: Color(_fontcolor), fontWeight: FontWeight.bold),
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'عروض',
                  style: TextStyle(color: Color(_fontcolor)),
                ),
                // Switch(
                //   value: isSwitched,
                //   onChanged: (value) {
                //     setState(() {
                //       isSwitched = value;
                //       if (isSwitched) {
                //         FirebaseMessaging.instance.subscribeToTopic('69886747923');
                //       } else {
                //         FirebaseMessaging.instance.unsubscribeFromTopic('69886747923');
                //       }
                //     });
                //   },
                //   activeTrackColor: Colors.blue,
                //   activeColor: Colors.lightBlue,
                // ),
                Switch(
                  value: isSwitched,
                  onChanged: (value) {
                    setState(
                      () {
                        isSwitched = value;
                      },
                    );
                  },
                  activeTrackColor: Colors.blue,
                  activeColor: Colors.lightBlue,
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                    child: Text(
                  'حصول اشعارات لكي احصل علي اخر العروض والخصومات',
                  style: TextStyle(color: Color(_fontcolor)),
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
