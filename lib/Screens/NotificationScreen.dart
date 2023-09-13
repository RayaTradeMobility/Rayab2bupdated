// ignore_for_file: file_names

import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/material.dart';
import 'package:rayab2bupdated/Models/NotificationModel.dart';

import '../API/API.dart';
import '../Constants/Constants.dart';

class NotificationScreen extends StatefulWidget {
  final String token, customerId;

  const NotificationScreen(
      {Key? key, required this.token, required this.customerId})
      : super(key: key);

  @override
  NotificationScreenState createState() => NotificationScreenState();
}

class NotificationScreenState extends State<NotificationScreen> {
  late Future<NotificationModel> _futureData;
  API api = API();

  String logo = 'assets/notificationimg.png';

  @override
  void initState() {
    super.initState();
    _futureData = api.getNotification(widget.token);
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
          centerTitle: true,
          title: Center(
              child: const Text(
            "الاشعارات",
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
      body: Column(
        children: [
          FutureBuilder<NotificationModel>(
            future: _futureData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final notification = snapshot.data;
                return Expanded(
                    child: ListView.separated(
                  itemCount: notification!.data!.items!.length,
                  itemBuilder: (context, index) {
                    final order = notification.data!.items![index];
                    return ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(width: 16.0),
                          // Adjust the spacing between the image and text
                          Expanded(
                            child: Text(
                              '${order.message!}',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(logo),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      height: 14,
                      thickness: 3,
                    );
                  },
                ));
              } else if (snapshot.hasError) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        ' يوجد خطا في البانات',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        ' يرجى الانتظار',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 20),
                      CircularProgressIndicator(),
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class CustomerCard extends StatefulWidget {
  final String notificationMessage;
  final String createdAt;
  final String token, customerId;

  const CustomerCard({
    Key? key,
    required this.token,
    required this.notificationMessage,
    required this.createdAt,
    required this.customerId,
  }) : super(key: key);

  @override
  CustomerCardState createState() => CustomerCardState();
}

class CustomerCardState extends State<CustomerCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: (){
      //   if (kDebugMode) {
      //     print(widget.token);
      //   }
      //
      //   Navigator.push(context,
      //       MaterialPageRoute(builder: (context) {
      //         return OrderDetailsScreen(token: widget.token, customerId: widget.customerId, orderId: 0);
      //       }));
      // },
      child: Card(
          elevation: 12,
          color: MyColorsSample.fontColor.withOpacity(0.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(height: 5),
                          // Text(
                          //   "Order ID: ${widget.notificationId}",
                          //   style: MyTextSample.button(context)!
                          //       .copyWith(color: Colors.white, fontSize: 12),
                          // ),
                          // Container(height: 10),
                          Text(
                            " ${widget.notificationMessage.toLowerCase()}",
                            style: MyTextSample.display1(context)!.copyWith(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 11),
                          ),
                          Container(height: 10),
                          Text(
                            "Time: ${widget.createdAt}",
                            maxLines: 2,
                            style: MyTextSample.subhead(context)!
                                .copyWith(color: Colors.white, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
