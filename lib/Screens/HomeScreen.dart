// ignore_for_file: file_names

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:rayab2bupdated/API/API.dart';
import 'package:rayab2bupdated/Constants/CardsModel.dart';
import 'package:rayab2bupdated/Constants/Constants.dart';
import 'package:rayab2bupdated/Models/HomeResponseModel.dart';
import 'package:rayab2bupdated/Screens/CategoriesScreen.dart';
import '../Models/GetProductSearchModel.dart';
import 'ModelScreen.dart';
import 'ProductScreen.dart';
import '../Models/NotificationModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen(
      {Key? key,
      required this.token,
      required this.email,
      required this.mobile,
      required this.firstname,
      required this.customerId})
      : super(key: key);
  final String token, email, mobile, firstname, customerId;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget customSearchBar = const Text("ابحث عن شئ");
  final int _fontcolor = 0xFF4C53A5;
  Icon customIcon = const Icon(Icons.search);
  TextEditingController searchController = TextEditingController();
  int notificationCount = 0;
  NotificationModel? notifications;

  void showNotification() {
    api.getNotification(widget.token);
  }

  API api = API();
  late Future<HomeResponseModel> _home;

  @override
  void initState() {
    // TODO: implement initState
    _home = api.getHome();
    showNotification();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: MyColorsSample.fontColor,
            floating: false,
            pinned: true,
            snap: false,
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: Center(
                child: Image.asset(
              'assets/logo-raya.png',
              height: 30.0,
              width: 100.0,
            )),
            bottom: AppBar(
              backgroundColor: MyColorsSample.fontColor,
              title: customSearchBar,
              centerTitle: true,
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  onPressed: () {
                    if (customIcon.icon == Icons.search) {
                      setState(() {
                        customIcon = const Icon(Icons.cancel);
                        customSearchBar = ListTile(
                          leading: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.search,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                          title: TypeAheadField<Items>(
                            textFieldConfiguration: TextFieldConfiguration(
                              autocorrect: false,
                              autofocus: false,
                              style: DefaultTextStyle.of(context)
                                  .style
                                  .copyWith(
                                      fontStyle: FontStyle.italic,
                                      color: Colors.white),
                              decoration: const InputDecoration(
                                labelText: 'Search for product',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            suggestionsCallback: (pattern) async {
                              return await API.searchProducts(
                                  pattern, widget.token);
                            },
                            itemBuilder: (context, suggestion) {
                              return ListTile(
                                leading: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    minWidth: 44,
                                    minHeight: 44,
                                    maxWidth: 64,
                                    maxHeight: 64,
                                  ),
                                  child: FadeInImage(
                                    image: NetworkImage(
                                        suggestion.images!.imageLink!),
                                    placeholder:
                                        const AssetImage("assets/loading.png"),
                                    imageErrorBuilder:
                                        (context, error, stackTrace) {
                                      return Image.asset('assets/loading.png',
                                          height: 50.0,
                                          width: 120.0,
                                          fit: BoxFit.fitWidth);
                                    },
                                  ),
                                ),
                                title: Text(suggestion.name ?? ""),
                                subtitle: Text('\$${suggestion.price ?? ""}'),
                              );
                            },
                            onSuggestionSelected: (suggestion) {
                              final selectedSku = suggestion.sku;

                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ProductScreen(
                                    sku: selectedSku!,
                                    productId: suggestion.id!,
                                    token: widget.token,
                                    email: widget.email,
                                    firstname: widget.firstname,
                                    mobile: widget.mobile,
                                    customerId: widget.customerId,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      });
                    } else {
                      setState(() {
                        customIcon = const Icon(Icons.search);
                        customSearchBar = const Text('ابحث عن شئ');
                      });
                    }
                  },
                  icon: customIcon,
                ),
                // IconButton(
                //   icon: Stack(
                //     children: [
                //       const Icon(Icons.notification_add),
                //       if (notificationCount > 0)
                //         Positioned(
                //           right: 0,
                //           child: Container(
                //             padding: const EdgeInsets.all(2),
                //             decoration: const BoxDecoration(
                //               color: Colors.red,
                //               shape: BoxShape.circle,
                //             ),
                //             constraints: const BoxConstraints(
                //               minWidth: 18,
                //               minHeight: 18,
                //             ),
                //             child: Text(
                //               notificationCount.toString(),
                //               style: const TextStyle(
                //                 color: Colors.white,
                //                 fontSize: 12,
                //               ),
                //               textAlign: TextAlign.center,
                //             ),
                //           ),
                //         ),
                //     ],
                //   ),
                //   onPressed: () {
                //     setState(() {
                //       notificationCount++; // Increment the notification count
                //     });
                //
                //     showNotification();
                //   },
                // ),
                // Expanded(
                //   child: ListView.builder(
                //     itemCount: notifications?.data?.items?.length ?? 0,
                //     itemBuilder: (context, index) {
                //       var notification = notifications?.data?.items?[index];
                //
                //       return ListTile(
                //         title: Text(notification?.message ?? ''),
                //         subtitle: Text(notification?.id.toString() ?? ''),
                //       );
                //     },
                //   ),
                // ),
              ],
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return FutureBuilder<HomeResponseModel>(
                  future: _home,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          CarouselSlider(
                            options: CarouselOptions(
                              height: 230,
                              aspectRatio: 16 / 9,
                              viewportFraction: 0.8,
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              reverse: false,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 3),
                              autoPlayAnimationDuration:
                                  const Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: true,
                              enlargeFactor: 0.3,
                              scrollDirection: Axis.horizontal,
                            ),
                            items: [
                              "assets/About_Img.jpeg",
                              "assets/aboutimg.jpg",
                              "assets/aboutimg3.jpg",
                            ].map((imagePath) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Colors.black,
                                              style: BorderStyle.none),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(15))),
                                      child: Image.asset(
                                        imagePath,
                                        width: 400,
                                        height: 200,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'الاقسام الخاصة',
                                style: TextStyle(
                                    color: Color(_fontcolor),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                              const SizedBox(
                                width: 30.0,
                              ),
                              TextButton(
                                child: const Text(
                                  'كل الاقسام',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline),
                                ),
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return CategoriesScreen(
                                      token: widget.token,
                                      email: widget.email,
                                      mobile: widget.mobile,
                                      firstname: widget.firstname,
                                      customerId: widget.customerId,
                                    );
                                  }));
                                },
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: snapshot
                                        .data!.data![0].products!.isNotEmpty
                                    ? Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          for (var i in snapshot
                                              .data!.data![0].categories!)
                                            Column(
                                              children: [
                                                SizedBox(
                                                    height: 80.0,
                                                    width: 150.0,
                                                    child: TextButton(
                                                        child: Card(
                                                          shape:
                                                              const RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        10.0)),
                                                          ),
                                                          elevation: 5.0,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              FadeInImage(
                                                                image: NetworkImage(
                                                                    i.imageLink!),
                                                                placeholder:
                                                                    const AssetImage(
                                                                        "assets/loading.png"),
                                                                imageErrorBuilder:
                                                                    (context,
                                                                        error,
                                                                        stackTrace) {
                                                                  return Image.asset(
                                                                      'assets/loading.png',
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          7,
                                                                      height: MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          12,
                                                                      fit: BoxFit
                                                                          .fitWidth);
                                                                },
                                                                fit: BoxFit
                                                                    .fitWidth,
                                                                height: 50.0,
                                                                width: 130.0,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        onPressed: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) {
                                                            return ModelScreen(
                                                              token:
                                                                  widget.token,
                                                              categoryName:
                                                                  i.name!,
                                                              catID: i.id!,
                                                              mobile:
                                                                  widget.mobile,
                                                              firstname: widget
                                                                  .firstname,
                                                              email:
                                                                  widget.email,
                                                              customerId: widget
                                                                  .customerId,
                                                            );
                                                          }));
                                                        })),
                                                Center(
                                                    child: Text(
                                                  i.name!,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ))
                                              ],
                                            ),
                                          const SizedBox(
                                            width: 30.0,
                                          ),
                                        ],
                                      )
                                    : const Text(
                                        "لا توجد اقسام في الوقت الحالي",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'البرندات الخاصة',
                                style: TextStyle(
                                    color: Color(_fontcolor),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                              const SizedBox(
                                width: 30.0,
                              ),
                              TextButton(
                                child: const Text(
                                  'كل البرندات',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline),
                                ),
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return CategoriesScreen(
                                      token: widget.token,
                                      email: widget.email,
                                      mobile: widget.mobile,
                                      firstname: widget.firstname,
                                      customerId: widget.customerId,
                                    );
                                  }));
                                },
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: snapshot
                                        .data!.data![0].products!.isNotEmpty
                                    ? Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          for (var i in snapshot
                                              .data!.data![0].brands!)
                                            Column(
                                              children: [
                                                SizedBox(
                                                    height: 80.0,
                                                    width: 150.0,
                                                    child: TextButton(
                                                        child: Card(
                                                          shape:
                                                              const RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        10.0)),
                                                          ),
                                                          elevation: 5.0,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              FadeInImage(
                                                                image: NetworkImage(
                                                                    i.imageLink!),
                                                                placeholder:
                                                                    const AssetImage(
                                                                        "assets/loading.png"),
                                                                imageErrorBuilder:
                                                                    (context,
                                                                        error,
                                                                        stackTrace) {
                                                                  return Image.asset(
                                                                      'assets/loading.png',
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          7,
                                                                      height: MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          12,
                                                                      fit: BoxFit
                                                                          .fitWidth);
                                                                },
                                                                fit: BoxFit
                                                                    .fitWidth,
                                                                height: 50.0,
                                                                width: 130.0,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        onPressed: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) {
                                                            return ModelScreen(
                                                              token:
                                                                  widget.token,
                                                              categoryName:
                                                                  i.name!,
                                                              catID: i.id!,
                                                              mobile:
                                                                  widget.mobile,
                                                              firstname: widget
                                                                  .firstname,
                                                              email:
                                                                  widget.email,
                                                              customerId: widget
                                                                  .customerId,
                                                            );
                                                          }));
                                                        })),
                                                Center(
                                                    child: Text(
                                                  i.name!,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ))
                                              ],
                                            ),
                                          const SizedBox(
                                            width: 30.0,
                                          ),
                                        ],
                                      )
                                    : const Text(
                                        "لا توجد اقسام في الوقت الحالي",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'العروض',
                                style: TextStyle(
                                    color: Color(_fontcolor),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                              const SizedBox(
                                width: 80.0,
                              ),
                              TextButton(
                                child: const Text(
                                  'كل العروض',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: snapshot.data!.data![0].products!.isNotEmpty
                                ? Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      for (var t
                                          in snapshot.data!.data![0].products!)
                                        CardScreenModel(
                                          name: t.name!,
                                          salePrice: t.price!,
                                          image: t.images!.imageLink!,
                                          price: t.price!,
                                          regularPrice: t.price!,
                                          id: t.id!,
                                          token: widget.token,
                                          isfavouriteApi: false,
                                          stockStatus: '',
                                          isBundle: false,
                                          percentagePrice: 0,
                                          fav: 'false',
                                          sku: t.sku!,
                                          email: widget.email,
                                          mobile: widget.mobile,
                                          firstname: widget.firstname,
                                          customerId: widget.customerId,
                                        ),
                                    ],
                                  )
                                : const Text("لا توجد عروض في الوقت الحالي"),
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}'
                          "You don't have data in this time");
                    }
                    return const Padding(
                        padding: EdgeInsets.only(top: 280),
                        child: Center(child: CircularProgressIndicator()));
                  });
            },
            childCount: 1,
            semanticIndexOffset: 1,
          ))
        ],
      ),
    );
  }
}
