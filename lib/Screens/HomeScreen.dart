// ignore_for_file: file_names

import 'package:arabic_font/arabic_font.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
// import 'package:particles_flutter/particles_flutter.dart';
import 'package:rayab2bupdated/API/API.dart';
import 'package:rayab2bupdated/Constants/CardsModel.dart';
import 'package:rayab2bupdated/Constants/Constants.dart';
import 'package:rayab2bupdated/Models/HomeResponseModel.dart';
import 'package:rayab2bupdated/Screens/CategoriesScreen.dart';
import 'package:shimmer/shimmer.dart';
import 'package:transparent_image/transparent_image.dart';
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
    _home = api.getHome(widget.token);
    showNotification();

    super.initState();
  }

  Future<void> _refreshData() async {
    setState(() {
      _home = api.getHome(widget.token);
    });
  }

  @override
  Widget build(BuildContext context) {
    // double h = MediaQuery.of(context).size.height;
    // double w = MediaQuery.of(context).size.width;

    return Scaffold(
          body: RefreshIndicator(
            onRefresh: _refreshData,
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: MediaQuery.of(context).size.height / 5,
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                  backgroundColor: MyColorsSample.fontColor,
                  floating: false,
                  pinned: false,
                  snap: false,
                  centerTitle: true,
                  automaticallyImplyLeading: false,
                  flexibleSpace: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.topRight,
                        colors: [
                          MyColorsSample.primary,
                          MyColorsSample.teal,
                          // Colors.white,
                        ],
                      ),
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,


                      children: [
                        Image.asset(
                          'assets/appbarlogo1.png',
                          height: MediaQuery.of(context).size.height/8,
                          width: MediaQuery.of(context).size.height/2,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: MyColorsSample.primary,
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: TypeAheadField<Items>(
                              textFieldConfiguration: TextFieldConfiguration(
                                autocorrect: false,
                                autofocus: false,
                                style: DefaultTextStyle.of(context).style.copyWith(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.white,
                                ),
                                decoration: InputDecoration(
                                  labelText: 'Search',
                                  labelStyle: TextStyle(color: Colors.white),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  prefixIcon: Icon(LineAwesomeIcons.search, color: Colors.white),
                                ),
                              ),
                              suggestionsCallback: (pattern) async {
                                return await API.searchProducts(pattern, widget.token);
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
                                    child: FadeInImage.memoryNetwork(
                                      image: suggestion.images!.imageLink!,
                                      placeholder: kTransparentImage,
                                      imageErrorBuilder: (context, error, stackTrace) {
                                        return Image.asset(
                                          'assets/logo-raya.png',
                                          height: 40.0,
                                          width: 150.0,
                                          fit: BoxFit.fitWidth,
                                        );
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

                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return FutureBuilder<HomeResponseModel>(
                        future: _home,
                        builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 22,
                              ),
                              Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: CarouselSlider(
                                    options: CarouselOptions(
                                      height: 200,
                                      aspectRatio: 2 / 1,
                                      viewportFraction: 0.8,
                                      initialPage: 0,
                                      enableInfiniteScroll: true,
                                      reverse: false,
                                      autoPlay: true,
                                      autoPlayInterval:
                                          const Duration(seconds: 3),
                                      autoPlayAnimationDuration:
                                          const Duration(milliseconds: 800),
                                      autoPlayCurve: Curves.fastOutSlowIn,
                                      enlargeCenterPage: true,
                                      enlargeFactor: 0.3,
                                      scrollDirection: Axis.horizontal,
                                    ),
                                    items: [
                                      "assets/panel.png",
                                      "assets/panel.png",
                                      "assets/panel.png",
                                    ].map((imagePath) {
                                      return Builder(
                                        builder: (BuildContext context) {
                                          return SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Container(
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                              ),
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
                                ),
                              ),
                              GridView.count(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                mainAxisSpacing: 0.0,
                                crossAxisSpacing: 0.0,
                                childAspectRatio: 1 / 1,
                                crossAxisCount: 3,
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
                                              3.5,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              9.7,
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
                              GridView.count(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                mainAxisSpacing: 0.0,
                                crossAxisSpacing: 0.0,
                                childAspectRatio: 1 / 1,
                                crossAxisCount: 3,
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
                                              3.5,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              9.7,
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
                            return Column(
                              children: [
                                SizedBox(height: 22,),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: CarouselSlider(
                                    options: CarouselOptions(
                                      height: 200,
                                      aspectRatio: 2 / 1,
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
                                      "assets/panel.png",
                                      "assets/panel.png",
                                      "assets/panel.png",

                                      // "assets/About_Img.jpeg",
                                      // "assets/aboutimg3.jpg",
                                    ].map((imagePath) {
                                      return Builder(
                                        builder: (BuildContext context) {
                                          return SizedBox(
                                            width: MediaQuery.of(context).size.width,
                                            child: Container(
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:BorderRadius.circular(25)),
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
                                ),
                                SizedBox(height: 25,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '   الاقسام المميزة',
                                      style: ArabicTextStyle(
                          arabicFont: ArabicFont.amiri,
                                          color: Colors.black,
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
                                SizedBox(height: 5,),

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: snapshot
                                              .data!.data![0].categories!.isNotEmpty
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
                                                                  borderRadius: BorderRadius
                                                                      .all(Radius
                                                                          .circular(
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
                                                                    FadeInImage
                                                                        .memoryNetwork(
                                                                      image: i
                                                                          .imageLink!,
                                                                      placeholder:
                                                                          kTransparentImage,
                                                                      imageErrorBuilder:
                                                                          (context,
                                                                              error,
                                                                              stackTrace) {
                                                                        return Image.asset(
                                                                            'assets/logo-raya.png',
                                                                            width:
                                                                                MediaQuery.of(context).size.width /
                                                                                    3,
                                                                            height:
                                                                                MediaQuery.of(context).size.width /
                                                                                    8,
                                                                            fit: BoxFit
                                                                                .fitWidth);
                                                                      },
                                                                      fit: BoxFit
                                                                          .fitWidth,
                                                                      height: 50.0,
                                                                      width: 150.0,
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
                                                                    token: widget
                                                                        .token,
                                                                    categoryName:
                                                                        i.name!,
                                                                    catID: i.id!,
                                                                    mobile: widget
                                                                        .mobile,
                                                                    firstname: widget
                                                                        .firstname,
                                                                    email: widget
                                                                        .email,
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
                                SizedBox(
                                  height: 25,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '   البرندات المميزه',
                                  style: ArabicTextStyle(
                          arabicFont: ArabicFont.amiri,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),),
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
                                SizedBox(height: 5,),

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child:
                                          snapshot.data!.data![0].brands!.isNotEmpty
                                              ? Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
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
                                                                        FadeInImage
                                                                            .memoryNetwork(
                                                                          image: i
                                                                              .imageLink!,
                                                                          placeholder:
                                                                              kTransparentImage,
                                                                          imageErrorBuilder: (context,
                                                                              error,
                                                                              stackTrace) {
                                                                            return Image.asset(
                                                                                'assets/logo-raya.png',
                                                                                width: MediaQuery.of(context).size.width /
                                                                                    3,
                                                                                height: MediaQuery.of(context).size.width /
                                                                                    8,
                                                                                fit:
                                                                                    BoxFit.fitWidth);
                                                                          },
                                                                          fit: BoxFit
                                                                              .fitWidth,
                                                                          height:
                                                                              50.0,
                                                                          width:
                                                                              130.0,
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
                                                                        token: widget
                                                                            .token,
                                                                        categoryName:
                                                                            i.name!,
                                                                        catID:
                                                                            i.id!,
                                                                        mobile: widget
                                                                            .mobile,
                                                                        firstname:
                                                                            widget
                                                                                .firstname,
                                                                        email: widget
                                                                            .email,
                                                                        customerId:
                                                                            widget
                                                                                .customerId,
                                                                      );
                                                                    }));
                                                                  })),
                                                          Center(
                                                              child: Text(
                                                            i.name!,
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
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
                                      '   العروض',
                                      style: ArabicTextStyle(
                                          arabicFont: ArabicFont.amiri,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0),),
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
                                  child: snapshot
                                          .data!.data![0].products!.isNotEmpty
                                      ? Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            for (var t in snapshot
                                                .data!.data![0].products!)
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
                                ",s You don't have data in this time");
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
          ),


    );
  }
}
