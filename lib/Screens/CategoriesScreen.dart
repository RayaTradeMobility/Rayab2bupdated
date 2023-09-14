// ignore_for_file: file_names

import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/material.dart';
import 'package:rayab2bupdated/API/API.dart';
import 'package:rayab2bupdated/Constants/Constants.dart';
import 'package:rayab2bupdated/Models/GetCategoriesNewResponseModel.dart';
import 'package:rayab2bupdated/Screens/BottomNavMenu.dart';
import 'package:rayab2bupdated/Screens/ModelScreen.dart';
import 'package:shimmer/shimmer.dart';
import 'package:transparent_image/transparent_image.dart';

import '../Models/BrandModel.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen(
      {Key? key,
      required this.token,
      required this.email,
      required this.mobile,
      required this.firstname,
      required this.customerId})
      : super(key: key);
  final String token, email, mobile, firstname, customerId;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  late Future<GetCategoriesNewResponseModel> cat;
  late Future<BrandsModel> brands;

  API api = API();

  @override
  void initState() {
    // TODO: implement initState
    cat = api.getCategoriesNew(null);
    brands = api.getBrands(widget.token);
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
              Size.fromHeight(MediaQuery.of(context).size.height / 9),
          child: AppBar(
            backgroundColor: MyColorsSample.fontColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(50),
              ),
            ),
            centerTitle: true,
            // Added line to center the title
            title: const Text(
              "\n شركائنا",
              style: ArabicTextStyle(arabicFont: ArabicFont.avenirArabic),
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
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder<GetCategoriesNewResponseModel>(
                  future: cat,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        mainAxisSpacing: 0.0,
                        crossAxisSpacing: 0.0,
                        childAspectRatio: 1 / 1,
                        crossAxisCount: 3,
                        children: List.generate(
                          9,
                          (index) => Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Column(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 3.5,
                                  height:
                                      MediaQuery.of(context).size.height / 9.7,
                                  child: Card(
                                    elevation: 10,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: Container(),
                                  ),
                                ),
                                SizedBox(height: 5.0),
                                Container(
                                  width: MediaQuery.of(context).size.width / 4,
                                  height: 8.0,
                                  color: Colors.grey[300],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else if (snapshot.hasData) {
                      // Display actual data
                      return GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        mainAxisSpacing: 0.0,
                        crossAxisSpacing: 0.0,
                        childAspectRatio: 1 / 1,
                        crossAxisCount: 3,
                        children: List.generate(
                          snapshot.data!.data!.items!.length,
                          (index) => Column(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 3.5,
                                height:
                                    MediaQuery.of(context).size.height / 9.7,
                                child: Card(
                                  elevation: 10,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return ModelScreen(
                                          token: widget.token,
                                          catID: snapshot
                                              .data!.data!.items![index].id!,
                                          categoryName: snapshot
                                              .data!.data!.items![index].name!,
                                          email: widget.email,
                                          mobile: widget.mobile,
                                          firstname: widget.firstname,
                                          customerId: widget.customerId,
                                        );
                                      }));
                                    },
                                    child: Center(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          FadeInImage.memoryNetwork(
                                            image: snapshot.data!.data!
                                                .items![index].imageLink!,
                                            placeholder: kTransparentImage,
                                            imageErrorBuilder:
                                                (context, error, stackTrace) {
                                              return Image.asset(
                                                'assets/logo-raya.png',
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    21,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    19,
                                                fit: BoxFit.cover,
                                              );
                                            },
                                            fit: BoxFit.fitWidth,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                4.5,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                15.7,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 5.0),
                              Text(
                                snapshot.data!.data!.items![index].name!,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      // Show error message if there's an error
                      return Center(
                        child: Image.asset('assets/error.png'),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '  جميع الماركات',
                      style: ArabicTextStyle(
                          arabicFont: ArabicFont.amiri,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                FutureBuilder<BrandsModel>(
                  future: brands,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        mainAxisSpacing: 0.0,
                        crossAxisSpacing: 0.0,
                        childAspectRatio: 1 / 1,
                        crossAxisCount: 3,
                        children: List.generate(
                          6,
                          (index) => Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Column(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 3.5,
                                  height:
                                      MediaQuery.of(context).size.height / 9.7,
                                  child: Card(
                                    elevation: 10,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: Container(),
                                  ),
                                ),
                                SizedBox(height: 5.0),
                                Container(
                                  width: MediaQuery.of(context).size.width / 4,
                                  height: 8.0,
                                  color: Colors.grey[300],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else if (snapshot.hasData) {
                      // Display actual data
                      return Column(
                        children: [
                          GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            mainAxisSpacing: 0.0,
                            crossAxisSpacing: 0.0,
                            childAspectRatio: 1 / 1,
                            crossAxisCount: 3,
                            children: List.generate(
                              snapshot.data!.data!.length,
                              (index) => Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height / 9,
                                    width:
                                        MediaQuery.of(context).size.width / 3.2,
                                    child: Card(
                                      elevation: 10,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return ModelScreen(
                                              token: widget.token,
                                              catID: 0,
                                              categoryName: snapshot
                                                  .data!.data![index].name!,
                                              email: widget.email,
                                              mobile: widget.mobile,
                                              firstname: widget.firstname,
                                              customerId: widget.customerId,
                                            );
                                          }));
                                        },
                                        child: Center(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const SizedBox(
                                                height: 4,
                                              ),
                                              FadeInImage.memoryNetwork(
                                                image: snapshot.data!
                                                    .data![index].imageLink!,
                                                placeholder: kTransparentImage,
                                                imageErrorBuilder: (context,
                                                    error, stackTrace) {
                                                  return Image.asset(
                                                    'assets/logo-raya.png',
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            21,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            19,
                                                    fit: BoxFit.cover,
                                                  );
                                                },
                                                fit: BoxFit.fitWidth,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    4.5,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    15.7,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5.0),
                                  Text(
                                    snapshot.data!.data![index].name!,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          )
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Image.asset('assets/error.png'),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
