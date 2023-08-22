// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:rayab2bupdated/API/API.dart';
import 'package:rayab2bupdated/Screens/ProductScreen.dart';
import 'package:rayab2bupdated/Constants/Constants.dart';
import '../Constants/ShoppingCards.dart';
import '../Models/GetCartResponseModel.dart';
import 'BottomNavMenu.dart';
import 'CategoriesScreen.dart';
import 'PayScreen.dart';

class ShoppingCardScreen extends StatefulWidget {
  const ShoppingCardScreen(
      {Key? key,
      required this.token,
      required this.email,
      required this.mobile,
      required this.firstname,
      required this.lastname,
      required this.city,
      required this.street,
      required this.customerId})
      : super(key: key);
  final String token,
      email,
      mobile,
      firstname,
      lastname,
      city,
      street,
      customerId;

  @override
  State<ShoppingCardScreen> createState() => _ShoppingCardScreenState();
}

class _ShoppingCardScreenState extends State<ShoppingCardScreen> {
  final int _fontcolor = 0xFF4C53A5;
  late Future<GetCartResponseModel> card;
  API api = API();

  @override
  void initState() {
    card = api.getCart(widget.token);
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
            firstname: widget.firstname,
            lastname: widget.lastname,
            mobile: widget.mobile,
            customerId: widget.customerId,
          );
        }));
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: MyColorsSample.fontColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),
          title: const Text("عربه التسوق"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder<GetCartResponseModel>(
                future: card,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (snapshot.data!.success == false || snapshot.data!.data!.isEmpty)
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset("assets/No_card_img.jpeg"),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                "There is no products in shopping card browse the products",
                                style: TextStyle(
                                    color: Color(_fontcolor),
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "and shopping now",
                                style: TextStyle(
                                    color: Color(_fontcolor),
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              FloatingActionButton.extended(
                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return CategoriesScreen(
                                        token: widget.token,
                                        email: widget.email,
                                        firstname: widget.firstname,
                                        lastname: widget.lastname,
                                        mobile: widget.mobile,
                                        customerId: widget.customerId,
                                      );
                                    }));
                                  },
                                  label: const Text("تسوق الان"),
                                  backgroundColor: Color(_fontcolor))
                            ],
                          )
                        else if (snapshot.data!.success! == true && snapshot.data!.data!.isNotEmpty)
                          for (var i in snapshot.data!.data!)
                            TextButton(
                              child: ShoppingCards(
                                token: widget.token,
                                image: i.image!,
                                quantity: i.qty!,
                                price: i.price!.replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), ""),
                                productId: i.itemId!,
                                totalPriceProduct:
                                    double.parse(i.price!) * i.qty!,
                                postTitle: i.name ?? '',
                                cardID: i.quoteId ?? '0',
                                countProducts: i.qty!,
                                totalPrice: double.parse(i.price!) * i.qty!,
                                email: widget.email,
                                firstname: widget.firstname,
                                lastname: widget.lastname,
                                mobile: widget.mobile,
                                customerId: widget.customerId,
                              ),
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return ProductScreen(
                                    sku: i.sku!,
                                    token: widget.token,
                                    email: widget.email,
                                    firstname: widget.firstname,
                                    lastname: widget.lastname,
                                    mobile: widget.mobile,
                                    customerId: widget.customerId,
                                  );
                                }));
                              },
                            ),
                        if (snapshot.data!.success! == true)
                          FloatingActionButton.extended(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialogPage(
                                      token: widget.token,
                                      email: widget.email,
                                      firstname: widget.firstname,
                                      lastname: widget.lastname,
                                      mobile: 0,
                                      street: widget.street,
                                      city: widget.city,
                                      customerId: widget.customerId,
                                    );
                                  });
                            },
                            label: const Text("احصل على المنتج بعد الخصم"),
                            backgroundColor: Color(_fontcolor),
                            elevation: 5,
                          )
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text(
                        '${snapshot.error}' "You don't have data in this time");
                  } else {
                    return const Padding(
                      padding: EdgeInsets.all(180.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                }),
          ),
        ),
      ),
    );
  }
}

class AlertDialogPage extends StatefulWidget {
  final String token, email, firstname, lastname, street, city, customerId;
  final int mobile;

  const AlertDialogPage({
    Key? key,
    required this.token,
    required this.email,
    required this.mobile,
    required this.firstname,
    required this.lastname,
    required this.street,
    required this.city,
    required this.customerId,
  }) : super(key: key);

  @override
  AlertDialogPageState createState() => AlertDialogPageState();
}

class AlertDialogPageState extends State<AlertDialogPage> {
  TextEditingController streetController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(child: Text('العنوان')),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: mobileController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'الموبايل',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: cityController,
              decoration: InputDecoration(
                hintText: 'المدينه',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: streetController,
              decoration: InputDecoration(
                hintText: 'الشارع',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColorsSample.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onPressed: () {
                if (cityController.text.isEmpty ||
                    streetController.text.isEmpty ||
                    mobileController.text.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('خطأ'),
                        content: const Text('يرجى ملء جميع البيانات'),
                        actions: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor:
                                  MyColorsSample.primary.withOpacity(0.8),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Center(child: Text('حسنًا')),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return PayScreen(
                        token: widget.token,
                        email: widget.email,
                        mobile: mobileController.text,
                        lastname: widget.lastname,
                        firstname: widget.firstname,
                        street: streetController.text,
                        city: cityController.text,
                        customerId: widget.customerId,
                      );
                    }),
                  );
                }
              },
              child: const Text('طلب'),
            ),
          ],
        ),
      ),
    );
  }
}
