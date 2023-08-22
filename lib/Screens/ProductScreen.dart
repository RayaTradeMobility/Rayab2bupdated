// ignore_for_file: file_names, use_build_context_synchronously

import 'package:collapsible/collapsible.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rayab2bupdated/Models/ProductbySkuResponseModel.dart';
import 'package:rayab2bupdated/Screens/ShoppingCardScreen.dart';

import '../API/API.dart';
import 'package:rayab2bupdated/Constants/Constants.dart';
import '../Models/AddtoCartResponseModel.dart';
import 'LoginScreen.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({
    Key? key,
    required this.sku,
    required this.token,
    required this.email,
    required this.mobile,
    required this.firstname,
    required this.lastname,
    required this.customerId,
  }) : super(key: key);
  final String sku, token, email, mobile, firstname, lastname, customerId;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  bool _collapse = false;
  late Future<ProductbySkuResponseModel> _product;
  final int _fontcolor = 0xFF031639;
  double total = 0;

  double? result ;
  API api = API();
  int quantity = 1;
  bool _isloading = false;

  @override
  void initState() {
    _product = api.getProductBySku(widget.sku);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColorsSample.fontColor,
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 60.0),
          child: SingleChildScrollView(
            child: FutureBuilder<ProductbySkuResponseModel>(
                future: _product,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //slider
                                for (var i in snapshot.data!.data!.images!)
                                  FadeInImage(
                                    image: NetworkImage(i.imageLink!),
                                    width: 250.0,
                                    height: 250.0,
                                    placeholder:
                                        const AssetImage("assets/no-img.jpg"),
                                    imageErrorBuilder:
                                        (context, error, stackTrace) {
                                      return Image.asset('assets/no-img.jpg',
                                          fit: BoxFit.fitWidth);
                                    },
                                    fit: BoxFit.fitWidth,
                                  ),
                              ],
                            ),
                          ),
                        ),
                        const Divider(
                          color: Colors.black,
                        ),
                        Text(snapshot.data!.data!.name!,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                            )),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "${snapshot.data!.data!.price!.replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "")} جنيه مصري ",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                  color: Colors.lightBlue),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      quantity += 1;
                                      double sale = double.parse(snapshot.data!.data!.price!);
                                      double price = sale;
                                      total = quantity * price;
                                      result = total;
                                    });
                                  },
                                  icon: const Icon(Icons.add),
                                  iconSize: 15.0,
                                ),
                                const SizedBox(width: 5.0),
                                Text('$quantity'),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (quantity != 1) {
                                        double sale = double.parse(snapshot
                                            .data!.data!.price!) ;
                                        double price = sale;
                                        quantity -= 1;
                                        total = quantity * price;
                                        result = total;
                                      }
                                    });
                                  },
                                  icon: const Icon(CupertinoIcons.minus),
                                  iconSize: 15.0,
                                ),
                              ],
                            )
                          ],
                        ),
                        if (result != null)
                          Row(
                            children: [
                              const Text(
                                'الاجمالي : ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                    color: Colors.lightBlue),
                              ),
                              Text(
                                "$result جنيه مصري ",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                    color: Colors.lightBlue),
                              )
                            ],
                          ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        const Divider(
                          color: Colors.black,
                        ),
                        Container(
                          width: 500.0,
                          height: 60.0,
                          decoration: BoxDecoration(
                              color: Colors.lightBlue[100],
                              border: Border.all(
                                  color: Colors.black, style: BorderStyle.none),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15))),
                          child:  const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Icon(CupertinoIcons.info),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  'التفاصيل',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  if (_collapse == true) {
                                    _collapse = false;
                                  } else {
                                    _collapse = true;
                                  }
                                });
                              },
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                          snapshot.data!.data!.description!)),
                                ],
                              ),
                            ),
                            for (var i in snapshot.data!.data!.attributes!)
                              Column(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        if (_collapse == true) {
                                          _collapse = false;
                                        } else {
                                          _collapse = true;
                                        }
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        const Expanded(
                                            child: Icon(CupertinoIcons
                                                .exclamationmark_circle_fill)),
                                        Expanded(
                                            child:
                                                Text(i.nameAttribute!.name!)),
                                        const Expanded(child: Icon(Icons.add)),
                                      ],
                                    ),
                                  ),
                                  Collapsible(
                                    collapsed: _collapse,
                                    axis: CollapsibleAxis.vertical,
                                    alignment: Alignment.bottomLeft,
                                    child: Text(i.nameAttribute!.name!),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ],
                    );
                  }
                  else if (snapshot.hasError) {
                    return Text(
                        '${snapshot.error}' "You don't have data in this time");
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          setState(() {
            _isloading = true;
          });
          if (widget.token.isNotEmpty) {
            AddtoCartResponseModel msg =
                await api.addToCart(widget.token, widget.sku, quantity);
            if (msg.success == true) {
              setState(() {
                _isloading = false;

              });
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ShoppingCardScreen(
                  token: widget.token,
                  mobile: widget.mobile,
                  lastname: widget.lastname,
                  firstname: widget.firstname,
                  email: widget.email,
                  street: '',
                  city: '',
                  customerId: widget.customerId,
                );
              }));
            } else {
              setState(() {
                _isloading = false;

              });
              Fluttertoast.showToast(
                  msg: msg.message!,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          } else {
            _isloading = false;
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const LoginScreen();
            }));
          }
        },
        icon: const Icon(Icons.shopping_cart),
        label: _isloading
            ? const CircularProgressIndicator()
            : const Text('اضافه الي العربه'),
        elevation: 5,
        backgroundColor: Color(_fontcolor),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  String Function(Match) mathFunc = (Match match) => '${match[1]},';
}
