// ignore_for_file: file_names, use_build_context_synchronously

// import 'package:collapsible/collapsible.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:rayab2bupdated/Models/ProductbySkuResponseModel.dart';
import 'package:rayab2bupdated/Screens/ShoppingCardScreen.dart';
import 'package:transparent_image/transparent_image.dart';

import '../API/API.dart';
import 'package:rayab2bupdated/Constants/Constants.dart';
import '../Models/AddtoCartResponseModel.dart';
import 'LoginScreen.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({
    Key? key,
    required this.sku,
    required this.productId,
    required this.token,
    required this.email,
    required this.mobile,
    required this.firstname,
    required this.customerId,
  }) : super(key: key);
  final String sku, token, email, mobile, firstname, customerId;

  final int productId;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  bool _collapse = false;
  late Future<ProductbySkuResponseModel> _product;
  final int _fontcolor = 0xFF031639;
  double total = 0;
  final _formKey = GlobalKey<FormState>();

  TextEditingController quantityController = TextEditingController();
  double? result;

  API api = API();
  int quantity = 1;
  bool _isloading = false;

  Future<void> _refreshData() async {
    setState(() {
      _product = api.getProductBySku(widget.sku);
    });
  }

  @override
  void initState() {
    _product = api.getProductBySku(widget.sku);
    super.initState();
    quantityController.addListener(() {
      final enteredQuantity = int.parse(quantityController.text);
      setState(() {
        quantity = enteredQuantity;
      });
    });
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
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: Padding(
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
                                  for (var i in snapshot.data!.data!.items!)
                                    FadeInImage.memoryNetwork(
                                      image: i.images?.imageLink ?? 'https://www.google.com/url?sa=i&url=https%3A%2F%2Frayacorp.com%2F&psig=AOvVaw1EHF8VcdSB-ZEH4AydtjcN&ust=1693557822972000&source=images&cd=vfe&opi=89978449&ved=0CBAQjRxqFwoTCOiLjtrAhoEDFQAAAAAdAAAAABAJ'
                                      , width:
                                          MediaQuery.of(context).size.width / 1.6,
                                      height: MediaQuery.of(context).size.height /
                                          2.8,
                                      placeholder:kTransparentImage,
                                      imageErrorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                          'assets/logo-raya.png',
                                          fit: BoxFit.fitWidth,
                                          width:
                                              MediaQuery.of(context).size.width /
                                                  1.6,
                                          height:
                                              MediaQuery.of(context).size.height /
                                                  2.8,
                                        );
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
                          Text(snapshot.data!.data!.items![0].name!,
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
                                "${snapshot.data!.data!.items![0]
                    .priceWithoutComma!.replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "")} جنيه مصري  ",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
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
                                        double sale = double.parse(
                                            snapshot.data!.data!.items![0].priceWithoutComma!);
                                        double price = sale;
                                        total = quantity * price;
                                        result = total;
                                        quantityController.value =
                                            TextEditingValue(
                                                text: quantity.toString());
                                      });
                                    },
                                    icon: const Icon(Icons.add),
                                    iconSize: 15.0,
                                  ),
                                  const SizedBox(width: 5.0),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width / 10,
                                    height:
                                        MediaQuery.of(context).size.height / 20,
                                    child: Form(
                                      key: _formKey,
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: quantityController,
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(4),
                                        ],
                                        validator: (quantittes) {
                                          if (isQuantityValid(quantittes!)) {
                                            return null;
                                          }
                                          return 'لا يمكن اختيار اكثر من 5000';
                                        },
                                        decoration: InputDecoration(
                                          hintText: '$quantity',
                                        ),
                                        onChanged: (val) {
                                          setState(() {
                                            if (quantityController.text.isNotEmpty) {
                                              quantity = int.tryParse(quantityController.text) ?? 1;
                                              if (quantity != 0) {
                                                double sale;
                                                try {
                                                  sale = double.parse(snapshot.data!.data!.items![0].priceWithoutComma!);
                                                } catch (e) {
                                                  if (kDebugMode) {
                                                    print('Error parsing double value: $e');
                                                  }
                                                  sale = 0.0;
                                                }
                                                double price = sale;
                                                total = quantity * price;
                                                result = total;
                                              }
                                            } else {
                                              quantity = 1;
                                              result = 0;
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        if (quantity != 1) {
                                          double sale = double.parse(
                                              snapshot.data!.data!.items![0].priceWithoutComma!);
                                          double price = sale;
                                          quantity -= 1;
                                          total = quantity * price;
                                          result = total;
                                          quantityController.value =
                                              TextEditingValue(
                                                  text: quantity.toString());
                                        }
                                      });
                                    },
                                    icon: const Icon(LineAwesomeIcons.minus),
                                    iconSize: 15.0,
                                  ),
                                ],
                              )
                            ],
                          ),
                          if (result != null && result! > 0)
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
                                  "${result!.toStringAsFixed(2)} جنيه مصري ",
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
                            child:  Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  const Icon(CupertinoIcons.info),
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(
                                    'التفاصيل${snapshot.data!.data!.items![0].sku!}',
                                    style: const TextStyle(fontWeight: FontWeight.bold),
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
                                            snapshot.data!.data!.items![0].name!)),
                                  ],
                                ),
                              ),
                              // for (var i in snapshot.data!.data!.items![0].attributes!)
                              //   Column(
                              //     children: [
                              //       TextButton(
                              //         onPressed: () {
                              //           setState(() {
                              //             if (_collapse == true) {
                              //               _collapse = false;
                              //             } else {
                              //               _collapse = true;
                              //             }
                              //           });
                              //         },
                              //         child: Row(
                              //           children: [
                              //             const Expanded(
                              //                 child: Icon(CupertinoIcons
                              //                     .exclamationmark_circle_fill)),
                              //             Expanded(
                              //                 child:
                              //                     Text(i.nameAttribute!.name!)),
                              //             const Expanded(child: Icon(LineAwesomeIcons.add_to_shopping_cart)),
                              //           ],
                              //         ),
                              //       ),
                              //       Collapsible(
                              //         collapsed: _collapse,
                              //         axis: CollapsibleAxis.vertical,
                              //         alignment: Alignment.bottomLeft,
                              //         child: Text(i.nameAttribute!.name!),
                              //       ),
                              //     ],
                              //   ),
                            ],
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text(
                          '${snapshot.error}' "You don't have data in this time");
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          setState(() {
            _isloading = true;
          });
          if(quantityController.text.isNotEmpty) {
            if (_formKey.currentState!.validate()) {
              if (widget.token.isNotEmpty) {
                if (result != 0) {
                  AddtoCartResponseModel msg = await api.addToCart(
                      widget.token, widget.productId, widget.sku, quantity);
                  if (msg.success == true) {
                    setState(() {
                      _isloading = false;
                    });
                    if (quantity != 0) {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) {
                        return ShoppingCardScreen(
                          token: widget.token,
                          mobile: widget.mobile,
                          firstname: widget.firstname,
                          email: widget.email,
                          customerId: widget.customerId,
                        );
                      }));
                    }
                    else {
                      Fluttertoast.showToast(
                          msg: 'please select quantity',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  } else {
                    setState(() {
                      _isloading = false;
                    });
                    Fluttertoast.showToast(
                        msg: msg.message!,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                }
                else {
                  setState(() {
                    _isloading = false;
                  });
                  Fluttertoast.showToast(
                      msg: 'Something went wrong',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              }
              //
              else {
                _isloading = false;
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const LoginScreen();
                }));
              }
            }
            //
            else {
              Fluttertoast.showToast(
                  msg: 'please select quantity',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);

              setState(() {
                _isloading = false;
              });
              Fluttertoast.showToast(
                  msg: 'please select quantity',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          }else{
            setState(() {
              quantity=1;
              quantityController.text=int.parse(quantity.toString()).toString();
            });
            if (_formKey.currentState!.validate()) {
              if (widget.token.isNotEmpty) {
                if (result != 0 && result !=null) {
                  AddtoCartResponseModel msg = await api.addToCart(
                      widget.token, widget.productId, widget.sku, quantity);
                  if (msg.success == true) {
                    setState(() {
                      _isloading = false;
                    });
                    if (quantity != 0) {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) {
                        return ShoppingCardScreen(
                          token: widget.token,
                          mobile: widget.mobile,
                          firstname: widget.firstname,
                          email: widget.email,
                          customerId: widget.customerId,
                        );
                      }));
                    }
                    else {
                      Fluttertoast.showToast(
                          msg: 'please select quantity',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  } else {
                    setState(() {
                      _isloading = false;
                    });
                    Fluttertoast.showToast(
                        msg: msg.message!,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                }
                else {
                  setState(() {
                    _isloading = false;
                  });
                  Fluttertoast.showToast(
                      msg: 'Something went wrong',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              }
              //
              else {
                _isloading = false;
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const LoginScreen();
                }));
              }
            }
            //
            else {
              Fluttertoast.showToast(
                  msg: 'please select quantity',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);

              setState(() {
                _isloading = false;
              });
              Fluttertoast.showToast(
                  msg: 'please select quantity',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
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

bool isQuantityValid(String quantities) => double.parse(quantities) <= 5000;
