// ignore_for_file: file_names

class GetOrdersResponseModel {
  bool? success;
  String? message;
  Data? data;

  GetOrdersResponseModel({this.success, this.message, this.data});

  GetOrdersResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? currentPage;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? nextPageUrl;
  String? path;
  int? perPage;

  // ignore: prefer_void_to_null
  Null prevPageUrl;
  int? to;
  int? total;
  List<Items>? items;

  Data(
      {this.currentPage,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total,
      this.items});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  int? orderId;
  String? status;
  String? baseSubtotal;
  String? shippingAmount;
  String? grandTotal;
  String? createdAt;

  Items(
      {this.orderId,
      this.status,
      this.baseSubtotal,
      this.shippingAmount,
      this.grandTotal ,
      this.createdAt});

  Items.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    status = json['status'];
    baseSubtotal = json['base_subtotal'];
    shippingAmount = json['shipping_amount'];
    grandTotal = json['grand_total'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['status'] = status;
    data['base_subtotal'] = baseSubtotal;
    data['shipping_amount'] = shippingAmount;
    data['grand_total'] = grandTotal;
    data['created_at'] = createdAt;
    return data;
  }
}
