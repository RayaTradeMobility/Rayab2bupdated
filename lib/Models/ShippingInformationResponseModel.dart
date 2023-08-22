// ignore_for_file: file_names

class ShippingInformationResponseModel {
  bool? success;
  String? message;
  Data? data;

  ShippingInformationResponseModel({this.success, this.message, this.data});

  ShippingInformationResponseModel.fromJson(Map<String, dynamic> json) {
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
  List<PaymentMethods>? paymentMethods;
  Totals? totals;

  Data({this.paymentMethods, this.totals});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['payment_methods'] != null) {
      paymentMethods = <PaymentMethods>[];
      json['payment_methods'].forEach((v) {
        paymentMethods!.add(PaymentMethods.fromJson(v));
      });
    }
    totals = json['totals'] != null ? Totals.fromJson(json['totals']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (paymentMethods != null) {
      data['payment_methods'] = paymentMethods!.map((v) => v.toJson()).toList();
    }
    if (totals != null) {
      data['totals'] = totals!.toJson();
    }
    return data;
  }
}

class PaymentMethods {
  String? code;
  String? title;

  PaymentMethods({this.code, this.title});

  PaymentMethods.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['title'] = title;
    return data;
  }
}

class Totals {
  int? grandTotal;
  int? baseGrandTotal;
  int? subtotal;
  int? baseSubtotal;
  int? discountAmount;
  int? baseDiscountAmount;
  int? subtotalWithDiscount;
  int? baseSubtotalWithDiscount;
  int? shippingAmount;
  int? baseShippingAmount;
  int? shippingDiscountAmount;
  int? baseShippingDiscountAmount;
  int? taxAmount;
  int? baseTaxAmount;
  int? shippingTaxAmount;
  int? baseShippingTaxAmount;
  int? subtotalInclTax;
  int? shippingInclTax;
  int? baseShippingInclTax;
  String? baseCurrencyCode;
  String? quoteCurrencyCode;
  int? itemsQty;
  List<Items>? items;
  List<TotalSegments>? totalSegments;

  Totals(
      {this.grandTotal,
      this.baseGrandTotal,
      this.subtotal,
      this.baseSubtotal,
      this.discountAmount,
      this.baseDiscountAmount,
      this.subtotalWithDiscount,
      this.baseSubtotalWithDiscount,
      this.shippingAmount,
      this.baseShippingAmount,
      this.shippingDiscountAmount,
      this.baseShippingDiscountAmount,
      this.taxAmount,
      this.baseTaxAmount,
      this.shippingTaxAmount,
      this.baseShippingTaxAmount,
      this.subtotalInclTax,
      this.shippingInclTax,
      this.baseShippingInclTax,
      this.baseCurrencyCode,
      this.quoteCurrencyCode,
      this.itemsQty,
      this.items,
      this.totalSegments});

