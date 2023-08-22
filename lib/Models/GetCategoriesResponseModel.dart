// ignore_for_file: file_names

class GetCategoriesResponseModel {
  bool? success;
  String? message;
  List<Data>? data;

  GetCategoriesResponseModel({this.success, this.message, this.data});

  GetCategoriesResponseModel.fromJson(Map<String, dynamic> json) {
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
  List<ChildrenData>? childrenData;

  Data({this.childrenData});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['children_data'] != null) {
      childrenData = <ChildrenData>[];
      json['children_data'].forEach((v) {
        childrenData!.add(ChildrenData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (childrenData != null) {
      data['children_data'] = childrenData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChildrenData {
  int? id;
  String? name;
  List<ChildrenData>? childrenData;

  ChildrenData({this.id, this.name, this.childrenData});

  ChildrenData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['children_data'] != null) {
      childrenData = <ChildrenData>[];
      json['children_data'].forEach((v) {
        childrenData!.add(ChildrenData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (childrenData != null) {
      data['children_data'] = childrenData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
