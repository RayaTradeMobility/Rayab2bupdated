// ignore_for_file: prefer_interpolation_to_compose_strings, file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rayab2bupdated/API/API.dart';

import '../Screens/ShoppingCardScreen.dart';

class ShoppingCards extends StatefulWidget {
  const ShoppingCards(
      {super.key,
      required this.token,
      required this.image,
      required this.cardID,
      required this.countProducts,
      required this.totalPrice,
      required this.postTitle,
      required this.totalPriceProduct,
      required this.productId,
      required this.sku,
      required this.price,
      required this.quantity,
      required this.email,
      required this.mobile,
      required this.firstname,
      required this.customerId});

  final int quantity;
  final String price;
  final int productId;
  final String sku;
  final double totalPriceProduct;
  final double totalPrice;
  final String postTitle;
  final int countProducts;
  final String cardID;
  final String image;
  final String token, email, mobile, firstname, customerId;

  @override
  ShoppingCardsState createState() => ShoppingCardsState();
}

class ShoppingCardsState extends State<ShoppingCards> {
  API api = API();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Card(
          elevation: 5,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FadeInImage(
                    image: NetworkImage(widget.image),
                    width: MediaQuery.of(context).size.width / 7,
                    height: MediaQuery.of(context).size.height / 7,
                    placeholder: const AssetImage("assets/loading.png"),
                    imageErrorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/loading.png',
                        fit: BoxFit.fitWidth,
                        width: MediaQuery.of(context).size.width / 7,
                        height: MediaQuery.of(context).size.height / 7,
                      );
                    },
                    fit: BoxFit.fitWidth,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          constraints: const BoxConstraints(
                              minWidth: 100, maxWidth: 250),
                          padding: const EdgeInsets.all(5.0),
                          child: Text(widget.postTitle,
                              style: const TextStyle(fontSize: 12.0))),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            '${widget.price} EGP',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text('الكمية :'),
                              Text(widget.quantity.toString()),
                              IconButton(
                                  onPressed: () async {
                                    if (kDebugMode) {
                                      print(widget.productId);
                                    }
                                    await api.deleteProducts(widget.token,
                                        widget.productId, widget.sku);
                                    // ignore: use_build_context_synchronously
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (context) {
                                      return ShoppingCardScreen(
                                        token: widget.token,
                                        email: widget.email,
                                        mobile: widget.mobile,
                                        firstname: widget.firstname,

                                        customerId: widget.customerId,
                                      );
                                    }));
                                  },
                                  icon: const Icon(
                                    CupertinoIcons.delete,
                                    color: Colors.redAccent,
                                  )),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black,
                                        style: BorderStyle.solid),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5))),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Column(
                            children: [
                              Text(
                                "الاجمالي :" +
                                    widget.totalPriceProduct.toString() +
                                    ' جنيه',
                                style: const TextStyle(fontSize: 12.0),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
