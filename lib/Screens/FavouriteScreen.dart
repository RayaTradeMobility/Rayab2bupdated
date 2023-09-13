// ignore_for_file: file_names

import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/material.dart';
import 'package:rayab2bupdated/API/API.dart';
import 'package:rayab2bupdated/Constants/CardsModel.dart';
import 'package:rayab2bupdated/Constants/Constants.dart';
import 'package:rayab2bupdated/Models/FavouriteModel.dart';
import 'package:rayab2bupdated/Screens/HomeScreen.dart';

class FavouriteScreen extends StatefulWidget {
  final String token, email, mobile, firstname, customerId;

  const FavouriteScreen(
      {super.key,
      required this.token,
      required this.email,
      required this.mobile,
      required this.firstname,
      required this.customerId});

  @override
  FavouriteScreenState createState() => FavouriteScreenState();
}

class FavouriteScreenState extends State<FavouriteScreen> {
  late Future<FavouriteModel> _futureData;
  bool isLoadingMore = false;
  int currentPage = 1;
  API api = API();
  FavouriteModel? favourite;

  @override
  void initState() {
    super.initState();
    _futureData = api.getFavourite(widget.token, currentPage);
    isLoadingMore = false;
  }

  void loadMore() {
    setState(() {
      isLoadingMore = true;
      currentPage++;
    });

    api.getFavourite(widget.token, currentPage).then((data) {
      setState(() {
        if (favourite != null && favourite!.data != null && data.data != null) {
          favourite!.data!.items!.addAll(data.data!.items!);
        }
      });
    }).whenComplete(() {
      setState(() {
        isLoadingMore = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height / 9),
        child: AppBar(
          backgroundColor: MyColorsSample.fontColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(50),
            ),
          ),
          title: Center(
              child: const Text(
            "المنتجات المفضلة",
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
      body: FutureBuilder<FavouriteModel>(
        future: _futureData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            favourite = snapshot.data;
            if (favourite!.data!.items!.isEmpty) {
              return Center(
                child: Column(children: [
                  Image.asset(
                    'assets/nofavimage.png',
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width - 1,
                  ),
                  Text(
                    'لا توجد منتجات مفضله',
                    style: TextStyle(
                        color: Colors.deepPurple.withOpacity(0.7),
                        fontWeight: FontWeight.w700,
                        fontSize: 22),
                  ),
                  const SizedBox(height: 9),
                  FloatingActionButton.extended(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return HomeScreen(
                            token: widget.token,
                            email: widget.email,
                            mobile: widget.mobile,
                            firstname: widget.firstname,
                            customerId: widget.customerId,
                          );
                        }));
                      },
                      label: const Text("اختر المنتجات المفضله"),
                      backgroundColor: Colors.deepPurple.withOpacity(0.7))
                ]),
              );
            }
            return Column(
              children: [
                Expanded(
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification scrollInfo) {
                      if (!isLoadingMore &&
                          scrollInfo.metrics.pixels ==
                              scrollInfo.metrics.maxScrollExtent) {
                        loadMore();
                      }
                      return false;
                    },
                    child: SingleChildScrollView(
                      child: GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        childAspectRatio: 6 / 12,
                        physics: const NeverScrollableScrollPhysics(),
                        children: List.generate(
                          favourite!.data!.items!.length,
                          (index) {
                            final t = favourite!.data!.items![index];
                            return CardScreenModel(
                              name: t.name!,
                              salePrice: t.price!,
                              image: t.images!.imageLink!,
                              price: t.price!,
                              regularPrice: t.price!,
                              id: t.id!,
                              token: widget.token,
                              isfavouriteApi: true,
                              stockStatus: '',
                              isBundle: true,
                              percentagePrice: 1,
                              fav: 'liked',
                              sku: t.sku!,
                              email: '',
                              firstname: '',
                              mobile: '',
                              customerId: '',
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                if (isLoadingMore)
                  const Center(child: CircularProgressIndicator()),
              ],
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
