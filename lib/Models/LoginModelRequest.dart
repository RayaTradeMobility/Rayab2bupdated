// ignore_for_file: file_names

class LoginModelRequest {
  String? username;
  String? password;

  LoginModelRequest({this.username, this.password});

  LoginModelRequest.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    return data;
  }
}
