// ignore_for_file: file_names

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

class HomeScreen extends StatefulWidget {
  const HomeScreen(
      {Key? key,
      required this.token,
      required this.email,
      required this.mobile,
      required this.firstname,
      required this.lastname,
      required this.customerId})
      : super(key: key);
  final String token, email, mobile, firstname, lastname, customerId;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget customSearchBar = const Text("ابحث عن شئ");
  final int _fontcolor = 0xFF4C53A5;
  Icon customIcon = const Icon(Icons.search);
  TextEditingController searchController = TextEditingController();

  API api = API();
  late Future<HomeResponseModel> _home;

  @override
  void initState() {
    // TODO: implement initState
    _home = api.getHome();

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
                                        const AssetImage("assets/no-img.jpg"),
                                    imageErrorBuilder:
                                        (context, error, stackTrace) {
                                      return Image.asset('assets/no-img.jpg',
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
                                    lastname: widget.lastname,
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
                )
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
                          Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image.asset(
                                "assets/About_Img.jpeg",
                                width: 500,
                                height: 200,
                              )),
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
                                      lastname: widget.lastname,
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
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    for (var i
                                        in snapshot.data!.data![0].categories!)
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
                                                                  "assets/no-img.jpg"),
                                                          imageErrorBuilder:
                                                              (context, error,
                                                                  stackTrace) {
                                                            return Image.asset(
                                                                'assets/no-img.jpg',
                                                                width: MediaQuery.of(context).size.width/7,
                                                                height: MediaQuery.of(context).size.width/12,
                                                                fit: BoxFit
                                                                    .fitWidth);
                                                          },
                                                          fit: BoxFit.fitWidth,
                                                          height: 50.0,
                                                          width: 130.0,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (context) {
                                                      return ModelScreen(
                                                        token: widget.token,
                                                        categoryName: i.name!,
                                                        catID: i.id!,
                                                        mobile: widget.mobile,
                                                        lastname:
                                                            widget.lastname,
                                                        firstname:
                                                            widget.firstname,
                                                        email: widget.email,
                                                        customerId:
                                                            widget.customerId,
                                                      );
                                                    }));
                                                  })),
                                          Center(
                                              child: Text(
                                            i.name!,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ))
                                        ],
                                      ),
                                    const SizedBox(
                                      width: 30.0,
                                    ),
                                  ],
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
                            child: Row( 
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                for (var t in snapshot.data!.data![0].products!)
                                  CardScreenModel(
                                    name: t.name!,
                                    salePrice: t.price!,
                                    image: t.images!.imageLink!,
                                    price: t.price!,
                                    regularPrice: t.price!,
                                    id: t.id!,
                                    token: widget.token,
                                    isfavouriteApi: false,
                                    stockStatus: 'new',
                                    isBundle: false,
                                    percentagePrice: 0,
                                    fav: 'false',
                                    sku: t.sku!,
                                    email: widget.email,
                                    mobile: widget.mobile,
                                    lastname: widget.lastname,
                                    firstname: widget.firstname,
                                    customerId: widget.customerId,
                                  ),
                              ],
                            ),
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
