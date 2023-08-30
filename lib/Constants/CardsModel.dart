// ignore_for_file: unnecessary_null_comparison, file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:rayab2bupdated/Screens/ProductScreen.dart';

import '../API/API.dart';
import 'Constants.dart';

class CardScreenModel extends StatefulWidget {
  const CardScreenModel(
      {super.key,
      required this.isfavouriteApi,
      required this.fav,
      required this.name,
      required this.salePrice,
      required this.image,
      required this.price,
      required this.regularPrice,
      required this.id,
      required this.token,
      required this.stockStatus,
      required this.isBundle,
      required this.percentagePrice,
      required this.sku,
      required this.email,
      required this.mobile,
      required this.firstname,
      required this.customerId});

  final String name;
  final String salePrice;
  final String regularPrice;
  final String price;
  final String image;
  final int id;
  final String token;
  final String stockStatus;
  final String fav;
  final bool isfavouriteApi;
  final int percentagePrice;
  final bool isBundle;
  final String sku;
  final String email, mobile, firstname, customerId;

  @override
  State<CardScreenModel> createState() => _CardScreenModelState();
}

class _CardScreenModelState extends State<CardScreenModel> {
  Icon icon1 = const Icon(LineAwesomeIcons.heart);
  API api = API();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.isfavouriteApi == true || widget.fav == "liked") {
      icon1 = const Icon(
        CupertinoIcons.heart_fill,
        color: Colors.pinkAccent,
      );
    } else {
      icon1 = const Icon(
        LineAwesomeIcons.heart,
        color: Colors.pinkAccent,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ProductScreen(
              sku: widget.sku,
              productId: widget.id,
              token: widget.token,
              mobile: widget.mobile,
              firstname: widget.firstname,
              email: widget.email,
              customerId: widget.customerId,
            );
          }));
        },
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (widget.percentagePrice != 0)
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: const Color(0xFF4C53A5),
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      'Sale ${widget.percentagePrice}%',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                      ),
                    ),
                  )
                else if (widget.isBundle != false)
                  Container(
                    alignment: Alignment.centerLeft,
                    height: 20.0,
                    width: 70.0,
                    child: const Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(1)),
                      ),
                      color: Colors.yellow,
                      child: Center(
                        child: Text(
                          'Bundle',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                else
                  Container(
                    margin: const EdgeInsets.all(10),
                    alignment: Alignment.centerLeft,
                    height: 20.0,
                    width: 60.0,
                  ),
                TextButton(
                  onPressed: () async {
                    if (icon1.icon == LineAwesomeIcons.heart) {
                      setState(() {
                        api.addToFavourite(
                          widget.token,
                          widget.id.toString(),
                          widget.sku,
                        );
                        Fluttertoast.showToast(
                            msg: "Added to Favourite",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: MyColorsSample.fontColor,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        icon1 = const Icon(
                          CupertinoIcons.heart_fill,
                          color: Colors.pink,
                        );
                      });
                    } else {
                      setState(() {
                        api.removeFromFavourite(
                          widget.token,
                          widget.id.toString(),
                          widget.sku,
                        );
                        Fluttertoast.showToast(
                            msg: "Removed from Favourite",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: MyColorsSample.fontColor,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        icon1 = const Icon(
                          LineAwesomeIcons.heart,
                          color: Colors.pink,
                        );
                      });
                    }
                  },
                  child: Container(
                    width: 40,
                    height: 30,
                    alignment: Alignment.topLeft,
                    child: icon1,
                  ),
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.all(5),
              child: FadeInImage(
                image: NetworkImage(widget.image),
                width: MediaQuery.of(context).size.width / 3.3,
                height: MediaQuery.of(context).size.width / 2.5,
                placeholder: const AssetImage("assets/loading.png"),
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/loading.png',
                    fit: BoxFit.fitWidth,
                    width: MediaQuery.of(context).size.width / 3.3,
                    height: MediaQuery.of(context).size.width / 3.3,
                  );
                },
                fit: BoxFit.fitWidth,
              ),
            ),
            if (widget.regularPrice != widget.price &&
                widget.regularPrice != "0")
              Text(
                "${widget.regularPrice} ج.م",
                style: const TextStyle(
                    fontSize: 10.0, decoration: TextDecoration.lineThrough),
              ),
            if (widget.name != null)
              Container(
                width: 100,
                padding: const EdgeInsets.only(bottom: 10),
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.name.trim(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF4C53A5),
                  ),
                ),
              ),
            if (widget.price != null || widget.price != "0")
              Container(
                padding: const EdgeInsets.only(bottom: 10),
                alignment: Alignment.centerRight,
                child: Text(
                  "   ${widget.price.replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "")} ج.م",
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4C53A5),
                  ),
                ),
              )
            else
              Container(
                padding: const EdgeInsets.only(bottom: 10),
                alignment: Alignment.centerRight,
                child: Text("${widget.regularPrice} ج.م",
                    style: const TextStyle(
                        fontSize: 10.0, fontWeight: FontWeight.bold)),
              ),
            widget.stockStatus != ''
                ? Container(
                    width: 50,
                    height: 20,
                    decoration: BoxDecoration(
                        color: const Color(0xFF4C53A5),
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Text(
                        widget.stockStatus,
                        style: const TextStyle(
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
