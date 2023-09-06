// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:rayab2bupdated/Screens/OrdersScreen.dart';
import 'BottomNavMenu.dart';

class ThanksScreen extends StatefulWidget {
  const ThanksScreen(
      {super.key,
      required this.token,
      required this.email,
      required this.firstname,
      required this.customerId,
      required this.orderId,
      required this.totalPrice, required this.mobile});

  final String token,
      email,
      firstname,
      customerId,
      orderId,
      totalPrice , mobile;

  @override
  ThanksScreenState createState() => ThanksScreenState();
}

class ThanksScreenState extends State<ThanksScreen> {
  final int _fontcolor = 0xFF4C53A5;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return BottomNavMenu(
                            token: widget.token,
                            email: widget.email,
                            firstname: widget.firstname,
                            mobile: widget.mobile,
                            customerId: widget.customerId,
                          );
                        }));
                      },
                      icon: const Icon(Icons.close))
                ],
              ),
              Image.asset(
                "assets/thanks.png",
                width: 500,
                height: 200,
              ),
              Center(
                  child: Text(
                'شكراً على طلبك.',
                style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: Color(_fontcolor)),
              )),
              const SizedBox(
                height: 10.0,
              ),
              Center(
                  child: Text(
                'نحن نعمل الآن على طلبك وسنرسل نسخة من إيصالك إلى',
                style: TextStyle(color: Color(_fontcolor)),
              )),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return OrdersScreen(
                        token: widget.token,
                        email: widget.email,
                        firstname: widget.firstname,
                        mobile: "",
                        customerId: widget.customerId,
                        orderId: widget.orderId,
                      );
                    }));
                  },
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color(_fontcolor)),
                  child: const Text("تتبع طلبك"),
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return BottomNavMenu(
                        token: widget.token,
                        email: widget.email,
                        firstname: widget.firstname,
                        mobile: "",
                        customerId: widget.customerId,
                      );
                    }));
                  },
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white),
                  child: const Text("الرجوع للصفحه الرئيسيه"),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'معاد الطلب ',
                    style: TextStyle(color: Color(_fontcolor)),
                  ),
                  Text(
                    '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                    style: TextStyle(color: Color(_fontcolor)),
                  )
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Divider(
                color: Colors.black,
                thickness: 0.5,
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'اجمالي الفاتوره',
                    style: TextStyle(color: Color(_fontcolor)),
                  ),
                  Text(
                    widget.totalPrice,
                    style: TextStyle(color: Color(_fontcolor)),
                  )
                ],
              ),
            ],
          )),
    );
  }
}
