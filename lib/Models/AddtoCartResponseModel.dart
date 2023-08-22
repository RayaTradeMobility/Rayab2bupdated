// ignore_for_file: prefer_typing_uninitialized_variables, file_names

class AddtoCartResponseModel {
  bool? success;
  String? message;
  Data? data;

  AddtoCartResponseModel({this.success, this.message, this.data});

  AddtoCartResponseModel.fromJson(Map<String, dynamic> json) {
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
  int? itemId;
  String? sku;
  int? qty;
  String? name;
  var price;
  String? productType;
  String? quoteId;

  Data(
      {this.itemId,
      this.sku,
      this.qty,
      this.name,
      this.price,
      this.productType,
      this.quoteId});

  Data.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'];
    sku = json['sku'];
    qty = json['qty'];
    name = json['name'];
    price = json['price'];
    productType = json['product_type'];
    quoteId = json['quote_id'];
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
    return data;
  }
}
