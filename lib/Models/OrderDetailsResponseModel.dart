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
  String? status;
  String? baseSubtotal;
  String? shippingAmount;
  String? grandTotal;
  List<Items>? items;

  Data(
      {this.orderId,
      this.status,
      this.baseSubtotal,
      this.shippingAmount,
      this.grandTotal,
      this.items});

  Data.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    status = json['status'];
    baseSubtotal = json['base_subtotal'];
    shippingAmount = json['shipping_amount'];
    grandTotal = json['grand_total'];
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
    data['status'] = status;
    data['base_subtotal'] = baseSubtotal;
    data['shipping_amount'] = shippingAmount;
    data['grand_total'] = grandTotal;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  int? itemId;
  String? sku;
  String? name;
  String? qtyOrdered;
  String? price;
  String? total;
  String? imageUrl;

  Items(
      {this.itemId,
      this.sku,
      this.name,
      this.qtyOrdered,
      this.price,
      this.total,
      this.imageUrl});

  Items.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'];
    sku = json['sku'];
    name = json['name'];
    qtyOrdered = json['qty_ordered'];
    price = json['price'];
    total = json['total'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['item_id'] = itemId;
    data['sku'] = sku;
    data['name'] = name;
    data['qty_ordered'] = qtyOrdered;
    data['price'] = price;
    data['total'] = total;
    data['image_url'] = imageUrl;
    return data;
  }
}
