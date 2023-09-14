// ignore_for_file: file_names

import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/material.dart';
import 'package:rayab2bupdated/API/API.dart';
import 'package:rayab2bupdated/Screens/ProductScreen.dart';
import 'package:rayab2bupdated/Constants/Constants.dart';
import 'package:shimmer/shimmer.dart';
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
      required this.customerId})
      : super(key: key);
  final String token, email, mobile, firstname, customerId;

  @override
  State<ShoppingCardScreen> createState() => _ShoppingCardScreenState();
}

class _ShoppingCardScreenState extends State<ShoppingCardScreen> {
  late Future<GetCartResponseModel> card;
  API api = API();

  Future<void> _refreshData() async {
    setState(() {
      card = api.getCart(widget.token);
    });
  }

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
            mobile: widget.mobile,
            customerId: widget.customerId,
          );
        }));
        return true;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height / 16),
          child: AppBar(
            backgroundColor: MyColorsSample.fontColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(50),
              ),
            ),
            centerTitle: true,
            title: Center(
                child: const Text(
              "عربه التسوق",
              style: ArabicTextStyle(arabicFont: ArabicFont.avenirArabic),
            )),
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
        body: RefreshIndicator(
          onRefresh: _refreshData,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder<GetCartResponseModel>(
                  future: card,
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
                              childAspectRatio: 3 / 1,
                              crossAxisCount: 1,
                              children: List.generate(
                                4,
                                (index) => Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.08,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                7.6,
                                        child: Card(
                                          elevation: 10,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                          ),
                                          child: Container(),
                                        ),
                                      ),
                                      SizedBox(height: 5.0),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else if (snapshot.hasData) {
                      String totalPrice = snapshot.data!.data!.totalPrice!;
                      int totalQty = snapshot.data!.data!.totalQtyItems!;

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (snapshot.data!.success == false ||
                              snapshot.data!.data!.items!.isEmpty)
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset("assets/No_card_img.jpeg"),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  "لا توجد منتجات في عربه التسوق \n",
                                  style: TextStyle(
                                      color: MyColorsSample.primary,
                                      fontWeight: FontWeight.bold),
                                ),
                                // Text(
                                //   "and shopping now",
                                //   style: TextStyle(
                                //       color: Color(_fontcolor),
                                //       fontWeight: FontWeight.bold),
                                // ),
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
                                          mobile: widget.mobile,
                                          customerId: widget.customerId,
                                        );
                                      }));
                                    },
                                    label: const Text("تسوق الان"),
                                    backgroundColor: MyColorsSample.primary)
                              ],
                            )
                          else if (snapshot.data!.success! == true &&
                              snapshot.data!.data!.items!.isNotEmpty)
                            for (var i in snapshot.data!.data!.items!)
                              TextButton(
                                child: ShoppingCards(
                                  token: widget.token,
                                  image: i.imageUrl?.imageLink ??
                                      "assets/logo-raya.png",
                                  quantity: i.qty ?? 0,
                                  price: i.price?.replaceAll(',', '') ?? "0",
                                  productId: i.id!,
                                  sku: i.sku!,
                                  totalPriceProduct: i.totalPrice!,
                                  postTitle: i.name ?? '',
                                  cardID: i.id!.toString(),
                                  countProducts: i.qty!,
                                  totalPrice: i.totalPrice!,
                                  email: widget.email,
                                  firstname: widget.firstname,
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
                                      mobile: widget.mobile,
                                      customerId: widget.customerId,
                                    );
                                  }));
                                },
                              ),
                          if (snapshot.data!.success! == true &&
                              snapshot.data!.data!.items!.isNotEmpty)
                            FloatingActionButton.extended(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return PayScreen(
                                      token: widget.token,
                                      email: widget.email,
                                      firstname: widget.firstname,
                                      customerId: widget.customerId,
                                      totalPrice: totalPrice,
                                      totalQty: totalQty,
                                      mobile: widget.mobile,
                                    );
                                  }),
                                );
                              },
                              label: const Text("احصل على المنتج بعد الخصم"),
                              backgroundColor: MyColorsSample.primary,
                              elevation: 5,
                            ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}'
                          "You don't have data in this time");
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
      ),
    );
  }
}
