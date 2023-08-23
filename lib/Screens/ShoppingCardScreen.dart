// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
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
                        if (snapshot.data!.success == false ||
                            snapshot.data!.data!.isEmpty)
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
                        else if (snapshot.data!.success! == true &&
                            snapshot.data!.data!.isNotEmpty)
                          for (var i in snapshot.data!.data!)
                            TextButton(
                              child: ShoppingCards(
                                token: widget.token,
                                image: i.imageUrl!.imageLink!,
                                quantity: i.qty!,
                                price: i.price!.replaceAll(
                                    RegExp(r"([.]*0+)(?!.*\d)"), ""),
                                productId: i.id!,
                                sku: i.sku!,
                                totalPriceProduct:
                                    double.parse(i.price!) * i.qty!,
                                postTitle: i.name ?? '',
                                cardID: i.id!.toString(),
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
                                    productId: i.id!,
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
                        if (snapshot.data!.success! == true &&
                            snapshot.data!.data!.isNotEmpty)
                          FloatingActionButton.extended(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return PayScreen(
                                    token: widget.token,
                                    email: widget.email,
                                    lastname: widget.lastname,
                                    firstname: widget.firstname,
                                    customerId: widget.customerId,
                                  );
                                }),
                              );
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
