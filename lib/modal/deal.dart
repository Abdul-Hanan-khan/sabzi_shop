import 'package:get/get.dart';

class Deal {
  String id;
  String title;
  String urduTitle;
  String shortDetails;
  String dealAmount;
  String dated;
  String deletedFlag;
  String status;
  String updatedDate;
  String userId;
  String expiryDate;
  String fullImage;
  String squareImage;
  RxInt quantity = 0.obs;
  List<DealProduct> dealProducts;

  Deal(
      {this.id,
        this.title,
        this.urduTitle,
        this.shortDetails,
        this.dealAmount,
        this.dated,
        this.deletedFlag,
        this.status,
        this.updatedDate,
        this.userId,
        this.expiryDate,
        this.fullImage,
        this.squareImage,
        this.dealProducts,
        this.quantity});

  Deal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    urduTitle = json['urdu_title'];
    shortDetails = json['short_details'];
    dealAmount = json['deal_amount'];
    dated = json['dated'];
    deletedFlag = json['deleted_flag'];
    status = json['status'];
    updatedDate = json['updated_date'];
    userId = json['user_id'];
    expiryDate = json['expiry_date'];


    fullImage = json['full_image'];
    squareImage = json['square_image'];


    quantity.value = json['quantity']??0;
    if (json['deal_details'] != null) {
      dealProducts = <DealProduct>[];
      json['deal_details'].forEach((v) {
        dealProducts.add(new DealProduct.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['urdu_title'] = this.urduTitle;
    data['short_details'] = this.shortDetails;
    data['deal_amount'] = this.dealAmount;
    data['dated'] = this.dated;
    data['deleted_flag'] = this.deletedFlag;
    data['status'] = this.status;
    data['updated_date'] = this.updatedDate;
    data['user_id'] = this.userId;
    data['expiry_date'] = this.expiryDate;


    data['full_image'] = this.fullImage;
    data['square_image'] = this.squareImage;

    data['quantity'] = this.quantity.value;
    if (this.dealProducts != null) {
      data['deal_details'] = this.dealProducts.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DealProduct {
  String id;
  String dealId;
  String productId;
  String saleAmount;
  String saleDiscount;
  String saleQuantity;
  String title;
  String urduTitle;
  String productPhoto;
  String unitValue;
  String unitName;
  String categoryTitle;
  String subCategoryTitle;
  String discountedPrice;
  String subTotal;


  DealProduct(
      {this.id,
        this.dealId,
        this.productId,
        this.saleAmount,
        this.saleDiscount,
        this.saleQuantity,
        this.title,
        this.urduTitle,
        this.productPhoto,
        this.unitValue,
        this.unitName,
        this.categoryTitle,
        this.subCategoryTitle,
        this.discountedPrice,
        this.subTotal});

  DealProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dealId = json['deal_id'];
    productId = json['product_id'];
    saleAmount = json['sale_amount'];
    saleDiscount = json['sale_discount'];
    saleQuantity = json['sale_quantity'];
    title = json['title'];
    urduTitle = json['urdu_title'];
    productPhoto = json['product_photo'];
    unitValue = json['unit_value'];
    unitName = json['unit_name'];
    categoryTitle = json['category_title'];
    subCategoryTitle = json['sub_category_title'];
    discountedPrice = json['discounted_price'];
    subTotal = json['sub_total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['deal_id'] = this.dealId;
    data['product_id'] = this.productId;
    data['sale_amount'] = this.saleAmount;
    data['sale_discount'] = this.saleDiscount;
    data['sale_quantity'] = this.saleQuantity;
    data['title'] = this.title;
    data['urdu_title'] = this.urduTitle;
    data['product_photo'] = this.productPhoto;
    data['unit_value'] = this.unitValue;
    data['unit_name'] = this.unitName;
    data['category_title'] = this.categoryTitle;
    data['sub_category_title'] = this.subCategoryTitle;
    data['discounted_price'] = this.discountedPrice;
    data['sub_total'] = this.subTotal;
    return data;
  }
}

