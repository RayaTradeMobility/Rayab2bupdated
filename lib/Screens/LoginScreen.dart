// ignore_for_file: file_names, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rayab2bupdated/API/API.dart';
import 'package:rayab2bupdated/Constants/Constants.dart';
import 'package:rayab2bupdated/Models/LoginResponseModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'BottomNavMenu.dart';
import 'ForgotPasswordScreen.dart';
import 'IntroductionScreen.dart';
import 'RegisterScreen.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  final mobileController = TextEditingController();
  final password = TextEditingController();
  final int _fontcolor = 0xFF031639;
  bool _passwordVisibility = true;
  API api = API();
  final _formKey = GlobalKey<FormState>();
  String idValue = '';
  String businessUnitValue = "";
  List<String> businessUnitId = [''];
  List<String> businessUnit = [''];


  Future<void> _loadData() async {
    var url = Uri.parse('http://41.78.23.95:8021/dist/api/v2/getBusinessUnits');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);

      setState(() {
        businessUnit =
            List<String>.from(jsonData['data'].map((x) => x['name']));
        businessUnitId =
            List<String>.from(jsonData['data'].map((x) => x['id'].toString()));
        businessUnitValue = businessUnit.first;
        idValue = businessUnitId.first;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadData();
    api.initNotification();
    _loadUserEmailPassword();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: loginForm(context),
        ),
      ),
    );
  }

  Form loginForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/logo-raya.png',
            width: 500.0,
            height: 200.0,
          ),
          const SizedBox(
            height: 5.0,
          ),
          TextFormField(
            controller: mobileController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                hintText: "ادخل رقم الموبايل",
                prefixIcon: const Icon(Icons.phone_android),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                )),
            validator: (mobile) {
              if (isMobileValid(mobile!)) {
                return null;
              } else {
                return 'رقم الموبايل غير صحيح';
              }
            },
          ),
          const SizedBox(height: 20.0),
          TextFormField(
            controller: password,
            obscureText: _passwordVisibility,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(
                  // Based on passwordVisible state choose the icon
                  _passwordVisibility ? Icons.visibility : Icons.visibility_off,
                  color: Theme.of(context).primaryColorDark,
                ),
                onPressed: () {
                  if (kDebugMode) {
                    print(idValue);
                  }
                  setState(() {
                    _passwordVisibility = !_passwordVisibility;
                  });
                },
              ),
              hintText: "ادخل الرقم السري",
              prefixIcon: const Icon(Icons.password),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            validator: (password) {
              if (isPasswordValid(password!)) {
                return null;
              } else {
                return 'الرقم السري يجب ان يكون اكبر من 6 حروف';
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 170.0),
            child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return const ResetPasswordPage();
                    }),
                  );
                },
                child: const Text('نسيت الباسورد؟')),
          ),
          SizedBox(
            width: 400.0,
            child: ElevatedButton(
              onPressed: () async {
                setState(() {
                  _isLoading = true;
                });
                if(idValue!=''){
                  if (_formKey.currentState!.validate()) {
                    api.checkNetwork();

                    LoginResponseModel? loginUser = await api.login(
                      mobileController.text,
                      password.text,
                      api.fcmToken,
                      idValue,
                    );

                    if (loginUser!.success == true) {
                      setState(() {
                        _isLoading = false;
                      });

                      bool isFirstTime = await checkIfFirstTime();
                      if (isFirstTime) {
                        // Show IntroductionScreen
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        await prefs.setBool('isFirstTime', false);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => IntroductionScreens( token: loginUser.data!.token!,
                              email: loginUser.data!.email!,
                              firstname: loginUser.data!.name!,
                              mobile: loginUser.data!.mobile!,
                              customerId: loginUser.data!.id!.toString(),),
                          ),
                        );
                      } else {
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
                          return BottomNavMenu(
                            token: loginUser.data!.token!,
                            email: loginUser.data!.email!,
                            firstname: loginUser.data!.name!,
                            mobile: loginUser.data!.mobile!,
                            customerId: loginUser.data!.id!.toString(),
                          );
                        }),  (route) => false);
                      }
                    } else {
                      setState(() {
                        _isLoading = false;
                      });

                      Fluttertoast.showToast(
                        msg: loginUser.message!,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: MyColorsSample.fontColor,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    }
                  }
                  else {
                    setState(() {
                      _isLoading = false;
                    });
                  }
                }
                else{
                  setState(() {
                    _isLoading = false;
                  });
                  Fluttertoast.showToast(
                    msg: "Please choose Business Unit",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: MyColorsSample.fontColor,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                }

              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color(_fontcolor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
              child: _isLoading ? const CircularProgressIndicator() : const Text("تسجيل الدخول"),
            ),


          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 15,
          ),
          Container(
            width: MediaQuery.of(context).size.width -50 ,
            height: MediaQuery.of(context).size.height / 15  ,
            color: MyColorsSample.fontColor,
            child: businessUnitValue.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : DropdownButton<String>(
                    value: businessUnitValue,
                    dropdownColor: MyColorsSample.fontColor,
                    itemHeight: null,
                    menuMaxHeight: 292,
                    borderRadius: BorderRadius.circular(10),
                    alignment: AlignmentDirectional.center,
                    icon: const Icon(Icons.arrow_drop_down_sharp),
                    elevation: 0,
                    style: const TextStyle(color: Colors.white),
                    onChanged: (String? newValue) {
                      setState(() {
                        businessUnitValue = newValue!;
                        idValue = businessUnitId[businessUnit.indexOf(businessUnitValue)];

                      });
                    },
                    items: businessUnit.map<DropdownMenuItem<String>>(
                      (String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width *0.79
                            ,
                            height: MediaQuery.of(context).size.height /20 ,
                            child: Center(child: Text(value)),
                          ),
                        );
                      },
                    ).toList(),
                  ),
          ),
          if (businessUnitValue.isEmpty)
            const Text(
              'Please wait to select business unit...',
              style: TextStyle(color: Colors.red),
            ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 8,
          ),
          Center(
            child: Row(children: [
              const Text("لا املك حساب"),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return const RegisterScreen();
                    }),
                  );
                },
                child: const Text('انشاء حساب جديد'),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  bool isMobileValid(String mobile) => mobile.length >= 10;

  bool isPasswordValid(String password) => password.length >= 6;

  Future<bool> checkIfFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
    return isFirstTime;
  }

  void _loadUserEmailPassword() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var mobile = prefs.getString("mobile") ?? "";
      var passWord = prefs.getString("password") ?? "";

      mobileController.text = mobile;
      password.text = passWord;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
