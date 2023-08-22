// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'package:rayab2bupdated/Constants/Constants.dart';

class PriceOfferScreen extends StatefulWidget {
  const PriceOfferScreen({super.key, required this.token});

  final String token;

  @override
  PriceOfferScreenState createState() => PriceOfferScreenState();
}

class PriceOfferScreenState extends State<PriceOfferScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  MyColorsSample.fontColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
        centerTitle: true,
        title: const Text(
          "عرض السعر",
          textAlign: TextAlign.center,
          style: TextStyle(color:MyColorsSample.fontColor),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset('assets/img offer.png'),
                    const Text(
                        'اهلا بك لقد حصلت علي خصم خاص بك من شركه رايه 10% من اجمالي الاوردر'),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.lightBlue[100],
                            border: Border.all(
                                color: Colors.black, style: BorderStyle.none),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                 const Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text("المنتجات 1"),
                                    Text(" 0 جنيه مصري")
                                  ],
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                const Divider(
                                  color: Colors.black,
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                 const Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text("الاجمالي (0)"),
                                    Text(
                                      "0 جنيه مصري",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                TextButton(
                                  child: const Text("لا اريد هذا العرض"),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]))),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text('متابعه'),
        backgroundColor: MyColorsSample.fontColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
