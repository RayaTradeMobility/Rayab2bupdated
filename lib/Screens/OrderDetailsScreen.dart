// ignore_for_file: file_names

import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/material.dart';
import 'package:rayab2bupdated/Constants/Constants.dart';
import 'package:rayab2bupdated/Models/OrderDetailsResponseModel.dart';
import 'package:shimmer/shimmer.dart';
import '../API/API.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({
    Key? key,
    required this.token,
    required this.customerId,
    required this.orderId,
  }) : super(key: key);

  final String token, customerId;
  final int orderId;

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  late Future<OrderDetailsResponseModel> _futureData;
  OrderDetailsResponseModel? order;
  API api = API();

  @override
  void initState() {
    _futureData = api.getOrdersDetails(
      widget.token,
      widget.orderId,
    );
    super.initState();
  }

  Future<void> _refreshData() async {
    setState(() {
      _futureData = api.getOrdersDetails(
        widget.token,
        widget.orderId,
      );
    });
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
          title: Center(
              child: const Text(
            "تفاصيل الطلب",
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<OrderDetailsResponseModel>(
          future: _futureData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                child: SingleChildScrollView(
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
                        childAspectRatio: 2 / 1,
                        crossAxisCount: 1,
                        children: List.generate(
                          2,
                          (index) => Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 4,
                                      height: 8.0,
                                      color: Colors.grey[300],
                                    ),
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 4,
                                      height: 8.0,
                                      color: Colors.grey[300],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 24,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 6,
                                      height: 8.0,
                                      color: Colors.grey[300],
                                    ),
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 6,
                                      height: 8.0,
                                      color: Colors.grey[300],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 18,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 6,
                                      height: 8.0,
                                      color: Colors.grey[300],
                                    ),
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 6,
                                      height: 8.0,
                                      color: Colors.grey[300],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 18,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 6,
                                      height: 8.0,
                                      color: Colors.grey[300],
                                    ),
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 6,
                                      height: 8.0,
                                      color: Colors.grey[300],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 28,
                                ),
                                const Divider(
                                  thickness: 5.0,
                                ),
                                // SizedBox(
                                //   width: MediaQuery.of(context)
                                //       .size
                                //       .width /
                                //       1,
                                //   height: MediaQuery.of(context)
                                //       .size
                                //       .height /
                                //       7.6,
                                //   child: Card(
                                //     elevation: 10,
                                //     shape: const RoundedRectangleBorder(
                                //       borderRadius: BorderRadius.all(
                                //           Radius.circular(10)),
                                //     ),
                                //     child: Container(),
                                //   ),
                                // ),
                                SizedBox(height: 5.0),
                                // Container(
                                //   width: MediaQuery.of(context)
                                //       .size
                                //       .width /
                                //       4,
                                //   height: 8.0,
                                //   color: Colors.grey[300],
                                // ),
                              ],
                            ),
                          ),
                        ),
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 4,
                                      height: 8.0,
                                      color: Colors.grey[300],
                                    ),
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 4,
                                      height: 8.0,
                                      color: Colors.grey[300],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 24,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 6,
                                      height: 8.0,
                                      color: Colors.grey[300],
                                    ),
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 6,
                                      height: 8.0,
                                      color: Colors.grey[300],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 18,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 6,
                                      height: 8.0,
                                      color: Colors.grey[300],
                                    ),
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 6,
                                      height: 8.0,
                                      color: Colors.grey[300],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 18,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 6,
                                      height: 8.0,
                                      color: Colors.grey[300],
                                    ),
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 6,
                                      height: 8.0,
                                      color: Colors.grey[300],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 18,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 6,
                                      height: 8.0,
                                      color: Colors.grey[300],
                                    ),
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 6,
                                      height: 8.0,
                                      color: Colors.grey[300],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 28,
                                ),
                                Divider(
                                  thickness: 2,
                                ),
                                SizedBox(
                                  height: 28,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 4,
                                      height: 8.0,
                                      color: Colors.grey[300],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 24,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 1,
                                  height:
                                      MediaQuery.of(context).size.height / 7.6,
                                  child: Card(
                                    elevation: 10,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: Container(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasData) {
              order = snapshot.data;
              if (order!.data!.items!.isEmpty) {
                return const Center(
                  child: Text('No data available.'),
                );
              }
              return RefreshIndicator(
                onRefresh: _refreshData,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'طلب رقم ${order!.data?.orderId}#',
                            style: TextStyle(
                              color: MyColorsSample.primary,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            color: Colors.blue.withOpacity(0.2),
                            child: Text(
                              ' ${order!.data?.statusName}',
                              style: TextStyle(
                                color: Colors.blue.withOpacity(0.8),
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'تاريخ الطلب',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${order!.data!.createdAt!}  ',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'معاد التوصيل',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'الجمعه 18/02/2022 ',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // const Divider(
                      //   thickness: 2.0,
                      // ),
                      // const SizedBox(height: 20),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text(
                      //       'اجمالي الفاتوره ',
                      //       style: TextStyle(
                      //         color: Colors.black.withOpacity(0.5),
                      //         fontSize: 12,
                      //         fontWeight: FontWeight.bold,
                      //       ),
                      //     ),
                      //     Text(
                      //       '${order!.data?.grandTotal!} ج.م ',
                      //       style: const TextStyle(
                      //           color: MyColorsSample.primary,
                      //           fontSize: 12,
                      //           fontWeight: FontWeight.w800),
                      //     ),
                      //   ],
                      // ),
                      const SizedBox(height: 20),
                      const Divider(
                        thickness: 2.0,
                      ),
                      const Row(
                        children: [
                          Icon(
                            Icons.payment,
                            color: Colors.blue,
                          ),
                          Text(
                            '  تفاصيل الدفع',
                            style: TextStyle(
                              color: MyColorsSample.primary,
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                      // const SizedBox(height: 40),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text(
                      //       ' المنتجات(${order!.data!.totalQty!}) ',
                      //       style: TextStyle(
                      //         color: Colors.black.withOpacity(0.5),
                      //         fontSize: 12,
                      //         fontWeight: FontWeight.bold,
                      //       ),
                      //     ),
                      //     Text(
                      //       '${order!.data?.grandTotal!} ج.م ',
                      //       style: const TextStyle(
                      //           color: MyColorsSample.primary,
                      //           fontSize: 12,
                      //           fontWeight: FontWeight.w800),
                      //     ),
                      //   ],
                      // ),
                      // const SizedBox(height: 25),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text(
                      //       ' رصيدك ',
                      //       style: TextStyle(
                      //         color: Colors.black.withOpacity(0.5),
                      //         fontSize: 12,
                      //         fontWeight: FontWeight.bold,
                      //       ),
                      //     ),
                      //     const Text(
                      //       '0 ج.م ',
                      //       style: TextStyle(
                      //           color: MyColorsSample.primary,
                      //           fontSize: 12,
                      //           fontWeight: FontWeight.w800),
                      //     ),
                      //   ],
                      // ),
                      // const SizedBox(height: 25),
                      // const Divider(
                      //   thickness: 2.0,
                      // ),
                      const SizedBox(height: 25),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            ' الاجمالي ',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${order!.data?.grandTotal!} ج.م ',
                            style: const TextStyle(
                                color: MyColorsSample.primary,
                                fontSize: 12,
                                fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            ' طريقه الدفع ',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${order!.data!.paymentMethodName} ',
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 12,
                                fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'ميعاد التسديد',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '(يوم) 17/02/2022 ',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      const Divider(
                        thickness: 2.0,
                      ),
                      const Row(
                        children: [
                          Icon(
                            Icons.fire_truck_outlined,
                            color: Colors.blue,
                          ),
                          Text(
                            '  تفاصيل الشحن',
                            style: TextStyle(
                              color: MyColorsSample.primary,
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            ' اسم المنشأه ',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            order!.data!.companyName ?? "",
                            style: const TextStyle(
                                color: MyColorsSample.primary,
                                fontSize: 12,
                                fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            ' رقم الهاتف ',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            order!.data!.mobile!,
                            style: const TextStyle(
                                color: MyColorsSample.primary,
                                fontSize: 12,
                                fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            ' العنوان',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${order!.data!.getAddress!.fullAddress!} ',
                            style: const TextStyle(
                                color: MyColorsSample.primary,
                                fontSize: 12,
                                fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            ' مصاريف الشحن ',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${order!.data?.shippingAmount!}',
                            style: const TextStyle(
                                color: MyColorsSample.primary,
                                fontSize: 12,
                                fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      const Divider(
                        thickness: 2.0,
                      ),
                      const Row(
                        children: [
                          Icon(
                            Icons.list_alt,
                            color: Colors.blue,
                          ),
                          Text(
                            '  المنتجات ',
                            style: TextStyle(
                              color: MyColorsSample.primary,
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: order!.data?.items?.length ?? 0,
                        itemBuilder: (context, index) {
                          var item = order!.data!.items![index];
                          return ListTile(
                            leading: Image.network(item.imageUrl!.imageLink!),
                            title: Text(item.name ?? ''),
                            subtitle: Text(
                                'Price: ${item.price!.replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "")}'),
                            trailing: Text('Qty: ${item.qty!}'),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Image.asset(
                    'assets/error.png'
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
