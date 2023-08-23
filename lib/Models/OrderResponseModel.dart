// ignore_for_file: file_names

class OrderResponseModel {
  bool? success;
  String? message;
  Data? data;

  OrderResponseModel({this.success, this.message, this.data});

  OrderResponseModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? grandTotal;
  String? createdAt;

  Data({this.id, this.grandTotal, this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    grandTotal = json['grand_total'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['grand_total'] = grandTotal;
    data['created_at'] = createdAt;
    return data;
  }
}
