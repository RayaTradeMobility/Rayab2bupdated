// ignore_for_file: use_build_context_synchronously, file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rayab2bupdated/Screens/ThanksScreen.dart';
import '../API/API.dart';
import '../Models/OrderResponseModel.dart';
import '../Models/ShippingInformationResponseModel.dart';


class PayScreen extends StatefulWidget {
  const PayScreen({super.key, required this.token, required this.email, required this.mobile, required this.firstname, required this.lastname, required this.street, required this.city, required this.customerId});
  final String token, email, mobile, firstname, lastname , street , city,customerId;
  @override
  PayScreenState createState() => PayScreenState();
}


class PayScreenState extends State<PayScreen> {
  late Future<ShippingInformationResponseModel> _shipping;
  bool _isLoading=false;
  final int _fontColor = 0xFF4C53A5;
  final int _radioSelected = 1;
  int _radioSelected1 = 1;
  API api = API();
  final address = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _shipping = api.getShippingInformation(widget.token, widget.street, widget.city, widget.firstname, widget.lastname, widget.mobile, widget.email);
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
        title: const Text("الدفع",textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: FutureBuilder<ShippingInformationResponseModel>(
            future: _shipping,
            builder: (context,snapshot){
              if(snapshot.hasData){
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('بيانات العميل' , style: TextStyle(color: Color(_fontColor),fontWeight: FontWeight.bold,fontSize: 16),),
                        const SizedBox(width:5.0),
                        const Icon(Icons.info_rounded),

                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Card(

                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                          elevation: 10.0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('الموبايل: ${widget.mobile }  ' ,style: const TextStyle(fontWeight: FontWeight.bold),) ,
                                Text('المدينه: ${widget.city }  ' ,style: const TextStyle(fontWeight: FontWeight.bold),),
                                Text('الشارع: ${widget.street }  ',style: const TextStyle(fontWeight: FontWeight.bold), ),


                              ],
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
                        Text('اختر طريقة شحن' , style: TextStyle(color: Color(_fontColor),fontWeight: FontWeight.bold,fontSize: 16),),
                        const SizedBox(width:5.0),
                        const Icon(Icons.local_shipping),

                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
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
                        child:
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.lightBlue[100],
                              border: Border.all(
                                  color: Colors.black, style: BorderStyle.none),
                              borderRadius: const BorderRadius.all(Radius.circular(15))),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("المنتجات : ${snapshot.data!.data!.totals!.itemsQty!} "),
                                      Text("${snapshot.data!.data!.totals!.subtotal!} جنيه مصري  ")
                                    ],
                                  ),
                                  const SizedBox(height: 10.0,),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('مصاريف الشحن'),

                                      Text("${snapshot.data!.data!.totals!.shippingAmount!} جنيه مصري ")
                                    ],
                                  ),
                                  const SizedBox(height: 10.0,),

                                  const SizedBox(height: 10.0,),
                                  const Divider(
                                    color: Colors.black,
                                  ),
                                  const SizedBox(height: 10.0,),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('اجمالي الطلب'),

                                      Text(
                                        "${snapshot.data!.data!.totals!.grandTotal!} جنيه مصري ",
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )


                    ),
                  ],
                );
              }
              else if(snapshot.hasError){
                return Text("${snapshot.error}");
              }
              else{
                return const Center( child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          api.checkNetwork();
          setState(() {
            _isLoading = true;
          });
          OrderResponseModel res = await api.createOrder(widget.token, "checkmo", widget.email, widget.street, widget.city, widget.mobile, widget.firstname, widget.lastname);
          if(res.success==true){
            setState(() {
              _isLoading=false;
            });
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ThanksScreen(
                  token: widget.token,
                  email: widget.email,
                  firstname: widget.firstname,
                  lastname: widget.lastname,
                  mobile: widget.mobile,
                  customerId: widget.customerId,
                  orderId: res.data!.orderId!.toString());
            }));
          }
          else{
            setState(() {
              _isLoading=false;
            });
            Fluttertoast.showToast(
                msg: res.message!,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
        },
        icon: _isLoading ? const CircularProgressIndicator() : const Icon(Icons.payment),
        label: const Text('اكمال الاوردر'),backgroundColor: Color(_fontColor),),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
  Widget paymentRadio(){
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('اختر طريقة دفع' , style: TextStyle(color: Color(_fontColor),fontWeight: FontWeight.bold,fontSize: 16),),
            const SizedBox(width:5.0),
            const Icon(CupertinoIcons.money_dollar),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child:
                   Card(
                     shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
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
                         ],
                       ),
                     ),
                   )
        ),
      ],
    );
  }

}





