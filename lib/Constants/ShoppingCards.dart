// ignore_for_file: prefer_interpolation_to_compose_strings, file_names

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
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
  final String totalPriceProduct;
  final String totalPrice;
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
          SwipeActionCell(
              key: UniqueKey(),
              trailingActions: <SwipeAction>[
                SwipeAction(
                    title: '',
                    icon: Icon(
                      LineAwesomeIcons.trash,
                      color: Colors.black,
                      size: 24,
                    ),
                    onTap: (CompletionHandler handler) async {
                      await api.deleteProducts(
                          widget.token, widget.productId, widget.sku);

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
                      setState(() {});
                    },
                    color: Colors.red),
              ],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
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
                            placeholder:
                                const AssetImage("assets/logo-raya.png"),
                            imageErrorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                'assets/logo-raya.png',
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
                                alignment: Alignment.center,
                                width: 300,
                                constraints: const BoxConstraints(
                                  minWidth: 100,
                                  maxWidth: 150,
                                ),
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  widget.postTitle,
                                  maxLines: 2,
                                  style: const TextStyle(fontSize: 12.0),
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    '${widget.price} EGP',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(width: 20.0),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Text('الكمية :'),
                                      Text(widget.quantity.toString()),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.black,
                                            style: BorderStyle.solid,
                                          ),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(5)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 10.0),
                                  Column(
                                    children: [
                                      Text(
                                        "الاجمالي :" +
                                            widget.totalPriceProduct
                                                .toString() +
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
              ))
        ]);
  }
}
