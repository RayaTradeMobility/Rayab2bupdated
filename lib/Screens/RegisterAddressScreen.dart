// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rayab2bupdated/Models/CreateAddressModel.dart';
import 'package:rayab2bupdated/Screens/LoginScreen.dart';
import '../API/API.dart';

class RegisterAddressScreen extends StatefulWidget {
  const RegisterAddressScreen({Key? key, required this.token})
      : super(key: key);
  final String token;

  @override
  State<RegisterAddressScreen> createState() => _RegisterAddressScreenState();
}

class _RegisterAddressScreenState extends State<RegisterAddressScreen> {
  final street = TextEditingController();
  final city = TextEditingController();
  final building = TextEditingController();
  final postCode = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final int _fontcolor = 0xFF031639;
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
            api.checkNetwork();

            CreateAddressModel get = await api.createAddress(
                widget.token, city.text, street.text, int.parse(building.text));
            if (get.success == true) {
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
                  msg: get.message!.isEmpty ? 'Error' : get.message!,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          }

          setState(() {
            _isLoading = false;
          });
        },
        label: _isLoading
            ? const CircularProgressIndicator()
            : const Text('تسجيل 2/2'),
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
            controller: city,
            decoration: InputDecoration(
              hintText: "العنوان",
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
            validator: (street) {
              if (isAddressValid(street!)) {
                return null;
              } else {
                return 'ادخل العنوان';
              }
            },
          ),
          const SizedBox(
            height: 10.0,
          ),
          TextFormField(
            controller: street,
            decoration: InputDecoration(
              hintText: "الشارع",
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
            validator: (street) {
              if (isStreetValid(street!)) {
                return null;
              } else {
                return 'ادخل الشارع';
              }
            },
          ),
          const SizedBox(
            height: 10.0,
          ),
          TextFormField(
            controller: building,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "رقم العماره",
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
            validator: (building) {
              if (isBuildingValid(building!)) {
                return null;
              } else {
                return 'ادخل رقم العماره';
              }
            },
          ),
          const SizedBox(
            height: 10.0,
          ),
        ],
      ),
    );
  }
}

bool isStreetValid(String street) => street.isNotEmpty;

bool isAddressValid(String address) => address.isNotEmpty;

bool isBuildingValid(String building) => building.isNotEmpty;
