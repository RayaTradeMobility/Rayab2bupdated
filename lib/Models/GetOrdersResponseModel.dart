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
  String? prevPageUrl;
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
  int? statusId;
  int? shippingAmount;
  var grandTotal;
  int? paymentMethodId;
  int? totalQty;
  int? totalQtyItem;
  String? statusName;
  String? paymentMethodName;
  String? createdAt;
  GetAddress? getAddress;

  Items(
      {this.orderId,
      this.statusId,
      this.shippingAmount,
      this.grandTotal,
      this.paymentMethodId,
      this.totalQty,
      this.totalQtyItem,
      this.statusName,
      this.paymentMethodName,
      this.createdAt,
      this.getAddress});

  Items.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    statusId = json['status_id'];
    shippingAmount = json['shipping_amount'];
    grandTotal = json['grand_total'];
    paymentMethodId = json['payment_method_id'];
    totalQty = json['total_qty'];
    totalQtyItem = json['total_qty_item'];
    statusName = json['status_name'];
    paymentMethodName = json['payment_method_name'];
    createdAt = json['created_at'];
    getAddress = json['get_address'] != null
        ? GetAddress.fromJson(json['get_address'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['status_id'] = statusId;
    data['shipping_amount'] = shippingAmount;
    data['grand_total'] = grandTotal;
    data['payment_method_id'] = paymentMethodId;
    data['total_qty'] = totalQty;
    data['total_qty_item'] = totalQtyItem;
    data['status_name'] = statusName;
    data['payment_method_name'] = paymentMethodName;
    data['created_at'] = createdAt;
    if (getAddress != null) {
      data['get_address'] = getAddress!.toJson();
    }
    return data;
  }
}

class GetAddress {
  String? address;
  String? street;
  String? buildingNumber;
  String? fullAddress;

  GetAddress(
      {this.address, this.street, this.buildingNumber, this.fullAddress});

  GetAddress.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    street = json['street'];
    buildingNumber = json['building_number'];
    fullAddress = json['full_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['street'] = street;
    data['building_number'] = buildingNumber;
    data['full_address'] = fullAddress;
    return data;
  }
}
