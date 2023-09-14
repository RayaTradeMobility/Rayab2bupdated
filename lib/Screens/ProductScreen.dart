// ignore_for_file: file_names, use_build_context_synchronously

import 'package:collapsible/collapsible.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:transparent_image/transparent_image.dart';

import '../API/API.dart';
import '../Constants/Constants.dart';
import '../Models/AddtoCartResponseModel.dart';
import '../Models/GetProductScreenModel.dart';
import 'LoginScreen.dart';
import 'ShoppingCardScreen.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({
    Key? key,
    required this.sku,
    required this.token,
    required this.email,
    required this.mobile,
    required this.firstname,
    required this.customerId,
    required this.productId,
  }) : super(key: key);
  final String sku, token, email, mobile, firstname, customerId;
  final int productId;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  bool _collapse = false;
  late Future<ProductbySkuModel> _product;
  final int _fontcolor = 0xFF031639;
  double total = 0;
  TextEditingController quantityController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  double? result;

  API api = API();
  int quantity = 1;
  bool _isloading = false;

  @override
  void initState() {
    _product = api.getProductBySku(widget.sku, widget.token);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height / 16),
        child: AppBar(
          backgroundColor: MyColorsSample.fontColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(50),
            ),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  MyColorsSample.primary,
                  MyColorsSample.teal,
                ],
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 60.0),
          child: SingleChildScrollView(
            child: FutureBuilder<ProductbySkuModel>(
                future: _product,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 22,
                          ),
                          GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            mainAxisSpacing: 3.0,
                            crossAxisSpacing: 3.0,
                            childAspectRatio: 1 / 1,
                            crossAxisCount: 1,
                            children: List.generate(
                              1,
                              (index) => Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 1,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3.6,
                                      child: Card(
                                        elevation: 10,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        child: Container(),
                                      ),
                                    ),
                                    SizedBox(height: 38.0),
                                    Divider(
                                      thickness: 3,
                                    ),
                                    SizedBox(height: 12.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3,
                                          height: 8.0,
                                          color: Colors.grey[300],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 18.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.5,
                                          height: 8.0,
                                          color: Colors.grey[300],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Divider(
                                      thickness: 2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (snapshot.hasData) {
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
                                if (snapshot.data!.data!.images!.isEmpty)
                                  Image.asset(
                                    'assets/logo-raya.png',
                                    width:
                                        MediaQuery.of(context).size.width / 1.6,
                                    height: MediaQuery.of(context).size.height /
                                        2.8,
                                  )
                                else
                                  //slider
                                  for (var i in snapshot.data!.data!.images!)
                                    FadeInImage.memoryNetwork(
                                      image: i.imageLink ??
                                          'https://www.google.com/url?sa=i&url=https%3A%2F%2Frayacorp.com%2F&psig=AOvVaw1EHF8VcdSB-ZEH4AydtjcN&ust=1693557822972000&source=images&cd=vfe&opi=89978449&ved=0CBAQjRxqFwoTCOiLjtrAhoEDFQAAAAAdAAAAABAJ',
                                      width: MediaQuery.of(context).size.width /
                                          1.6,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2.8,
                                      placeholder: kTransparentImage,
                                      imageErrorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                          'assets/logo-raya.png',
                                          fit: BoxFit.fitWidth,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.6,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
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
                                      double sale = double.parse(snapshot
                                          .data!.data!.priceWithoutComma!);
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
                                        FilteringTextInputFormatter.digitsOnly,
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
                                          if (quantityController
                                              .text.isNotEmpty) {
                                            quantity = int.tryParse(
                                                    quantityController.text) ??
                                                1;
                                            if (quantity != 0) {
                                              double sale;
                                              try {
                                                sale = double.parse(snapshot
                                                    .data!
                                                    .data!
                                                    .priceWithoutComma!);
                                              } catch (e) {
                                                if (kDebugMode) {
                                                  print(
                                                      'Error parsing double value: $e');
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
                                        double sale = double.parse(snapshot
                                            .data!.data!.priceWithoutComma!);
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
                          child: const Padding(
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
                            Text("SKU:  ${widget.sku}"),
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
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Image.asset('assets/error.png'),
                    );
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
            AddtoCartResponseModel msg = await api.addToCart(
                widget.token, widget.productId, widget.sku, quantity);
            if (msg.success == true) {
              setState(() {
                _isloading = false;
              });
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ShoppingCardScreen(
                  token: widget.token,
                  mobile: widget.mobile,
                  firstname: widget.firstname,
                  email: widget.email,
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

  bool isQuantityValid(String quantities) => double.parse(quantities) <= 5000;
}
