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
  int? itemId;
  String? sku;
  int? qty;
  String? name;
  String? price;
  String? productType;
  String? quoteId;
  String? image;

  Data(
      {this.itemId,
      this.sku,
      this.qty,
      this.name,
      this.price,
      this.productType,
      this.quoteId,
      this.image});

  Data.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'];
    sku = json['sku'];
    qty = json['qty'];
    name = json['name'];
    price = json['price'];
    productType = json['product_type'];
    quoteId = json['quote_id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['item_id'] = itemId;
    data['sku'] = sku;
    data['qty'] = qty;
    data['name'] = name;
    data['price'] = price;
    data['product_type'] = productType;
    data['quote_id'] = quoteId;
    data['image'] = image;
    return data;
  }
}
