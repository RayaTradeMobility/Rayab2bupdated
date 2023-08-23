// ignore_for_file: file_names

class GetCartResponseModel {
  bool? success;
  String? message;
  List<Data>? data;

  GetCartResponseModel({this.success, this.message, this.data});

  GetCartResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? sku;
  int? qty;
  String? price;
  String? totalPrice;
  String? name;
  ImageUrl? imageUrl;

  Data(
      {this.id,
      this.sku,
      this.qty,
      this.price,
      this.totalPrice,
      this.name,
      this.imageUrl});

  Data.fromJson(Map<String, dynamic> json) {
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
