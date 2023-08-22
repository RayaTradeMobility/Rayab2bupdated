// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rayab2bupdated/Models/RegisterRequestModel.dart' as request;
import 'package:rayab2bupdated/Screens/LoginScreen.dart';
import '../API/API.dart';
import '../Models/RegisterResponseModel.dart' as response;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final password = TextEditingController();
  final mobileNumber = TextEditingController();
  final companyName = TextEditingController();
  final email = TextEditingController();
  final street = TextEditingController();
  final city = TextEditingController();
  final postCode = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisibility = true;
  final int _fontcolor = 0xFF031639;
  bool? policyValue = false;
  bool valid = false;
  API api = API();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: registerForm(context),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          setState(() {
            _isLoading = true;
          });
          if (_formKey.currentState!.validate()) {
            if (policyValue == false) {
              setState(() {
                _isLoading = false;
              });
              Fluttertoast.showToast(
                  msg: "Please Accept Terms And Policy",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            } else {
              api.checkNetwork();
              request.RegisterRequestModel requestModel =
                  request.RegisterRequestModel();
              requestModel.customer = request.Customer();
              requestModel.customer!.firstname = firstName.text;
              requestModel.customer!.lastname = lastName.text;
              requestModel.customer!.email = email.text;
              request.Addresses addresses = request.Addresses();
              addresses.defaultShipping = true;
              addresses.defaultBilling = true;
              addresses.lastname = lastName.text;
              addresses.firstname = firstName.text;
              addresses.region = request.Region();
              addresses.region!.regionCode = "EG";
              addresses.region!.region = "Egypt";
              addresses.region!.regionId = 1122;
              addresses.postcode = postCode.text;
              addresses.street = <String>[];
              addresses.street!.add(street.text);
              addresses.city = city.text;
              addresses.telephone = mobileNumber.text;
              addresses.countryId = "EG";
              requestModel.customer!.addresses = <request.Addresses>[];
              requestModel.customer!.addresses!.add(addresses);
              requestModel.password = password.text;
              response.RegisterResponseModel? res =
                  await api.register(requestModel);
              if (res.success == true) {
                setState(() {
                  _isLoading = false;
                });
                // ignore: use_build_context_synchronously
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const LoginScreen();
                }));
              } else {
                setState(() {
                  _isLoading = false;
                });
                Fluttertoast.showToast(
                    msg: res.message!.isEmpty ? 'Error' : res.message!,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
            }
          }
          setState(() {
            _isLoading = false;
          });
        },
        label: _isLoading
            ? const CircularProgressIndicator()
            : const Text('تسجيل'),
        backgroundColor: Color(_fontcolor),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Form registerForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
            controller: firstName,
            decoration: InputDecoration(
              hintText: "الاسم الاول",
              prefixIcon: const Icon(Icons.account_box),
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
          ),
          const SizedBox(
            height: 10.0,
          ),
          TextFormField(
            controller: lastName,
            decoration: InputDecoration(
              hintText: "الاسم الاخير",
              prefixIcon: const Icon(Icons.account_box),
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
          ),
          const SizedBox(
            height: 10.0,
          ),
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
                  // Update the state i.e. toogle the state of passwordVisible variable
                  setState(() {
                    _passwordVisibility = !_passwordVisibility;
                  });
                },
              ),
              hintText: "الباسورد",
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
                return 'ادخل باسورد اكبر من 6 حروف';
              }
            },
          ),
          const SizedBox(
            height: 10.0,
          ),
          TextFormField(
            controller: email,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: "البريد الشخصي",
              prefixIcon: const Icon(Icons.email),
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
            validator: (email) {
              if (isEmailValid(email!)) {
                return null;
              } else {
                return 'ادخل البريد الشخصي صحيح';
              }
            },
          ),
          const SizedBox(
            height: 10.0,
          ),
          TextFormField(
            controller: companyName,
            decoration: InputDecoration(
              hintText: "اسم الشركه",
              prefixIcon: const Icon(Icons.add_business),
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
          ),
          const SizedBox(
            height: 10.0,
          ),
          TextFormField(
            controller: street,
            decoration: InputDecoration(
              hintText: "اسم الشارع",
              prefixIcon: const Icon(Icons.streetview),
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
          ),
          const SizedBox(
            height: 10.0,
          ),
          TextFormField(
            controller: city,
            decoration: InputDecoration(
              hintText: "اسم المدينه",
              prefixIcon: const Icon(Icons.location_city),
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
          ),
          const SizedBox(
            height: 10.0,
          ),
          TextFormField(
            controller: postCode,
            decoration: InputDecoration(
              hintText: "الرقم البريدي",
              prefixIcon: const Icon(Icons.numbers),
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
          ),
          const SizedBox(
            height: 10.0,
          ),
          TextFormField(
            controller: mobileNumber,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "رقم الموبايل",
              prefixIcon: const Icon(Icons.mobile_friendly),
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
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              Checkbox(
                value: policyValue,
                onChanged: (bool? value) {
                  setState(() {
                    policyValue = value;
                  });
                },
              ),
              const Text(
                'انا اوافق ع كافه الشروط والاحكام',
                style: TextStyle(fontSize: 10.0),
              )
            ],
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
}
