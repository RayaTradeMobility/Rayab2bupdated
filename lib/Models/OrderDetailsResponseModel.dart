// ignore_for_file: file_names

class OrderDetailsResponseModel {
  bool? success;
  String? message;
  Data? data;

  OrderDetailsResponseModel({this.success, this.message, this.data});

  OrderDetailsResponseModel.fromJson(Map<String, dynamic> json) {
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
  int? orderId;
  int? statusId;
  int? shippingAmount;
  int? grandTotal;
  int? paymentMethodId;
  int? totalQty;
  int? totalQtyItem;
  String? statusName;
  String? paymentMethodName;
  String? createdAt;
  List<Items>? items;

  Data(
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
      this.items});

  Data.fromJson(Map<String, dynamic> json) {
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
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
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
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  int? id;
  String? sku;
  int? qty;
  String? price;
  String? totalPrice;
  String? name;
  ImageUrl? imageUrl;

  Items(
      {this.id,
      this.sku,
      this.qty,
      this.price,
      this.totalPrice,
      this.name,
      this.imageUrl});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sku = json['sku'];
    qty = json['qty'];
    price = json['price'];
    totalPrice = json['total_price'];
    name = json['name'];
    imageUrl =
        json['image_url'] != null ? ImageUrl.fromJson(json['image_url']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sku'] = sku;
    data['qty'] = qty;
    data['price'] = price;
    data['total_price'] = totalPrice;
    data['name'] = name;
    if (imageUrl != null) {
      data['image_url'] = imageUrl!.toJson();
    }
    return data;
  }
}

class ImageUrl {
  int? valueId;
  String? imageLink;

  ImageUrl({this.valueId, this.imageLink});

  ImageUrl.fromJson(Map<String, dynamic> json) {
    valueId = json['value_id'];
    imageLink = json['image_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value_id'] = valueId;
    data['image_link'] = imageLink;
    return data;
  }
}
