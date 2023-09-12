// ignore_for_file: file_names

import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/material.dart';

import '../Constants/Constants.dart';
import 'ForgotPasswordScreen.dart';

class AccountSettingScreen extends StatefulWidget {
  const AccountSettingScreen(
      {super.key,
      required this.token,
      required this.name,
      required this.mobile});

  final String token, name, mobile;

  @override
  State<AccountSettingScreen> createState() => _AccountSettingScreenState();
}

class _AccountSettingScreenState extends State<AccountSettingScreen> {
  final int _fontcolor = 0xFF031639;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
          title: Center(child: const Text("اعدادات الحساب" , style: ArabicTextStyle(arabicFont: ArabicFont.avenirArabic),) ),
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'الاسم بالكامل',
                  style: TextStyle(color: Color(_fontcolor)),
                ),
                Text(
                  widget.name,
                  style: TextStyle(color: Color(_fontcolor)),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),

            // TextButton(
            //   onPressed: () {},
            //   child: const Text('تعديل'),
            // ),
            const Divider(
              thickness: 2.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'رقم التليفون',
                  style: TextStyle(color: Color(_fontcolor)),
                ),
                Text(widget.mobile,
                    style: TextStyle(
                      color: Color(_fontcolor),
                    ))
              ],
            ),
            const SizedBox(
              height: 14,
            ),
            Row(
              children: [
                const Icon(
                  Icons.warning,
                  color: Colors.lightBlue,
                ),
                Flexible(
                    child: Text(
                  "لا يمكنك تغيير رقم الموبايل لو اردت ذلك لمكنك عمل حساب شخصي جديد",
                  style: TextStyle(color: Color(_fontcolor)),
                ))
              ],
            ),
            const Divider(
              thickness: 2.0,
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
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           const Icon(Icons.email),
            //           const Text(
            //             "غير البريد الشخصي",
            //             style: TextStyle(
            //               fontWeight: FontWeight.bold,
            //             ),
            //           ),
            //           Text('البريد',
            //               style: TextStyle(
            //                   color: Color(_fontcolor), fontSize: 8.0)),
            //           const Icon(Icons.arrow_right),
            //         ],
            //       ),
            //     ),
            //   ),
            //   onPressed: () {},
            // ),
            TextButton(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 10,
                color: Colors.white70,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.lock),
                      Center(
                          child: Text(
                        "تغيير الباسورد",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                      Icon(Icons.arrow_right),
                    ],
                  ),
                ),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const ResetPasswordPage();
                }));
              },
            ),
          ],
        ),
      ),
    );
  }
}
