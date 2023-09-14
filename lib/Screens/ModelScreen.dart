// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:rayab2bupdated/API/API.dart';
import 'package:rayab2bupdated/Constants/CardsModel.dart';
import 'package:rayab2bupdated/Constants/Constants.dart';
import 'package:shimmer/shimmer.dart';
import 'package:transparent_image/transparent_image.dart';
import '../Models/GetProductSearchModel.dart';
import 'ProductScreen.dart';

class ModelScreen extends StatefulWidget {
  final int catID;
  final String categoryName, token, email, mobile, firstname, customerId;

  const ModelScreen({
    super.key,
    required this.catID,
    required this.categoryName,
    required this.token,
    required this.email,
    required this.mobile,
    required this.firstname,
    required this.customerId,
  });

  @override
  ModelScreenState createState() => ModelScreenState();
}

class ModelScreenState extends State<ModelScreen> {
  late Future<GetProductSearchModel> _futureData;
  bool isLoadingMore = false;
  int currentPage = 1;
  API api = API();
  GetProductSearchModel? category;

  @override
  void initState() {
    super.initState();
    _futureData = api.getProductCat(widget.catID, currentPage, widget.token);
    isLoadingMore = false;
  }

  void loadMore() {
    setState(() {
      isLoadingMore = true;
      currentPage++;
    });

    api.getProductCat(widget.catID, currentPage, widget.token).then((data) {
      setState(() {
        if (category != null && category!.data != null && data.data != null) {
          category!.data!.items!.addAll(data.data!.items!);
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
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height / 16),
        child: AppBar(
          backgroundColor: MyColorsSample.fontColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(50),
            ),
          ),
          title: Center(child: Text(widget.categoryName)),
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
      body: FutureBuilder<GetProductSearchModel>(
        future: _futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 45,
                  ),
                  GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    shrinkWrap: true,
                    childAspectRatio: 0.64,
                    physics: const NeverScrollableScrollPhysics(),
                    children: List.generate(
                      10,
                      (index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Column(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2.5,
                                height:
                                    MediaQuery.of(context).size.height / 3.7,
                                child: Card(
                                  elevation: 10,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  // child: Container(),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Container(
                                width: MediaQuery.of(context).size.width / 4,
                                height: 8.0,
                                color: Colors.grey[300],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasData) {
            category = snapshot.data;
            if (category!.data!.items!.isEmpty) {
              return Center(
                child: Column(children: [
                  Image.asset(
                    'assets/nodata.jpg',
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width - 1,
                  ),
                  Text(
                    'لا توجد منتجات في الوقت الحالي',
                    style: TextStyle(
                        color: Colors.deepPurple.withOpacity(0.7),
                        fontWeight: FontWeight.w700,
                        fontSize: 22),
                  )
                ]),
              );
            }
            return Column(
              children: [
                TypeAheadField<Items>(
                  textFieldConfiguration: TextFieldConfiguration(
                    autocorrect: false,
                    autofocus: false,
                    style: DefaultTextStyle.of(context).style.copyWith(
                        fontStyle: FontStyle.italic, color: Colors.black),
                    decoration: const InputDecoration(
                      labelText: 'Search for product',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
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
                            return Image.asset('assets/logo-raya.png',
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
                        childAspectRatio: 0.54,
                        physics: const NeverScrollableScrollPhysics(),
                        children: List.generate(
                          category!.data!.items!.length,
                          (index) {
                            final t = category!.data!.items![index];
                            return CardScreenModel(
                              name: t.name!,
                              salePrice: t.price!,
                              image: t.images!.imageLink!,
                              price: t.price!,
                              regularPrice: t.price!,
                              id: t.id!,
                              token: widget.token,
                              isfavouriteApi: false,
                              stockStatus: 'new',
                              isBundle: true,
                              percentagePrice: 1,
                              fav: 'false',
                              sku: t.sku!,
                              email: widget.email,
                              firstname: widget.firstname,
                              mobile: widget.mobile,
                              customerId: widget.customerId,
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
            return Center(
              child: Image.asset(
                  'assets/error.png'
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
