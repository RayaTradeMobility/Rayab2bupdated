// ignore_for_file: use_build_context_synchronously, file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rayab2bupdated/Screens/ThanksScreen.dart';
import '../API/API.dart';
import '../Constants/Constants.dart';
import '../Models/GetAddressModel.dart';
import '../Models/OrderResponseModel.dart';

class PayScreen extends StatefulWidget {
  const PayScreen({
    super.key,
    required this.token,
    required this.email,
    required this.firstname,
    required this.lastname,
    required this.customerId,
    required this.totalPrice,
    required this.totalQty,
  });

  final String token, email, firstname, lastname, customerId, totalPrice;

  final int totalQty;

  @override
  PayScreenState createState() => PayScreenState();
}

class PayScreenState extends State<PayScreen> {
  late Future<GetAddressModel> _futureData;

  bool _isLoading = false;
  final int _fontColor = 0xFF4C53A5;
  final int _radioSelected = 1;
  int _radioSelected1 = 1;
  int? radioSelectedAddress;

  API api = API();
  final address = TextEditingController();
  GetAddressModel? getAddress;

  Future<void> _refreshData() async {
    setState(() {
      _futureData = api.getAddress(widget.token);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _futureData = api.getAddress(widget.token);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(_fontColor),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
        centerTitle: true,
        title: const Text(
          "الدفع",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
          child: RefreshIndicator(
        onRefresh: _refreshData,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: FutureBuilder<GetAddressModel>(
              future: _futureData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  getAddress = snapshot.data;
                  if (getAddress!.data!.isEmpty) {
                    return const Center(
                      child: Text('No data available.'),
                    );
                  }
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          ' اختر العنوان',
                          style: TextStyle(
                              color: Color(_fontColor),
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        const SizedBox(width: 5.0),
                        const Icon(Icons.info_rounded),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        child: Card(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          elevation: 10.0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height/4,
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: snapshot.data?.data!.length ?? 0,
                                      itemBuilder: (context, index) {
                                        var item = snapshot.data?.data![index];
                                        return ListTile(
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(item!.street!),
                                              InkWell(
                                                  onTap: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return GetAddressAlert(
                                                            token: widget.token,
                                                            address: snapshot
                                                                .data!
                                                                .data![index]
                                                                .address!,
                                                            street: snapshot
                                                                .data!
                                                                .data![index]
                                                                .street!,
                                                            building: snapshot
                                                                .data!
                                                                .data![index]
                                                                .buildingNumber!,
                                                          );
                                                        });
                                                  },
                                                  child: const Icon(
                                                      Icons.info_rounded)),
                                            ],
                                          ),
                                          leading: Radio<int>(
                                            value: item.id!,
                                            groupValue: radioSelectedAddress,
                                            activeColor: Colors.blue,
                                            onChanged: (int? value) {
                                              setState(() {
                                                radioSelectedAddress = value;
                                              });
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialogPage(
                                                      token: widget.token,
                                                      email: widget.email,
                                                      firstname: widget.firstname,
                                                      lastname: widget.lastname,
                                                      customerId: widget.customerId,
                                                      totalPrice: widget.totalPrice,
                                                      totalQty: widget.totalQty,
                                                    );
                                                  });
                                            },
                                            child: const Row(
                                              children: [
                                                Icon(Icons.add),
                                                Text("اضافه عنوان جديد"),
                                              ],
                                            ))
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              _futureData =
                                                  api.getAddress(widget.token);
                                              _refreshData();
                                            },
                                            child: const Row(
                                              children: [
                                                Icon(
                                                  Icons.refresh,
                                                  color: Colors.blue,
                                                ),
                                                // Text("اضافه عنوان جديد"),
                                              ],
                                            ))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                      color: Colors.black,
                      thickness: 0.5,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'اختر طريقة شحن',
                          style: TextStyle(
                              color: Color(_fontColor),
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        const SizedBox(width: 5.0),
                        const Icon(Icons.local_shipping),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        elevation: 10.0,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ListTile(
                                title: const Text("الشحن اليوم التالي"),
                                leading: Radio(
                                  value: 1,
                                  groupValue: _radioSelected,
                                  activeColor: Colors.blue,
                                  onChanged: (value) {
                                    setState(() {
                                      _radioSelected1 = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                      color: Colors.black,
                      thickness: 0.5,
                    ),
                    paymentRadio(),
                    const Divider(
                      color: Colors.black,
                      thickness: 0.5,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("المنتجات : ${widget.totalQty} "),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  const Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('مصاريف الشحن'),
                                      Text(" 0 جنيه مصري ")
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
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('اجمالي الطلب'),
                                      Text(
                                        "  ${widget.totalPrice} جنيه مصري ",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 40.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )),
                  ],
                );
              }),
        ),
      )),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            api.checkNetwork();
            if (radioSelectedAddress == null) {
              Fluttertoast.showToast(
                  msg: "Please select Address",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
            {
              setState(() {
                _isLoading = true;
              });
              OrderResponseModel res = await api.createOrder(
                  widget.token, radioSelectedAddress!, _radioSelected1);
              if (res.success == true) {
                setState(() {
                  _isLoading = false;
                });
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return ThanksScreen(
                    token: widget.token,
                    email: widget.email,
                    firstname: widget.firstname,
                    lastname: widget.lastname,
                    customerId: widget.customerId,
                    orderId: res.data!.id!.toString(),
                    totalPrice: widget.totalPrice,
                  );
                }));
              } else {
                setState(() {
                  _isLoading = false;
                });
                Fluttertoast.showToast(
                    msg: res.message!,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
            }

            _isLoading
                ? const CircularProgressIndicator()
                : const Icon(Icons.payment);
          },
          label: const Text('اكمال الاوردر'),
          backgroundColor: Color(_fontColor)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget paymentRadio() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'اختر طريقة دفع',
              style: TextStyle(
                  color: Color(_fontColor),
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            const SizedBox(width: 5.0),
            const Icon(CupertinoIcons.money_dollar),
          ],
        ),
        Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              elevation: 10.0,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    ListTile(
                      title: const Text("الدفع عند الاستلام"),
                      leading: Radio(
                        value: 1,
                        groupValue: _radioSelected1,
                        activeColor: Colors.blue,
                        onChanged: (value) {
                          setState(() {
                            _radioSelected1 = value!;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text(" Visa"),
                      leading: Radio(
                        value: 2,
                        groupValue: _radioSelected1,
                        activeColor: Colors.blue,
                        onChanged: (value) {
                          setState(() {
                            _radioSelected1 = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ],
    );
  }
}

class AlertDialogPage extends StatefulWidget {
  final String token, email, firstname, lastname, customerId, totalPrice;

  final int totalQty;

  const AlertDialogPage({
    Key? key,
    required this.token,
    required this.email,
    required this.firstname,
    required this.lastname,
    required this.customerId,
    required this.totalPrice,
    required this.totalQty,
  }) : super(key: key);

  @override
  AlertDialogPageState createState() => AlertDialogPageState();
}

class AlertDialogPageState extends State<AlertDialogPage> {
  TextEditingController addressController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController buildingController = TextEditingController();
  API api = API();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(child: Text('العنوان')),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: addressController,
              decoration: InputDecoration(
                hintText: 'العنوان',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: streetController,
              decoration: InputDecoration(
                hintText: 'الشارع',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: buildingController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'رقم العماره',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColorsSample.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onPressed: () {
                if (addressController.text.isEmpty ||
                    streetController.text.isEmpty ||
                    buildingController.text.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('خطأ'),
                        content: const Text('يرجى ملء جميع البيانات'),
                        actions: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor:
                                  MyColorsSample.primary.withOpacity(0.8),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Center(child: Text('حسنًا')),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  api.createAddress(
                      widget.token,
                      addressController.text,
                      streetController.text,
                      int.parse(buildingController.text));

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                        return PayScreen(
                          token: widget.token,
                          email: widget.email,
                          firstname: widget.firstname,
                          lastname: widget.lastname,
                          customerId: widget.customerId,
                          totalPrice: widget.totalPrice,
                          totalQty: widget.totalQty,
                        );
                      }));                }
              },
              child: const Text('طلب'),
            ),
          ],
        ),
      ),
    );
  }
}

class GetAddressAlert extends StatefulWidget {
  const GetAddressAlert({
    Key? key,
    required this.token,
    required this.address,
    required this.street,
    required this.building,
  }) : super(key: key);
  final String token, address, street, building;

  @override
  GetAddressAlertState createState() => GetAddressAlertState();
}

class GetAddressAlertState extends State<GetAddressAlert> {
  API api = API();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(child: Text('التفاصيل')),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text("العنوان: ${widget.address}"),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text("الشارع: ${widget.street}"),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text("رقم العماره: ${widget.building}"),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
