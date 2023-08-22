// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:rayab2bupdated/Models/AddtoCartResponseModel.dart';
import 'package:rayab2bupdated/Models/CustomerModel.dart';
import 'package:rayab2bupdated/Models/GetCartResponseModel.dart';
import 'package:rayab2bupdated/Models/GetCategoriesResponseModel.dart';
import 'package:rayab2bupdated/Models/GetOrdersResponseModel.dart';
import 'package:rayab2bupdated/Models/GetProductsResponseModel.dart';
import 'package:rayab2bupdated/Models/HomeResponseModel.dart';
import 'package:rayab2bupdated/Models/LoginResponseModel.dart';
import 'package:rayab2bupdated/Models/OpenCartResponseModel.dart';
import 'package:rayab2bupdated/Models/OrderDetailsResponseModel.dart';
import 'package:rayab2bupdated/Models/OrderResponseModel.dart';
import 'package:rayab2bupdated/Models/ProductbySkuResponseModel.dart';
import 'package:rayab2bupdated/Models/RegisterResponseModel.dart';
import 'package:rayab2bupdated/Models/ShippingInformationResponseModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/EstimateShippingMethodResponse.dart';
import '../Models/GetCategoriesNewResponseModel.dart';
import '../Models/LoginModelRequest.dart';
import '../Models/RegisterRequestModel.dart';
import '../Models/GetProductSearchModel.dart' as getpro;
import'package:firebase_messaging/firebase_messaging.dart';
class API {
  String url = 'http://41.78.23.95:8021/dist/api';
  final firebaseMessaging = FirebaseMessaging.instance;

  checkNetwork() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Fluttertoast.showToast(
            msg: "Loading",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(
          msg: "No Internet",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future<RegisterResponseModel> register(
      RegisterRequestModel requestModel) async {
    var headers = {'Content-Type': 'application/json'};
    var request =
    http.Request('POST', Uri.parse('$url/customer/registerCustomer'));
    String body = json.encode({
      "customer": {
        "email": requestModel.customer!.email,
        "firstname": requestModel.customer!.firstname,
        "lastname": requestModel.customer!.lastname,
        "addresses": [
          {
            "defaultShipping":
            requestModel.customer!.addresses![0].defaultShipping,
            "defaultBilling":
            requestModel.customer!.addresses![0].defaultBilling,
            "firstname": requestModel.customer!.addresses![0].firstname,
            "lastname": requestModel.customer!.addresses![0].lastname,
            "region": {
              "regionCode":
              requestModel.customer!.addresses![0].region!.regionCode,
              "region": requestModel.customer!.addresses![0].region!.region,
              "regionId": requestModel.customer!.addresses![0].region!.regionId
            },
            "postcode": requestModel.customer!.addresses![0].postcode,
            "street": [requestModel.customer!.addresses![0].street![0]],
            "city": requestModel.customer!.addresses![0].city,
            "telephone": requestModel.customer!.addresses![0].telephone,
            "countryId": requestModel.customer!.addresses![0].countryId
          }
        ]
      },
      "password": requestModel.password
    });
    request.body = body;
    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    RegisterResponseModel res = RegisterResponseModel();
    if (response.statusCode == 200) {
      res = RegisterResponseModel.fromJson(jsonDecode(response.body));

      return res;
    } else if (response.statusCode == 401) {
      res = RegisterResponseModel.fromJson(jsonDecode(response.body));
      if (kDebugMode) {
        print(res);
      }
      return res;
    } else {
      return res;
    }
  }

  Future<LoginResponseModel?> login(LoginModelRequest loginModelRequest) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var headers = {'Content-Type': 'application/json'};
    var request =
    http.Request('POST', Uri.parse('$url/customer/loginCustomer'));
    request.body = json.encode({
      "username": loginModelRequest.username,
      "password": loginModelRequest.password
    });
    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      // if(kDebugMode)
      //   {
      //     print("response:${response.body}");
      //   }
      LoginResponseModel? user =
      LoginResponseModel.fromJson(jsonDecode(response.body));
      // if (kDebugMode) {
      //   print('User : $user');
      // }
      sharedPreferences.setString('username', loginModelRequest.username!);
      sharedPreferences.setString('password', loginModelRequest.password!);
      return user;
    } else {
      LoginResponseModel? user =
      LoginResponseModel.fromJson(jsonDecode(response.body));
      if (kDebugMode) {
        print('User : $user');
        return user;
      }
    }
    return null;
  }

