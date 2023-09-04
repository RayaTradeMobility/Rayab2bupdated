// ignore_for_file: unnecessary_null_comparison, file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rayab2bupdated/Screens/ProductScreen.dart';

class CardScreen extends StatefulWidget {
  const CardScreen(
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
      required this.lastname,
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
  final String email, mobile, firstname, lastname, customerId;

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  Icon icon1 = const Icon(CupertinoIcons.heart);

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
        CupertinoIcons.heart,
        color: Colors.pinkAccent,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230.0,
      width: 160.0,
      child: TextButton(
        onPressed: () {
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
        child: Card(
          elevation: 10,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.percentagePrice != 0)
                      Container(
                        alignment: Alignment.centerLeft,
                        height: 20.0,
                        width: 70.0,
                        child: Card(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(1)),
                          ),
                          color: Colors.pinkAccent,
                          child: Center(
                            child: Text(
                              'Sale ${widget.percentagePrice}%',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                              ),
                            ),
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
                        alignment: Alignment.centerLeft,
                        height: 20.0,
                        width: 70.0,
                      ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () async {},
                        child: Container(
                          alignment: Alignment.topRight,
                          child: icon1,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              FadeInImage(
                image: NetworkImage(widget.image),
                height: 120,
                placeholder: const AssetImage("assets/logo-raya.png"),
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset('assets/logo-raya.png',
                      fit: BoxFit.fitWidth);
                },
                fit: BoxFit.fitWidth,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.price != null || widget.price != "0")
                    Text(
                      "${widget.price} EGP",
                      style: const TextStyle(
                          fontSize: 10.0, fontWeight: FontWeight.bold),
                    )
                  else
                    Text("${widget.regularPrice} EGP",
                        style: const TextStyle(
                            fontSize: 10.0, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    width: 20.0,
                  ),
                  if (widget.regularPrice != widget.price &&
                      widget.regularPrice != "0")
                    Text(
                      "${widget.regularPrice} EGP",
                      style: const TextStyle(
                          fontSize: 10.0,
                          decoration: TextDecoration.lineThrough),
                    )
                ],
              ),
              if (widget.name != null)
                Container(
                  constraints:
                      const BoxConstraints(minWidth: 100, maxWidth: 200),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: const TextStyle(fontSize: 9),
                    ),
                  ),
                )
              else
                const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    'name',
                    style: TextStyle(fontSize: 9.0),
                  ),
                ),
              Text(
                widget.stockStatus,
                style: const TextStyle(fontSize: 10.0, color: Colors.green),
              )
            ],
          ),
        ),
      ),
    );
  }
}
