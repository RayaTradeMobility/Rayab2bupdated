// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rayab2bupdated/Constants/Constants.dart';
import 'package:rayab2bupdated/Models/GetOrdersResponseModel.dart';
import 'package:rayab2bupdated/Screens/BottomNavMenu.dart';
import 'package:rayab2bupdated/Screens/LoginScreen.dart';
import 'package:rayab2bupdated/Screens/OrderDetailsScreen.dart';
import '../API/API.dart';
import 'CategoriesScreen.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen(
      {super.key,
        required this.token,
        required this.email,
        required this.mobile,
        required this.firstname,
        required this.customerId,
        required this.orderId});

  final String token, email, mobile, firstname, customerId, orderId;

  @override
  OrdersScreenState createState() => OrdersScreenState();
}

class OrdersScreenState extends State<OrdersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final int _fontColor = 0xFF031639;
  API api = API();
  bool noOrder = false;
  late Future<GetOrdersResponseModel> _futureData;
  GetOrdersResponseModel? order;

  Future<void> _refreshData() async {
    setState(() {
      _futureData = api.getOrders(widget.token);
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    if (kDebugMode) {
      print(widget.token);
    }
    _futureData = api.getOrders(widget.token);
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return BottomNavMenu(
            token: widget.token,
            mobile: widget.mobile,
            firstname: widget.firstname,
            email: widget.email,
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
          title:  const Text("طلباتي"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Container(
              height: 45,
              decoration: BoxDecoration(
                color: Colors.white60,
                borderRadius: BorderRadius.circular(
                  25.0,
                ),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    25.0,
                  ),
                  color: Colors.grey.withOpacity(0.3),
                ),
                labelStyle:
                const TextStyle(fontWeight: FontWeight.w900, fontSize: 15),
                labelColor: MyColorsSample.primary,
                unselectedLabelColor: MyColorsSample.primary,
                tabs: const [
                  Tab(
                    text: 'الطلبات الجاريه',
                  ),
                  Tab(
                    text: 'الطلبات السابقة',
                  ),
                ],
              ),
            ),
            Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    SingleChildScrollView(
                      child: FutureBuilder<GetOrdersResponseModel>(
                        future: _futureData,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Column(children: [
                              for (var i in snapshot.data!.data!.items!)
                                if (i.statusId != 5 && i.statusId != 6)
                                  buildSingleChildScrollView(
                                      i.grandTotal ?? 0,
                                      i.statusName ?? '',
                                      i.orderId ?? 0,
                                      i.createdAt ?? '',
                                      i.totalQty ?? 0),
                              if (snapshot.data!.data!.items!.isEmpty)
                                Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/No_orders_img.jpeg"),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      "لا يوجد طلبات الان تسوق و تابع طلبك",
                                      style: TextStyle(
                                          color: Color(_fontColor),
                                          fontWeight: FontWeight.w900),
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    FloatingActionButton.extended(
                                        onPressed: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                                    return CategoriesScreen(
                                                        token: widget.token,
                                                        email: widget.email,
                                                        customerId: widget.customerId,
                                                        firstname: widget.firstname,
                                                        mobile: widget.mobile);
                                                  }));
                                        },
                                        label: const Text("تسوق الان"),
                                        backgroundColor: Color(_fontColor))
                                  ],
                                )
                            ]);
                          } else if (snapshot.hasError)
                          {
                            return Center(
                              child: TextButton(
                                child: const Text('Login'),
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                        return const LoginScreen();
                                      }));
                                },
                              ),
                            );
                          } else {
                            return const Padding(
                              padding: EdgeInsets.all(180.0),
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ),
                    // second tab bar view widget
                    SingleChildScrollView(
                      child: FutureBuilder<GetOrdersResponseModel>(
                        future: _futureData,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Column(children: [
                              for (var i in snapshot.data!.data!.items!)
                                if (i.statusId == 5 || i.statusId == 6)
                                  RefreshIndicator(
                                    onRefresh: _refreshData,
                                    child: buildSingleChildScrollView(
                                        i.grandTotal!,
                                        i.statusName!,
                                        i.orderId!,
                                        i.createdAt!,
                                        i.totalQty!),
                                  ),
                              if (snapshot.data!.data!.items!.isEmpty)
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/No_orders_img.jpeg"),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      "You don't have any order yet Shopping now and track your order",
                                      style: TextStyle(
                                          color: Color(_fontColor),
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
                                                    customerId: widget.customerId,
                                                    firstname: widget.firstname,
                                                    mobile: widget.mobile);
                                              }));
                                        },
                                        label: const Text("Shopping now"),
                                        backgroundColor: Color(_fontColor))
                                  ],
                                )
                            ]);
                          } else if (snapshot.hasError) {
                            return Center(
                              child: TextButton(
                                child: const Text('Login'),
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                        return const LoginScreen();
                                      }));
                                },
                              ),
                            );
                          }
                          else {
                            return const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(180.0),
                                  child: CircularProgressIndicator(),
                                ));
                          }
                        },
                      ),
                    ),
                  ],
                )),
          ]),
        ),
      ),
    );
  }

  Column buildSingleChildScrollView(int netTotal, String status, int orderId,
      String createdDate, int qtyTotal) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            child: Card(
              elevation: 10.0,
              child: TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return OrderDetailsScreen(
                        token: widget.token,
                        customerId: widget.customerId,
                        orderId: orderId);
                  }));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            " طلب رقم  $orderId#",
                            style: const TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w900,
                                color: MyColorsSample.primary),
                          ),
                          SizedBox(
                              width: 80,
                              height: 30,
                              child: Card(
                                  color: Colors.blue.withOpacity(0.4),
                                  child:
                                  Center(child: Text(status.toString()))))
                        ],
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            ' تاريخ الطلب ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(_fontColor)),
                          ),
                          Text(
                            '$createdDate ',
                            style: TextStyle(color: Color(_fontColor)),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [],
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'عدد المنتجات ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(_fontColor)),
                          ),
                          Text(
                            '$qtyTotal',
                            style: TextStyle(color: Color(_fontColor)),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      const Divider(
                        color: Colors.black,
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'اجمالي الفاتورة  ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(_fontColor)),
                          ),
                          Text(
                            ' ${netTotal.toString()} ج.م',
                            style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            ' ميعاد التسديد  ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(_fontColor)),
                          ),
                          Text(
                            createdDate,
                            style: TextStyle(color: Color(_fontColor)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}