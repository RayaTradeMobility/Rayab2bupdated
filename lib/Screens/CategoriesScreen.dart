// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:rayab2bupdated/API/API.dart';
import 'package:rayab2bupdated/Constants/Constants.dart';
import 'package:rayab2bupdated/Models/GetCategoriesNewResponseModel.dart';
import 'package:rayab2bupdated/Screens/BottomNavMenu.dart';
import 'package:rayab2bupdated/Screens/ModelScreen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen(
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
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  late Future<GetCategoriesNewResponseModel> cat;
  API api = API();

  @override
  void initState() {
    // TODO: implement initState
    cat = api.getCategoriesNew(null);
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
            lastname: widget.lastname,
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
                  builder: (context,snapshot){
                    if(snapshot.hasData){
                      return GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          mainAxisSpacing: 0.0,
                          crossAxisSpacing: 0.0,
                          childAspectRatio: 1/1,
                          crossAxisCount: 3,
                          children:List.generate(snapshot.data!.data!.items!.length, (index) =>
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width:110.0,
                                    height: 100.0,
                                    child: Card(
                                      elevation: 10,

                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),

                                      ),
                                      child: TextButton(
                                        onPressed:(){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                                            return ModelScreen(token: widget.token,catID: snapshot.data!.data!.items![index].id!, categoryName: snapshot.data!.data!.items![index].name!, email: widget.email,mobile: widget.mobile,lastname: widget.lastname,firstname: widget.firstname,customerId: widget.customerId,);
                                          }));
                                        },
                                        child: Center(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              FadeInImage(
                                                image: NetworkImage(
                                                    snapshot.data!.data!.items![index].imageLink!),
                                                placeholder:
                                                const AssetImage(
                                                    "assets/no-img.jpg"),
                                                imageErrorBuilder:
                                                    (context, error,
                                                    stackTrace) {
                                                  return Image.asset(
                                                      'assets/no-img.jpg',
                                                      height: 50.0,
                                                      width: 120.0,
                                                      fit: BoxFit
                                                          .fitWidth);
                                                },
                                                fit: BoxFit.fitWidth,
                                                height: 50.0,
                                                width: 130.0,
                                              ),
                                              const SizedBox(height: 5.0),
                                              Text(snapshot.data!.data!.items![index].name!,style: const TextStyle(color: Colors.black),),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                          )
                      );
                    }
                    else if(snapshot.hasError){
                      return Text('${snapshot.error}' "You don't have data in this time");
                    }
                    else{
                      return const Center(child: CircularProgressIndicator());
                    }
                  },

                ),
                const SizedBox(height: 10.0,),
                const SizedBox(height: 20.0,),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('جميع الماركات',style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),),
                  ],
                ),
                // FutureBuilder<BrandsModel>(
                //   future: Brand,
                //   builder: (context,snapshot){
                //     if (snapshot.hasData){
                //       return GridView.count(
                //           shrinkWrap: true,
                //           physics: NeverScrollableScrollPhysics(),
                //           mainAxisSpacing: 0.0,
                //           crossAxisSpacing: 0.0,
                //           childAspectRatio: 1/1,
                //           crossAxisCount: 3,
                //           children: List.generate(snapshot.data.data.brands.length, (index) => Row(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: [
                //               Container(
                //                 height:60,
                //                 width: 80,
                //                 child: Card(
                //                   elevation: 10,
                //                   shape: RoundedRectangleBorder(
                //                     borderRadius: BorderRadius.all(Radius.circular(10)),
                //
                //                   ),
                //                   child: TextButton(
                //                     onPressed:(){
                //                       Navigator.push(context, MaterialPageRoute(builder: (context) {
                //                         return ModelScreen(token: widget.token,brandId: snapshot.data.data.brands[index].iD,page: 1,appbarText: snapshot.data.data.brands[index].postTitle,);
                //                       }));
                //                     },
                //                     child: Center(
                //                       child: Image.network(snapshot.data.data.brands[index].guid,    errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
                //                         return Text('No Image');
                //                       },),
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //
                //             ],
                //           ),)
                //       );
                //     }
                //     else if(snapshot.hasError){
                //       return Text('${snapshot.error}' +
                //           "You don't have data in this time");
                //     }
                //     else{
                //       return Center(child: const CircularProgressIndicator());
                //
                //     }
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
