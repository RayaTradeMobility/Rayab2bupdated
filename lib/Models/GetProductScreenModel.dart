// ignore_for_file: file_names

class ProductbySkuModel {
  bool? success;
  String? message;
  Data? data;

  ProductbySkuModel({this.success, this.message, this.data});

  ProductbySkuModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? sku;
  String? price;
  String? priceWithoutComma;
  int? qty;
  int? salableQuantity;
  String? description;
  int? isStock;
  int? minSaleQty;
  int? maxSaleQty;
  List<Images>? images;
  List<Categories>? categories;
  List<Attributes>? attributes;

  Data(
      {this.id,
        this.name,
        this.sku,
        this.price,
        this.priceWithoutComma,
        this.qty,
        this.salableQuantity,
        this.description,
        this.isStock,
        this.minSaleQty,
        this.maxSaleQty,
        this.images,
        this.categories,
        this.attributes});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sku = json['sku'];
    price = json['price'];
    priceWithoutComma = json['price_without_comma'];
    qty = json['qty'];
    salableQuantity = json['salable_quantity'];
    description = json['description'];
    isStock = json['is_stock'];
    minSaleQty = json['min_sale_qty'];
    maxSaleQty = json['max_sale_qty'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
    if (json['attributes'] != null) {
      attributes = <Attributes>[];
      json['attributes'].forEach((v) {
        attributes!.add(Attributes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['sku'] = sku;
    data['price'] = price;
    data['price_without_comma'] = priceWithoutComma;
    data['qty'] = qty;
    data['salable_quantity'] = salableQuantity;
    data['description'] = description;
    data['is_stock'] = isStock;
    data['min_sale_qty'] = minSaleQty;
    data['max_sale_qty'] = maxSaleQty;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    if (attributes != null) {
      data['attributes'] = attributes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  int? valueId;
  int? storeId;
  int? entityId;
  String? label;
  int? position;
  int? disabled;
  int? recordId;
  String? imageLink;

  Images(
      {this.valueId,
        this.storeId,
        this.entityId,
        this.label,
        this.position,
        this.disabled,
        this.recordId,
        this.imageLink});

  Images.fromJson(Map<String, dynamic> json) {
    valueId = json['value_id'];
    storeId = json['store_id'];
    entityId = json['entity_id'];
    label = json['label'];
    position = json['position'];
    disabled = json['disabled'];
    recordId = json['record_id'];
    imageLink = json['image_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value_id'] = valueId;
    data['store_id'] = storeId;
    data['entity_id'] = entityId;
    data['label'] = label;
    data['position'] = position;
    data['disabled'] = disabled;
    data['record_id'] = recordId;
    data['image_link'] = imageLink;
    return data;
  }
}

class Categories {
  int? entityId;
  int? categoryId;
  int? productId;
  int? position;
  String? nameCategary;

  Categories(
      {this.entityId,
        this.categoryId,
        this.productId,
        this.position,
        this.nameCategary});

  Categories.fromJson(Map<String, dynamic> json) {
    entityId = json['entity_id'];
    categoryId = json['category_id'];
    productId = json['product_id'];
    position = json['position'];
    nameCategary = json['name_categary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['entity_id'] = entityId;
    data['category_id'] = categoryId;
    data['product_id'] = productId;
    data['position'] = position;
    data['name_categary'] = nameCategary;
    return data;
  }
}

class Attributes {
  int? attributeId;
  int? value;
  NameAttribute? nameAttribute;

  Attributes({this.attributeId, this.value, this.nameAttribute});

  Attributes.fromJson(Map<String, dynamic> json) {
    attributeId = json['attribute_id'];
    value = json['value'];
    nameAttribute = json['name_attribute'] != null
        ? NameAttribute.fromJson(json['name_attribute'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['attribute_id'] = attributeId;
    data['value'] = value;
    if (nameAttribute != null) {
      data['name_attribute'] = nameAttribute!.toJson();
    }
    return data;
  }
}

class NameAttribute {
  String? name;
  // ignore: prefer_typing_uninitialized_variables
  var value;

  NameAttribute({this.name, this.value});

  NameAttribute.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['value'] = value;
    return data;
  }
}