// ignore_for_file: file_names

class GetAddressModel {
  bool? success;
  String? message;
  List<Data>? data;

  GetAddressModel({this.success, this.message, this.data});

  GetAddressModel.fromJson(Map<String, dynamic> json) {
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
  String? address;
  String? street;
  String? buildingNumber;
  int? mainAddresse;
  String? createdAt;

  Data(
      {this.id,
      this.address,
      this.street,
      this.buildingNumber,
      this.mainAddresse,
      this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = json['address'];
    street = json['street'];
    buildingNumber = json['building_number'];
    mainAddresse = json['main_addresse'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['address'] = address;
    data['street'] = street;
    data['building_number'] = buildingNumber;
    data['main_addresse'] = mainAddresse;
    data['created_at'] = createdAt;
    return data;
  }
}
