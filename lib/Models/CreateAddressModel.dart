// ignore_for_file: file_names

class CreateAddressModel {
  bool? success;
  String? message;
  Data? data;

  CreateAddressModel({this.success, this.message, this.data});

  CreateAddressModel.fromJson(Map<String, dynamic> json) {
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
  String? regionId;
  String? address;
  String? street;
  String? buildingNumber;
  int? userId;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.regionId,
      this.address,
      this.street,
      this.buildingNumber,
      this.userId,
      this.updatedAt,
      this.createdAt,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    regionId = json['region_id'];
    address = json['address'];
    street = json['street'];
    buildingNumber = json['building_number'];
    userId = json['user_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['region_id'] = regionId;
    data['address'] = address;
    data['street'] = street;
    data['building_number'] = buildingNumber;
    data['user_id'] = userId;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}
