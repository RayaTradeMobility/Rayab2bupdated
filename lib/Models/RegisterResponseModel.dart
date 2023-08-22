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
  int? id;
  int? groupId;
  String? defaultBilling;
  String? defaultShipping;
  String? createdAt;
  String? updatedAt;
  String? createdIn;
  String? email;
  String? firstname;
  String? lastname;
  int? storeId;
  int? websiteId;
  List<Addresses>? addresses;
  int? disableAutoGroupChange;
  ExtensionAttributes? extensionAttributes;

  Data(
      {this.id,
      this.groupId,
      this.defaultBilling,
      this.defaultShipping,
      this.createdAt,
      this.updatedAt,
      this.createdIn,
      this.email,
      this.firstname,
      this.lastname,
      this.storeId,
      this.websiteId,
      this.addresses,
      this.disableAutoGroupChange,
      this.extensionAttributes});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupId = json['group_id'];
    defaultBilling = json['default_billing'];
    defaultShipping = json['default_shipping'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdIn = json['created_in'];
    email = json['email'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    storeId = json['store_id'];
    websiteId = json['website_id'];
    if (json['addresses'] != null) {
      addresses = <Addresses>[];
      json['addresses'].forEach((v) {
        addresses!.add(Addresses.fromJson(v));
      });
    }
    disableAutoGroupChange = json['disable_auto_group_change'];
    extensionAttributes = json['extension_attributes'] != null
        ? ExtensionAttributes.fromJson(json['extension_attributes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['group_id'] = groupId;
    data['default_billing'] = defaultBilling;
    data['default_shipping'] = defaultShipping;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['created_in'] = createdIn;
    data['email'] = email;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['store_id'] = storeId;
    data['website_id'] = websiteId;
    if (addresses != null) {
      data['addresses'] = addresses!.map((v) => v.toJson()).toList();
    }
    data['disable_auto_group_change'] = disableAutoGroupChange;
    if (extensionAttributes != null) {
      data['extension_attributes'] = extensionAttributes!.toJson();
    }
    return data;
  }
}

class Addresses {
  int? id;
  int? customerId;
  Region? region;
  int? regionId;
  String? countryId;
  List<String>? street;
  String? telephone;
  String? postcode;
  String? city;
  String? firstname;
  String? lastname;
  bool? defaultShipping;
  bool? defaultBilling;

  Addresses(
      {this.id,
      this.customerId,
      this.region,
      this.regionId,
      this.countryId,
      this.street,
      this.telephone,
      this.postcode,
      this.city,
      this.firstname,
      this.lastname,
      this.defaultShipping,
      this.defaultBilling});

  Addresses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    region = json['region'] != null ? Region.fromJson(json['region']) : null;
    regionId = json['region_id'];
    countryId = json['country_id'];
    street = json['street'].cast<String>();
    telephone = json['telephone'];
    postcode = json['postcode'];
    city = json['city'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    defaultShipping = json['default_shipping'];
    defaultBilling = json['default_billing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['customer_id'] = customerId;
    if (region != null) {
      data['region'] = region!.toJson();
    }
    data['region_id'] = regionId;
    data['country_id'] = countryId;
    data['street'] = street;
    data['telephone'] = telephone;
    data['postcode'] = postcode;
    data['city'] = city;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['default_shipping'] = defaultShipping;
    data['default_billing'] = defaultBilling;
    return data;
  }
}

class Region {
  String? regionCode;
  String? region;
  int? regionId;

  Region({this.regionCode, this.region, this.regionId});

  Region.fromJson(Map<String, dynamic> json) {
    regionCode = json['region_code'];
    region = json['region'];
    regionId = json['region_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['region_code'] = regionCode;
    data['region'] = region;
    data['region_id'] = regionId;
    return data;
  }
}

class ExtensionAttributes {
  bool? isSubscribed;

  ExtensionAttributes({this.isSubscribed});

  ExtensionAttributes.fromJson(Map<String, dynamic> json) {
    isSubscribed = json['is_subscribed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['is_subscribed'] = isSubscribed;
    return data;
  }
}
