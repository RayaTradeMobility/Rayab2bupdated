// ignore_for_file: file_names

class GetCartResponseModel {
  bool? success;
  String? message;
  Data? data;

  GetCartResponseModel({this.success, this.message, this.data});

  GetCartResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? totalPrice;
  int? totalItem;
  int? totalQtyItems;
  List<Items>? items;

  Data({this.totalPrice, this.totalItem, this.totalQtyItems, this.items});

  Data.fromJson(Map<String, dynamic> json) {
    totalPrice = json['total_price'];
    totalItem = json['total_item'];
    totalQtyItems = json['total_qty_items'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_price'] = totalPrice;
    data['total_item'] = totalItem;
    data['total_qty_items'] = totalQtyItems;
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
  String? imageLink;

  ImageUrl({this.imageLink});

  ImageUrl.fromJson(Map<String, dynamic> json) {
    imageLink = json['image_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image_link'] = imageLink;
    return data;
  }
}
