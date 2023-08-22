// ignore_for_file: file_names

class RegisterRequestModel {
  Customer? customer;
  String? password;

  RegisterRequestModel({this.customer, this.password});

  RegisterRequestModel.fromJson(Map<String, dynamic> json) {
    customer =
        json['customer'] != null ? Customer.fromJson(json['customer']) : null;
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    data['password'] = password;
    return data;
  }
}

class Customer {
  String? email;
  String? firstname;
  String? lastname;
  List<Addresses>? addresses;

  Customer({this.email, this.firstname, this.lastname, this.addresses});

  Customer.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    if (json['addresses'] != null) {
      addresses = <Addresses>[];
      json['addresses'].forEach((v) {
        addresses!.add(Addresses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    if (addresses != null) {
      data['addresses'] = addresses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Addresses {
  bool? defaultShipping;
  bool? defaultBilling;
  String? firstname;
  String? lastname;
  Region? region;
  String? postcode;
  List<String>? street;
  String? city;
  String? telephone;
  String? countryId;

  Addresses(
      {this.defaultShipping,
      this.defaultBilling,
      this.firstname,
      this.lastname,
      this.region,
      this.postcode,
      this.street,
      this.city,
      this.telephone,
      this.countryId});

  Addresses.fromJson(Map<String, dynamic> json) {
    defaultShipping = json['defaultShipping'];
    defaultBilling = json['defaultBilling'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    region = json['region'] != null ? Region.fromJson(json['region']) : null;
    postcode = json['postcode'];
    street = json['street'].cast<String>();
    city = json['city'];
    telephone = json['telephone'];
    countryId = json['countryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['defaultShipping'] = defaultShipping;
    data['defaultBilling'] = defaultBilling;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    if (region != null) {
      data['region'] = region!.toJson();
    }
    data['postcode'] = postcode;
    data['street'] = street;
    data['city'] = city;
    data['telephone'] = telephone;
    data['countryId'] = countryId;
    return data;
  }
}

class Region {
  String? regionCode;
  String? region;
  int? regionId;

  Region({this.regionCode, this.region, this.regionId});

  Region.fromJson(Map<String, dynamic> json) {
    regionCode = json['regionCode'];
    region = json['region'];
    regionId = json['regionId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['regionCode'] = regionCode;
    data['region'] = region;
    data['regionId'] = regionId;
    return data;
  }
}
