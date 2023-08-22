// ignore_for_file: file_names, use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rayab2bupdated/API/API.dart';
import 'package:rayab2bupdated/Models/LoginModelRequest.dart';
import 'package:rayab2bupdated/Models/LoginResponseModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'BottomNavMenu.dart';
import 'RegisterScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  final emailController = TextEditingController();
  final password = TextEditingController();
  final int _fontcolor = 0xFF031639;
  bool _passwordVisibility = true;
  API api = API();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
            controller: emailController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                hintText: "ادخل البريد الشخصي",
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
            validator: (email) {
              if (isEmailValid(email!)) {
                return null;
              } else {
                return 'البريد الشخصي غير صحيح';
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
                  // Navigator.push(
                  //   context, MaterialPageRoute(builder: (context) {
                  //   return ResetPassword();
                  // }),);
                },
                child: const Text('نسيت الباسورد؟')),
          ),
          SizedBox(
            width: 300.0,
            child: ElevatedButton(
              onPressed: () async {
                setState(() {
                  _isLoading = true;
                });
                if (_formKey.currentState!.validate()) {
                  api.checkNetwork();
                  LoginModelRequest user = LoginModelRequest();
                  user.username = emailController.text;
                  user.password = password.text;
                  LoginResponseModel? loginUser = await api.login(user);

                  if (loginUser!.success == true) {
                    setState(() {
                      _isLoading = false;
                    });
                    if (kDebugMode) {
                      print(loginUser.data!.token!);
                    }
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return BottomNavMenu(
                        token: loginUser.data!.token!,
                        email: loginUser.data!.email!,
                        firstname: loginUser.data!.firstname!,
                        lastname: loginUser.data!.lastname!,
                        mobile: loginUser.data!.telephone!,
                        customerId: loginUser.data!.id!.toString(),
                      );
                    }));
                  } else {
                    setState(() {
                      _isLoading = false;
                    });
                    Fluttertoast.showToast(
                        msg: loginUser.message!,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                } else {
                  setState(() {
                    _isLoading = false;
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color(_fontcolor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text("تسجيل الدخول"),
            ),
          ),
          const SizedBox(
            height: 5.0,
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

  bool isPasswordValid(String password) => password.length >= 6;

  bool isEmailValid(String email) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
        .hasMatch(email);
    return emailValid;
  }

  void _loadUserEmailPassword() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var email = prefs.getString("username") ?? "";
      var passWord = prefs.getString("password") ?? "";
      if (kDebugMode) {
        print(email);
        print(password);
      }
      emailController.text = email;
      password.text = passWord;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
