// ignore_for_file: file_names

class RegisterResponseModel {
  bool? success;
  String? message;
  Data? data;

  RegisterResponseModel({this.success, this.message, this.data});

  RegisterResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? mobile;
  String? companyName;
  String? email;
  String? oracleNumber;
  int? roleId;
  String? updatedAt;
  String? createdAt;
  int? id;
  String? token;

  Data(
      {this.name,
      this.mobile,
      this.companyName,
      this.email,
      this.oracleNumber,
      this.roleId,
      this.updatedAt,
      this.createdAt,
      this.id,
      this.token});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    mobile = json['mobile'];
    companyName = json['company_name'];
    email = json['email'];
    oracleNumber = json['oracle_number'];
    roleId = json['role_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['mobile'] = mobile;
    data['company_name'] = companyName;
    data['email'] = email;
    data['oracle_number'] = oracleNumber;
    data['role_id'] = roleId;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    data['token'] = token;
    return data;
  }
}
