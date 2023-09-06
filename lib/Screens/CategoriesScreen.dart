// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:rayab2bupdated/API/API.dart';
import 'package:rayab2bupdated/Constants/Constants.dart';
import 'package:rayab2bupdated/Models/GetCategoriesNewResponseModel.dart';
import 'package:rayab2bupdated/Screens/BottomNavMenu.dart';
import 'package:rayab2bupdated/Screens/ModelScreen.dart';
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
        appBar: AppBar(
          backgroundColor: MyColorsSample.fontColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),
          title: const Text("الاقسام"),
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
                    if (snapshot.hasData) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height / 1.6,
                        child: GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            mainAxisSpacing: 0.0,
                            crossAxisSpacing: 0.0,
                            childAspectRatio: 1 / 1,
                            crossAxisCount: 3,
                            children: List.generate(
                              snapshot.data!.data!.items!.length,
                              (index) => Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 3.5,
                                    height: MediaQuery.of(context).size.height /
                                        7.7,
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
                                              catID: snapshot.data!.data!
                                                  .items![index].id!,
                                              categoryName: snapshot.data!.data!
                                                  .items![index].name!,
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
                                                      fit: BoxFit.cover);
                                                },
                                                fit: BoxFit.fitWidth,
                                                height: 50.0,
                                                width: 130.0,
                                              ),
                                              const SizedBox(height: 5.0),
                                              Text(
                                                snapshot.data!.data!
                                                    .items![index].name!,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 8,
                                                    fontWeight:
                                                        FontWeight.bold , ),textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}'
                          "You don't have data in this time");
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
                      'جميع الماركات',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                FutureBuilder<BrandsModel>(
                  future: brands,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          mainAxisSpacing: 0.0,
                          crossAxisSpacing: 0.0,
                          childAspectRatio: 1 / 1,
                          crossAxisCount: 3,
                          children: List.generate(
                            snapshot.data!.data!.length,
                            (index) => Row(
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
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
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
                                            FadeInImage.memoryNetwork(
                                              image: snapshot.data!.data![index]
                                                  .imageLink!,
                                              placeholder: kTransparentImage,
                                              imageErrorBuilder:
                                                  (context, error, stackTrace) {
                                                return Image.asset(
                                                    'assets/logo-raya.png',
                                                    height: 50.0,
                                                    width: 70.0,
                                                    fit: BoxFit.fitWidth);
                                              },
                                              fit: BoxFit.fitWidth,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  15,
                                            ),
                                            // const SizedBox(height: 5.0),
                                            Text(
                                              snapshot.data!.data![index].name!
                                                  .trim(),
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 8,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ));
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}'
                          "You don't have data in this time");
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
