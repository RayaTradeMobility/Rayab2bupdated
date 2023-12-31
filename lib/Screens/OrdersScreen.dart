// ignore_for_file: file_names

import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rayab2bupdated/Constants/Constants.dart';
import 'package:rayab2bupdated/Models/GetOrdersResponseModel.dart';
import 'package:rayab2bupdated/Screens/BottomNavMenu.dart';
import 'package:rayab2bupdated/Screens/OrderDetailsScreen.dart';
import 'package:shimmer/shimmer.dart';
import '../API/API.dart';

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
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height / 9),
          child: AppBar(
            backgroundColor: MyColorsSample.fontColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
            ),
            centerTitle: true,
            // Added line to center the title
            title: const Text(
              "\n طلباتي",
              style: ArabicTextStyle(arabicFont: ArabicFont.dinNextLTArabic),
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
                  color: MyColorsSample.primary,
                ),
                labelStyle: ArabicTextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    arabicFont: ArabicFont.dinNextLTArabic),
                labelColor: Colors.white,
                unselectedLabelColor: MyColorsSample.primary,
                unselectedLabelStyle: ArabicTextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    arabicFont: ArabicFont.dinNextLTArabic),
                tabs: const [
                  Tab(
                    text: 'طلبات جارية',
                  ),
                  Tab(
                    text: 'طلبات سابقة ',
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
                                  3,
                                  (index) => Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              7.4,
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
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              4,
                                          height: 8.0,
                                          color: Colors.grey[300],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }

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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height / 6),
                                Image.asset("assets/orderscreen.png"),
                              ],
                            )
                        ]);
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Image.asset('assets/error.png'),
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
                                  3,
                                  (index) => Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
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
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              4,
                                          height: 8.0,
                                          color: Colors.grey[300],
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
                        return Column(children: [
                          for (var i in snapshot.data!.data!.items!)
                            if (i.statusId == 5 || i.statusId == 6)
                              RefreshIndicator(
                                onRefresh: _refreshData,
                                child: buildSingleChildScrollView(
                                    i.grandTotal ?? 0,
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
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 6,
                                ),
                                Image.asset("assets/orderscreen.png"),
                                const SizedBox(
                                  height: 10.0,
                                ),
                              ],
                            )
                        ]);
                      } else if (snapshot.hasError) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 6,
                            ),
                            Image.asset("assets/error.png"),
                            const SizedBox(
                              height: 10.0,
                            ),
                          ],
                        );
                      } else {
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

  Column buildSingleChildScrollView(var netTotal, String status, int orderId,
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