  Totals.fromJson(Map<String, dynamic> json) {
    grandTotal = json['grand_total'];
    baseGrandTotal = json['base_grand_total'];
    subtotal = json['subtotal'];
    baseSubtotal = json['base_subtotal'];
    discountAmount = json['discount_amount'];
    baseDiscountAmount = json['base_discount_amount'];
    subtotalWithDiscount = json['subtotal_with_discount'];
    baseSubtotalWithDiscount = json['base_subtotal_with_discount'];
    shippingAmount = json['shipping_amount'];
    baseShippingAmount = json['base_shipping_amount'];
    shippingDiscountAmount = json['shipping_discount_amount'];
    baseShippingDiscountAmount = json['base_shipping_discount_amount'];
    taxAmount = json['tax_amount'];
    baseTaxAmount = json['base_tax_amount'];
    shippingTaxAmount = json['shipping_tax_amount'];
    baseShippingTaxAmount = json['base_shipping_tax_amount'];
    subtotalInclTax = json['subtotal_incl_tax'];
    shippingInclTax = json['shipping_incl_tax'];
    baseShippingInclTax = json['base_shipping_incl_tax'];
    baseCurrencyCode = json['base_currency_code'];
    quoteCurrencyCode = json['quote_currency_code'];
    itemsQty = json['items_qty'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    if (json['total_segments'] != null) {
      totalSegments = <TotalSegments>[];
      json['total_segments'].forEach((v) {
        totalSegments!.add(TotalSegments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['grand_total'] = grandTotal;
    data['base_grand_total'] = baseGrandTotal;
    data['subtotal'] = subtotal;
    data['base_subtotal'] = baseSubtotal;
    data['discount_amount'] = discountAmount;
    data['base_discount_amount'] = baseDiscountAmount;
    data['subtotal_with_discount'] = subtotalWithDiscount;
    data['base_subtotal_with_discount'] = baseSubtotalWithDiscount;
    data['shipping_amount'] = shippingAmount;
    data['base_shipping_amount'] = baseShippingAmount;
    data['shipping_discount_amount'] = shippingDiscountAmount;
    data['base_shipping_discount_amount'] = baseShippingDiscountAmount;
    data['tax_amount'] = taxAmount;
    data['base_tax_amount'] = baseTaxAmount;
    data['shipping_tax_amount'] = shippingTaxAmount;
    data['base_shipping_tax_amount'] = baseShippingTaxAmount;
    data['subtotal_incl_tax'] = subtotalInclTax;
    data['shipping_incl_tax'] = shippingInclTax;
    data['base_shipping_incl_tax'] = baseShippingInclTax;
    data['base_currency_code'] = baseCurrencyCode;
    data['quote_currency_code'] = quoteCurrencyCode;
    data['items_qty'] = itemsQty;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    if (totalSegments != null) {
      data['total_segments'] = totalSegments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  int? itemId;
  int? price;
  int? basePrice;
  int? qty;
  int? rowTotal;
  int? baseRowTotal;
  int? rowTotalWithDiscount;
  int? taxAmount;
  int? baseTaxAmount;
  int? taxPercent;
  int? discountAmount;
  int? baseDiscountAmount;
  int? discountPercent;
  int? priceInclTax;
  int? basePriceInclTax;
  int? rowTotalInclTax;
  int? baseRowTotalInclTax;
  String? options;
  String? name;

  Items(
      {this.itemId,
      this.price,
      this.basePrice,
      this.qty,
      this.rowTotal,
      this.baseRowTotal,
      this.rowTotalWithDiscount,
      this.taxAmount,
      this.baseTaxAmount,
      this.taxPercent,
      this.discountAmount,
      this.baseDiscountAmount,
      this.discountPercent,
      this.priceInclTax,
      this.basePriceInclTax,
      this.rowTotalInclTax,
      this.baseRowTotalInclTax,
      this.options,
      this.name});

  Items.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'];
    price = json['price'];
    basePrice = json['base_price'];
    qty = json['qty'];
    rowTotal = json['row_total'];
    baseRowTotal = json['base_row_total'];
    rowTotalWithDiscount = json['row_total_with_discount'];
    taxAmount = json['tax_amount'];
    baseTaxAmount = json['base_tax_amount'];
    taxPercent = json['tax_percent'];
    discountAmount = json['discount_amount'];
    baseDiscountAmount = json['base_discount_amount'];
    discountPercent = json['discount_percent'];
    priceInclTax = json['price_incl_tax'];
    basePriceInclTax = json['base_price_incl_tax'];
    rowTotalInclTax = json['row_total_incl_tax'];
    baseRowTotalInclTax = json['base_row_total_incl_tax'];
    options = json['options'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['item_id'] = itemId;
    data['price'] = price;
    data['base_price'] = basePrice;
    data['qty'] = qty;
    data['row_total'] = rowTotal;
    data['base_row_total'] = baseRowTotal;
    data['row_total_with_discount'] = rowTotalWithDiscount;
    data['tax_amount'] = taxAmount;
    data['base_tax_amount'] = baseTaxAmount;
    data['tax_percent'] = taxPercent;
    data['discount_amount'] = discountAmount;
    data['base_discount_amount'] = baseDiscountAmount;
    data['discount_percent'] = discountPercent;
    data['price_incl_tax'] = priceInclTax;
    data['base_price_incl_tax'] = basePriceInclTax;
    data['row_total_incl_tax'] = rowTotalInclTax;
    data['base_row_total_incl_tax'] = baseRowTotalInclTax;
    data['options'] = options;
    data['name'] = name;
    return data;
  }
}

class TotalSegments {
  String? code;
  String? title;
  int? value;
  String? area;

  TotalSegments({this.code, this.title, this.value, this.area});

  TotalSegments.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    title = json['title'];
    value = json['value'];
    area = json['area'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['title'] = title;
    data['value'] = value;
    data['area'] = area;
    return data;
  }
}