  getDataCustomer(String token) async {
    var headers = {'Authorization': 'Bearer $token'};
    var request =
    http.Request('GET', Uri.parse('$url/customer/getDataCustomer'));
    request.body = '''''';
    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      return CustomerModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Error");
    }
  }

  Future<String> openCart(String token) async {
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request('POST', Uri.parse('$url/customer/quote'));

    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      return OpenCartResponseModel.fromJson(jsonDecode(response.body))
          .data!
          .quoteId!;
    } else {
      throw Exception("Error");
    }
  }

  Future<AddtoCartResponseModel> addToCart(
      String token, String sku, int qty) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request('POST', Uri.parse('$url/customer/add-to-cart'));
    request.body = json.encode({
      "cartItem": {"sku": sku, "qty": qty}
    });
    request.headers.addAll(headers);
    if (kDebugMode) {
      print(request.body);
    }
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    AddtoCartResponseModel mod = AddtoCartResponseModel();
    if (response.statusCode == 200) {
      mod = AddtoCartResponseModel.fromJson(jsonDecode(response.body));

      return mod;
    } else if (response.statusCode == 401) {
      mod = AddtoCartResponseModel.fromJson(jsonDecode(response.body));
      return mod;
    } else {
      mod.message = response.body;
      mod.success = false;
      return mod;
    }
  }

  Future<GetCartResponseModel> getCart(String token) async {
    // await openCart(token);
    var headers = {'Authorization': 'Bearer $token',
      'Connection': 'keep-alive',
    };
    var request = http.Request('GET',
        Uri.parse('$url/customer/getCartNew'));
    request.body = '''''';
    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    GetCartResponseModel res = GetCartResponseModel();
    if (response.statusCode == 200) {
      res = GetCartResponseModel.fromJson(jsonDecode(response.body));
      if (kDebugMode) {
        print("200:${response.body}");
      }
      return res;
    } else if (response.statusCode == 404) {
      res = GetCartResponseModel.fromJson(jsonDecode(response.body));
      if (kDebugMode) {
        print("404:${response.body}");
      }
      return res;
    } else {
      if (kDebugMode) {
        print(response.body);
      }
      return res;
    }
  }

  Future<GetCategoriesResponseModel> getCategories() async {
    var headers = {
      'Accept': 'application/json',
    };
    var request = http.Request('GET', Uri.parse('$url/getCategories'));

    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      GetCategoriesResponseModel res =
      GetCategoriesResponseModel.fromJson(jsonDecode(response.body));
      return res;
    } else {
      throw Exception("Error");
    }
  }

  getProducts(String token) async {
    var headers = {'Authorization': 'Bearer $token'};
    var request =
    http.Request('GET', Uri.parse('$url/getProducts?current_page='));

    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      return GetProductsResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Error");
    }
  }

  Future<HomeResponseModel> getHome() async {
    var headers = {'Accept': 'application/json'};
    var request = http.Request('GET', Uri.parse('$url/home'));

    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      return HomeResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Error");
    }
  }

  Future<ProductbySkuResponseModel> getProductBySku(String sku) async {
    var headers = {'Accept': 'application/json'};
    var request = http.Request('GET', Uri.parse('$url/getProduct?sku=$sku'));

    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      return ProductbySkuResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Error");
    }
  }

  Future<GetCategoriesNewResponseModel> getCategoriesNew(int? page) async {
    var headers = {'Accept': 'application/json'};
    http.Request request;
    if (page != null) {
      request = http.Request(
          'GET',
          Uri.parse(
              '$url/getCategoriesNew?page=$page'));
    } else {
      request = http.Request('GET',
          Uri.parse('$url/getCategoriesNew'));
    }
    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      return GetCategoriesNewResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Error");
    }
  }

  Future <getpro.GetProductSearchModel> getProductsNew(String sku,String name,String categoryId,int page,String token)async {
    var headers = {
      'Authorization': 'Bearer $token'
    };
    var request = http.Request('GET', Uri.parse(
        '$url/getProductsNew?sku=$sku&name=$name&category_id=$categoryId&page=$page'));

    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      return getpro.GetProductSearchModel.fromJson(jsonDecode(response.body));
    }
    else {
      throw Exception("Error");
    }
  }

  Future<EstimateShippingMethodResponse> estimateShippingMethods(
      String token,
      String street,
      String city,
      String firstName,
      String lastName,
      String email,
      String mobile) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            '$url/customer/estimate-shipping-methods'));
    request.body = json.encode({
      "address": {
        "region": "Egypt",
        "region_id": 1122,
        "region_code": "EG",
        "country_id": "EG",
        "street": [street],
        "postcode": "12345",
        "city": city,
        "firstname": firstName,
        "lastname": lastName,
        "customer_id": 4,
        "email": "jdoe@ex2ample.com",
        "telephone": mobile,
        "same_as_billing": 1
      }
    });
    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      return EstimateShippingMethodResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Error");
    }
  }

  Future <getpro.GetProductSearchModel> getProductCat(int categoryID,int pageNumber, String token ) async {
    var headers = {
      'Authorization': 'Bearer $token'
    };
    http.Request request;
    if(categoryID != 0)
    {
      request = http.Request('GET',
          Uri.parse('$url/getProductsNew?category_id=$categoryID&page=$pageNumber'));

    }

    else{
      request = http.Request('GET',
          Uri.parse('$url/getProductsNew?page=$pageNumber'));

    }
    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      return getpro.GetProductSearchModel.fromJson(jsonDecode(response.body));
    }
    else {
      throw Exception("Error");
    }
  }

  static Future<List<getpro.Items>> searchProducts(String name, String token) async {
    var headers = {
      'Authorization': 'Bearer $token',
    };

    var request = http.Request('GET',
        Uri.parse('http://41.78.23.95:8021/dist/api/getProductsNew?name=$name'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonString = await response.stream.bytesToString();
      var jsonResponse = json.decode(jsonString);

      List<getpro.Items> data = [];
      if (jsonResponse['data'] != null) {
        data = getpro.GetProductSearchModel.fromJson(jsonResponse).data!.items!;
      }

      return data;
    } else {
      throw Exception(
          'Failed to search products. Status code: ${response.statusCode}');
    }
  }

  Future<OrderResponseModel> createOrder(
      String token,
      String paymentMethod,
      String email,
      String street,
      String city,
      String mobile,
      String firstName,
      String lastName) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            '$url/customer/payment-information'));
    request.body = json.encode({
      "paymentMethod": {"method": paymentMethod},
      "billing_address": {
        "email": "jignesh.meetanshi@gmail.com",
        "region": "Egypt",
        "region_id": 1122,
        "region_code": "EG",
        "country_id": "EG",
        "street": [street],
        "postcode": "12345",
        "city": city,
        "telephone": mobile,
        "firstname": firstName,
        "lastname": lastName
      }
    });
    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    var res = OrderResponseModel();
    if (response.statusCode == 200) {
      res = OrderResponseModel.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 401) {
      res = OrderResponseModel.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 404) {
      res = OrderResponseModel.fromJson(jsonDecode(response.body));
    } else {
      res.success = false;
      res.message = "ConnectionError";
    }
    if (kDebugMode) {
      print(response.body);
    }
    return res;
  }

  Future<ShippingInformationResponseModel> getShippingInformation(
      String token,
      String street,
      String city,
      String firsName,
      String lastName,
      String mobile,
      String email) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            '$url/customer/shipping-information'));
    request.body = json.encode({
      "addressInformation": {
        "shipping_address": {
          "region": "Egypt",
          "region_id": 1122,
          "region_code": "EG",
          "country_id": "EG",
          "street": [street],
          "postcode": "12345",
          "city": city,
          "firstname": firsName,
          "lastname": lastName,
          "email": email,
          "telephone": mobile
        },
        "billing_address": {
          "region": "Egypt",
          "region_id": 1122,
          "region_code": "EG",
          "country_id": "EG",
          "street": [street],
          "postcode": "12345",
          "city": city,
          "firstname": firsName,
          "lastname": lastName,
          "email": email,
          "telephone": mobile
        },
        "shipping_carrier_code": "flatrate",
        "shipping_method_code": "flatrate"
      }
    });
    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    var res = ShippingInformationResponseModel();
    if (response.statusCode == 200) {
      res =
          ShippingInformationResponseModel.fromJson(jsonDecode(response.body));
      return res;
    } else {
      res.success = false;
      res.message = "Error";
      return res;
    }
  }

  deleteProducts(String token, int itemId) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request('DELETE',
        Uri.parse('$url/customer/delete-to-cart'));
    request.body = json.encode({"item_id": itemId});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print(await response.stream.bytesToString());
      }
    } else {
      if (kDebugMode) {
        print(response.reasonPhrase);
      }
    }
  }

  Future<GetOrdersResponseModel> getOrders(
      String token, String customerId, String orderId) async {
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
        'GET',
        Uri.parse(
            '$url/customer/getOrders?customer_id=$customerId&order_id=$orderId&status'));
    request.body = '''''';
    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    var res = GetOrdersResponseModel();
    if (response.statusCode == 200) {
      res = GetOrdersResponseModel.fromJson(jsonDecode(response.body));
      return res;
    } else {
      res.success = false;
      res.message = "Error";
      return res;
    }
  }

  Future<OrderDetailsResponseModel> getOrdersDetails(
      String token, String customerId, int orderId) async {
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
        'GET',
        Uri.parse(
            '$url/customer/getOrderDetails?customer_id=$customerId&order_id=$orderId'));
    request.body = '''''';
    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    var res = OrderDetailsResponseModel();
    if (response.statusCode == 200) {
      res = OrderDetailsResponseModel.fromJson(jsonDecode(response.body));
      return res;
    } else {
      res.success = false;
      res.message = "Error";
      return res;
    }
  }

  Future<void> handleBackgroundMessage(RemoteMessage message) async{
    if (kDebugMode) {
      print("title: ${message.notification?.title}");
    }
    if (kDebugMode) {
      print("body: ${message.notification?.body}");
    }
    if (kDebugMode) {
      print("Payload: ${message.data}");
    }

  }

  Future<void>initNotification ()async{

    await firebaseMessaging.requestPermission();
    final fcmToken= await firebaseMessaging.getToken();
    if (kDebugMode) {
      print("Token: $fcmToken" );
    }
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}
