// ignore_for_file: file_names

class GetProductsResponseModel {
  bool? success;
  String? message;
  List<Data>? data;

  GetProductsResponseModel({this.success, this.message, this.data});

  GetProductsResponseModel.fromJson(Map<String, dynamic> json) {
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
  List<Items>? items;
  SearchCriteria? searchCriteria;
  int? totalCount;

  Data({this.items, this.searchCriteria, this.totalCount});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    searchCriteria = json['search_criteria'] != null
        ? SearchCriteria.fromJson(json['search_criteria'])
        : null;
    totalCount = json['total_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    if (searchCriteria != null) {
      data['search_criteria'] = searchCriteria!.toJson();
    }
    data['total_count'] = totalCount;
    return data;
  }
}

class Items {
  int? id;
  String? sku;
  String? name;
  int? attributeSetId;
  int? price;
  int? status;
  int? visibility;
  String? typeId;
  String? createdAt;
  String? updatedAt;
  ExtensionAttributes? extensionAttributes;
  List<ProductLinks>? productLinks;
  List<String>? options;
  List<MediaGalleryEntries>? mediaGalleryEntries;
  List<String>? tierPrices;
  List<CustomAttributes>? customAttributes;

  Items(
      {this.id,
      this.sku,
      this.name,
      this.attributeSetId,
      this.price,
      this.status,
      this.visibility,
      this.typeId,
      this.createdAt,
      this.updatedAt,
      this.extensionAttributes,
      this.productLinks,
      this.options,
      this.mediaGalleryEntries,
      this.tierPrices,
      this.customAttributes});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sku = json['sku'];
    name = json['name'];
    attributeSetId = json['attribute_set_id'];
    price = json['price'];
    status = json['status'];
    visibility = json['visibility'];
    typeId = json['type_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    extensionAttributes = json['extension_attributes'] != null
        ? ExtensionAttributes.fromJson(json['extension_attributes'])
        : null;
    if (json['product_links'] != null) {
      productLinks = <ProductLinks>[];
      json['product_links'].forEach((v) {
        productLinks!.add(ProductLinks.fromJson(v));
      });
    }
    if (json['options'] != null) {}
    if (json['media_gallery_entries'] != null) {
      mediaGalleryEntries = <MediaGalleryEntries>[];
      json['media_gallery_entries'].forEach((v) {
        mediaGalleryEntries!.add(MediaGalleryEntries.fromJson(v));
      });
    }
    if (json['tier_prices'] != null) {}
    if (json['custom_attributes'] != null) {
      customAttributes = <CustomAttributes>[];
      json['custom_attributes'].forEach((v) {
        customAttributes!.add(CustomAttributes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sku'] = sku;
    data['name'] = name;
    data['attribute_set_id'] = attributeSetId;
    data['price'] = price;
    data['status'] = status;
    data['visibility'] = visibility;
    data['type_id'] = typeId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (extensionAttributes != null) {
      data['extension_attributes'] = extensionAttributes!.toJson();
    }
    if (productLinks != null) {
      data['product_links'] = productLinks!.map((v) => v.toJson()).toList();
    }
    if (options != null) {}
    if (mediaGalleryEntries != null) {
      data['media_gallery_entries'] =
          mediaGalleryEntries!.map((v) => v.toJson()).toList();
    }
    if (tierPrices != null) {}
    if (customAttributes != null) {
      data['custom_attributes'] =
          customAttributes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ExtensionAttributes {
  List<int>? websiteIds;
  List<CategoryLinks>? categoryLinks;

  ExtensionAttributes({this.websiteIds, this.categoryLinks});

  ExtensionAttributes.fromJson(Map<String, dynamic> json) {
    websiteIds = json['website_ids'].cast<int>();
    if (json['category_links'] != null) {
      categoryLinks = <CategoryLinks>[];
      json['category_links'].forEach((v) {
        categoryLinks!.add(CategoryLinks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['website_ids'] = websiteIds;
    if (categoryLinks != null) {
      data['category_links'] = categoryLinks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryLinks {
  int? position;
  String? categoryId;

  CategoryLinks({this.position, this.categoryId});

  CategoryLinks.fromJson(Map<String, dynamic> json) {
    position = json['position'];
    categoryId = json['category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['position'] = position;
    data['category_id'] = categoryId;
    return data;
  }
}

class ProductLinks {
  String? sku;
  String? linkType;
  String? linkedProductSku;
  String? linkedProductType;
  int? position;

  ProductLinks(
      {this.sku,
      this.linkType,
      this.linkedProductSku,
      this.linkedProductType,
      this.position});

  ProductLinks.fromJson(Map<String, dynamic> json) {
    sku = json['sku'];
    linkType = json['link_type'];
    linkedProductSku = json['linked_product_sku'];
    linkedProductType = json['linked_product_type'];
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sku'] = sku;
    data['link_type'] = linkType;
    data['linked_product_sku'] = linkedProductSku;
    data['linked_product_type'] = linkedProductType;
    data['position'] = position;
    return data;
  }
}

class MediaGalleryEntries {
  int? id;
  String? mediaType;
  String? label;
  int? position;
  bool? disabled;
  List<String>? types;
  String? file;

  MediaGalleryEntries(
      {this.id,
      this.mediaType,
      this.label,
      this.position,
      this.disabled,
      this.types,
      this.file});

  MediaGalleryEntries.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mediaType = json['media_type'];
    label = json['label'];
    position = json['position'];
    disabled = json['disabled'];
    types = json['types'].cast<String>();
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['media_type'] = mediaType;
    data['label'] = label;
    data['position'] = position;
    data['disabled'] = disabled;
    data['types'] = types;
    data['file'] = file;
    return data;
  }
}

class CustomAttributes {
  String? attributeCode;
  String? value;

  CustomAttributes({this.attributeCode, this.value});

  CustomAttributes.fromJson(Map<String, dynamic> json) {
    attributeCode = json['attribute_code'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['attribute_code'] = attributeCode;
    data['value'] = value;
    return data;
  }
}

class SearchCriteria {
  List<String>? filterGroups;
  int? pageSize;
  int? currentPage;

  SearchCriteria({this.filterGroups, this.pageSize, this.currentPage});

  SearchCriteria.fromJson(Map<String, dynamic> json) {
    if (json['filter_groups'] != null) {}
    pageSize = json['page_size'];
    currentPage = json['current_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (filterGroups != null) {}
    data['page_size'] = pageSize;
    data['current_page'] = currentPage;
    return data;
  }
}
