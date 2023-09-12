// ignore_for_file: file_names

import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rayab2bupdated/Screens/LoginScreen.dart';
import '../API/API.dart';
import 'package:pinput/pinput.dart';
import '../Constants/Constants.dart';
import '../Models/CheckOTPModel.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  ResetPasswordPageState createState() => ResetPasswordPageState();
}

class ResetPasswordPageState extends State<ResetPasswordPage> {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  TextEditingController otpController = TextEditingController();
  bool _showOtpField = false;
  bool _showPasswordField = false;

  API api = API();

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
          title: Center(child: const Text("اعادة تعيين كلمة المرور" , style: ArabicTextStyle(arabicFont: ArabicFont.avenirArabic),) ),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: phoneNumberController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'رقم الموبايل',
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  await api.mobileOTP(phoneNumberController.text);
                  setState(() {
                    _showOtpField = true;
                  });
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: MyColorsSample.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
                child: const Text('Send OTP'),
              ),
              const SizedBox(height: 16.0),
              if (_showOtpField)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SizedBox(
                    child: Pinput(
                      controller: otpController,
                      length: 4,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      defaultPinTheme: PinTheme(
                        height: 60.0,
                        width: 60.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.black.withOpacity(0.5),
                            width: 1.0,
                          ),
                        ),
                      ),
                      focusedPinTheme: PinTheme(
                        height: 60.0,
                        width: 60.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 12.0),
              if (_showOtpField)
                ElevatedButton(
                  onPressed: () async {
                    OtpCheckModel? user = await api.checkOTP(
                        phoneNumberController.text, otpController.text);
                    if (user!.success == true) {
                      setState(() {
                        _showPasswordField = true;
                      });
                    } else {
                      Fluttertoast.showToast(
                          msg: user.message!,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: MyColorsSample.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                  child: const Text('Check OTP'),
                ),
              const SizedBox(
                height: 50,
              ),
              if (_showPasswordField)
                TextFormField(
                    key: _formKey,
                    controller: passwordController,
                    decoration: const InputDecoration(
                      labelText: 'ادخل كلمه السر الجديده',
                    ),
                    validator: (password) {
                      if (isPasswordValid(password!)) {
                        return null;
                      } else {
                        return 'الرقم السري يجب ان يكون اكبر من 6 حروف';
                      }
                    }),
              const SizedBox(height: 16.0),
              if (_showPasswordField)
                ElevatedButton(
                  onPressed: () async {
                    OtpCheckModel? user = await api.resetPassword(
                        phoneNumberController.text,
                        otpController.text,
                        passwordController.text);
                    if (user!.success == true) {
                      Fluttertoast.showToast(
                          msg: "Password reset Successfully",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return const LoginScreen();
                        }),
                      );
                    } else {
                      Fluttertoast.showToast(
                          msg: user.message!,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: MyColorsSample.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                  child: const Text('Reset Password'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

bool isPasswordValid(String password) => password.length >= 6;
