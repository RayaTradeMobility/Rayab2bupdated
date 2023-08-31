// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:rayab2bupdated/Models/AddtoCartResponseModel.dart';
import 'package:rayab2bupdated/Models/BrandModel.dart';
import 'package:rayab2bupdated/Models/CustomerModel.dart';
import 'package:rayab2bupdated/Models/GetAddressModel.dart';
import 'package:rayab2bupdated/Models/GetCartResponseModel.dart';
import 'package:rayab2bupdated/Models/GetCategoriesResponseModel.dart';
import 'package:rayab2bupdated/Models/GetOrdersResponseModel.dart';
import 'package:rayab2bupdated/Models/GetProductsResponseModel.dart';
import 'package:rayab2bupdated/Models/HomeResponseModel.dart';
import 'package:rayab2bupdated/Models/LoginResponseModel.dart';
import 'package:rayab2bupdated/Models/LogoutModel.dart';
import 'package:rayab2bupdated/Models/NotificationModel.dart';
import 'package:rayab2bupdated/Models/OpenCartResponseModel.dart';
import 'package:rayab2bupdated/Models/OrderDetailsResponseModel.dart';
import 'package:rayab2bupdated/Models/OrderResponseModel.dart';
import 'package:rayab2bupdated/Models/ProductbySkuResponseModel.dart';
import 'package:rayab2bupdated/Models/RegisterResponseModel.dart';
import 'package:rayab2bupdated/Models/ShippingInformationResponseModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/CheckOTPModel.dart';
import '../Models/CreateAddressModel.dart';
import '../Models/EstimateShippingMethodResponse.dart';
import '../Models/FavouriteModel.dart';
import '../Models/GetCategoriesNewResponseModel.dart';
import '../Models/GetProductSearchModel.dart' as getpro;
import 'package:firebase_messaging/firebase_messaging.dart';

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
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(
          msg: "No Internet",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future<RegisterResponseModel> register(
      String name,
      String mobile,
      String companyName,
      String email,
      String password,
      String oracleNumber) async {
    var headers = {'Accept': 'application/json'};
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://41.78.23.95:8021/dist/api/v2/register'));
    request.fields.addAll({
      'name': name,
      'mobile': mobile,
      'company_name': companyName,
      'email': email,
      'password': password,
      'oracle_number': oracleNumber,
    });

    request.headers.addAll(headers);
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    RegisterResponseModel res = RegisterResponseModel();
    if (response.statusCode == 200) {
      res = RegisterResponseModel.fromJson(jsonDecode(response.body));
      if (kDebugMode) {
        print(response.body);
      }
    } else {
      if (kDebugMode) {
        print(response.body);
      }
    }
    return res;
  }

  addToFavourite(String token, String productId, String productSKU) async {
    var headers = {
      'lang': 'ar',
      'branchid': '2',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest('POST',
        Uri.parse('http://41.78.23.95:8021/dist/api/v2/favorites/add-to-fav'));
    request.fields.addAll({'product_id': productId, 'product_sku': productSKU});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print(response.stream);
        print(await response.stream.bytesToString());
      }
    } else {
      if (kDebugMode) {
        print(response.stream);

        print(response.reasonPhrase);
      }
    }
  }

  removeFromFavourite(String token, String productId, String productSKU) async {
    var headers = {
      'lang': 'ar',
      'branchid': '2',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'http://41.78.23.95:8021/dist/api/v2/favorites/deleted-to-fav'));
    request.fields.addAll({'product_id': productId, 'product_sku': productSKU});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print(response.stream);
        print(await response.stream.bytesToString());
      }
    } else {
      if (kDebugMode) {
        print(response.stream);

        print(response.reasonPhrase);
      }
    }
  }

  Future<FavouriteModel> getFavourite(String token, int? page) async {
    var headers = {
      'lang': 'ar',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest('GET',
        Uri.parse('http://41.78.23.95:8021/dist/api/v2/favorites?page=$page'));

    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      return FavouriteModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Error");
    }
  }

  Future<LoginResponseModel?> login(String mobile, String password,
      String deviceToken, String businessUnitID) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('$url/v2/login'));
    request.body = json.encode({
      'mobile': mobile,
      'password': password,
      'device_token': deviceToken,
      'business_unit_id': businessUnitID
    });
    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      LoginResponseModel? user =
          LoginResponseModel.fromJson(jsonDecode(response.body));
      if (kDebugMode) {
        print(user.data!.token);
      }
      sharedPreferences.setString('mobile', mobile);
      sharedPreferences.setString('password', password);
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

  mobileOTP(String mobile) async {
    var headers = {'Accept': 'application/json'};
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://41.78.23.95:8021/dist/api/v2/SendOTPSMS'));
    request.fields.addAll({'mobile': mobile});

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

  Future<OtpCheckModel?> resetPassword(
      String mobile, String otp, String password) async {
    var headers = {'lang': 'en', 'Accept': 'application/json'};
    var request = http.MultipartRequest('POST',
        Uri.parse('http://41.78.23.95:8021/dist/api/v2/reset-password'));
    request.fields.addAll({'otp': otp, 'mobile': mobile, 'password': password});

    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      return OtpCheckModel.fromJson(jsonDecode(response.body));
    } else {
      return OtpCheckModel.fromJson(jsonDecode(response.body));
    }
  }

  Future<OtpCheckModel?> checkOTP(String mobile, String otpPin) async {
    var headers = {'Accept': 'application/json'};
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://41.78.23.95:8021/dist/api/v2/checkOtp'));
    request.fields.addAll({'mobile': mobile, 'otp': otpPin});

    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      return OtpCheckModel.fromJson(jsonDecode(response.body));
    } else {
      return OtpCheckModel.fromJson(jsonDecode(response.body));
    }
  }

  logOut(String token) async {
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://41.78.23.95:8021/dist/api/v2/logout'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print(response.stream);
        print(await response.stream.bytesToString());
      }
    } else {
      if (kDebugMode) {
        print(response.stream);

        print(response.reasonPhrase);
      }
    }
  }

  Future<LogoutModel?> logOutCustomer(String token) async {
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://41.78.23.95:8021/dist/api/v2/logout'));

    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      LogoutModel? user = LogoutModel.fromJson(jsonDecode(response.body));

      return user;
    }
    return null;
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
      String token, int productId, String sku, int qty) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse('$url/v2/cart/add-to-cart'));
    request.fields.addAll({
      'product_id': productId.toString(),
      'sku': sku,
      'qty': qty.toString()
    });

    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    AddtoCartResponseModel mod = AddtoCartResponseModel();
    if (kDebugMode) {
      print(response.body);
    }
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
    var headers = {
      'Authorization': 'Bearer $token',
      'Connection': 'keep-alive',
    };
    var request = http.Request('GET', Uri.parse('$url/v2/cart/getCart'));
    request.body = '''''';
    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    GetCartResponseModel res = GetCartResponseModel();
    if (response.statusCode == 200) {
      res = GetCartResponseModel.fromJson(jsonDecode(response.body));

      return res;
    } else if (response.statusCode == 404) {
      res = GetCartResponseModel.fromJson(jsonDecode(response.body));

      return res;
    } else {
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
    var request = http.Request('GET', Uri.parse('$url/getProductsNew?sku=$sku'));

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
      request =
          http.Request('GET', Uri.parse('$url/getCategoriesNew?page=$page'));
    } else {
      request = http.Request('GET', Uri.parse('$url/getCategoriesNew'));
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

  Future<BrandsModel> getBrands( String token) async {
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request('GET', Uri.parse('http://41.78.23.95:8021/dist/api/v2/getBrands'));
    request.body = '''''';
    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      return BrandsModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Error");
    }
  }

  Future<getpro.GetProductSearchModel> getProductsNew(String sku, String name,
      String categoryId, int page, String token) async {
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
        'GET',
        Uri.parse(
            '$url/getProductsNew?sku=$sku&name=$name&category_id=$categoryId&page=$page'));

    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      return getpro.GetProductSearchModel.fromJson(jsonDecode(response.body));
    } else {
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
        'POST', Uri.parse('$url/customer/estimate-shipping-methods'));
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

  Future<getpro.GetProductSearchModel> getProductCat(
      int categoryID, int pageNumber, String token) async {
    var headers = {'Authorization': 'Bearer $token'};
    http.Request request;
    if (categoryID != 0) {
      request = http.Request(
          'GET',
          Uri.parse(
              '$url/getProductsNew?category_id=$categoryID&page=$pageNumber'));
    } else {
      request = http.Request(
          'GET', Uri.parse('$url/getProductsNew?page=$pageNumber'));
    }
    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      return getpro.GetProductSearchModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Error");
    }
  }

  static Future<List<getpro.Items>> searchProducts(
      String name, String token) async {
    var headers = {
      'Authorization': 'Bearer $token',
    };

    var request = http.Request(
        'GET',
        Uri.parse(
            'http://41.78.23.95:8021/dist/api/getProductsNew?name=$name'));
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
      String token, int addressId, int paymentMethod) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse('$url/v2/orders/create'));
    request.fields.addAll({
      'addresse_id': addressId.toString(),
      'payment_method_id': paymentMethod.toString()
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
    return res;
  }

  Future<ShippingInformationResponseModel> getShippingInformation(
      String token, String firsName, String lastName, String email) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request =
        http.Request('POST', Uri.parse('$url/customer/shipping-information'));
    request.body = json.encode({
      "addressInformation": {
        "shipping_address": {
          "region": "Egypt",
          "region_id": 1122,
          "region_code": "EG",
          "country_id": "EG",
          "street": '[street]',
          "postcode": "12345",
          "city": 'city',
          "firstname": 'abc',
          "lastname": 'cde',
          "email": "@emd",
          "telephone": "01129"
        },
        "billing_address": {
          "region": "Egypt",
          "region_id": 1122,
          "region_code": "EG",
          "country_id": "EG",
          "street": 's',
          "postcode": "12345",
          "city": "city",
          "firstname": firsName,
          "lastname": lastName,
          "email": email,
          "telephone": "011"
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

  deleteProducts(String token, int productId, String sku) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse('$url/v2/cart/delete-to-cart'));
    request.fields.addAll({'product_id': productId.toString(), 'sku': sku});
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

  Future<NotificationModel> getNotification(String token) async {
    var headers = {'Authorization': 'Bearer $token'};

    var request = http.Request('GET',
        Uri.parse('http://41.78.23.95:8021/dist/api/v2/getNotifications'));
    request.body = '''''';
    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print(response.body);
      }
      return NotificationModel.fromJson(jsonDecode(response.body));
    } else {
      if (kDebugMode) {
        print(response.body);
      }

      throw Exception("Error");
    }
  }

  Future<CreateAddressModel> createAddress(
      String token, String address, String street, int buildingNumber) async {
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.MultipartRequest('POST',
        Uri.parse('http://41.78.23.95:8021/dist/api/v2/addresses/create'));
    request.fields.addAll({
      'region_id': '1122',
      'address': address,
      'street': street,
      'building_number': buildingNumber.toString()
    });
    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    var res = CreateAddressModel();
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print(response.body);
      }
      res = CreateAddressModel.fromJson(jsonDecode(response.body));
      return res;
    } else {
      if (kDebugMode) {
        print(response.body);
      }

      res.success = false;
      res.message = "Error";
      return res;
    }
  }

  Future<GetAddressModel> getAddress(String token) async {
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.MultipartRequest(
        'GET', Uri.parse('http://41.78.23.95:8021/dist/api/v2/addresses'));

    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    var res = GetAddressModel();
    if (response.statusCode == 200) {
      res = GetAddressModel.fromJson(jsonDecode(response.body));
      return res;
    } else {
      res.success = false;
      res.message = "Error";
      return res;
    }
  }

  Future<GetOrdersResponseModel> getOrders(String token) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            'http://41.78.23.95:8021/dist/api/v2/orders?order_id&status_id'));
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
      String token, int orderId) async {
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
        'GET',
        Uri.parse(
            'http://41.78.23.95:8021/dist/api/v2/orders/orderDetail?order_id=$orderId'));
    request.body = '''''';
    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    var res = OrderDetailsResponseModel();
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print(response.body);
      }
      res = OrderDetailsResponseModel.fromJson(jsonDecode(response.body));
      return res;
    } else {
      if (kDebugMode) {
        print(response.body);
      }

      res.success = false;
      res.message = "Error";
      return res;
    }
  }

  Future<void> handleBackgroundMessage(RemoteMessage message) async {
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

  late String fcmToken;

  Future<void> initNotification() async {
    await firebaseMessaging.requestPermission();
    fcmToken = (await firebaseMessaging.getToken())!;

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}
