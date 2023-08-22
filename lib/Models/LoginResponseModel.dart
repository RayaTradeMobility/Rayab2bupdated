// ignore_for_file: file_names

class LoginResponseModel {
  bool? success;
  String? message;
  Data? data;

  LoginResponseModel({this.success, this.message, this.data});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? token;
  int? id;
  String? email;
  String? fullname;
  String? firstname;
  String? lastname;
  String? telephone;

  Data(
      {this.token,
      this.id,
      this.email,
      this.fullname,
      this.firstname,
      this.lastname,
      this.telephone});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    id = json['id'];
    email = json['email'];
    fullname = json['fullname'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    telephone = json['telephone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['id'] = id;
    data['email'] = email;
    data['fullname'] = fullname;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['telephone'] = telephone;
    return data;
  }
}
