// ignore_for_file: file_names

class OpenCartResponseModel {
  bool? success;
  String? message;
  Data? data;

  OpenCartResponseModel({this.success, this.message, this.data});

  OpenCartResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? quoteId;

  Data({this.quoteId});

  Data.fromJson(Map<String, dynamic> json) {
    quoteId = json['quote_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['quote_id'] = quoteId;
    return data;
  }
}
