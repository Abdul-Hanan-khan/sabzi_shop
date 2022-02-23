import 'order_history.dart';

class DashBoard {
  Order latestOrder;
  String deliveredOrders;
  String pendingOrders;
  String totalSpending;

  DashBoard(
      {this.latestOrder,
        this.deliveredOrders,
        this.pendingOrders,
        this.totalSpending});

  DashBoard.fromJson(Map<String, dynamic> json) {
    latestOrder = json['latest_order'] != null
        ? new Order.fromJson(json['latest_order'])
        : null;
    deliveredOrders = json['delivered_orders'];
    pendingOrders = json['pending_orders'];
    totalSpending = json['total_spending'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.latestOrder != null) {
      data['latest_order'] = this.latestOrder.toJson();
    }
    data['delivered_orders'] = this.deliveredOrders;
    data['pending_orders'] = this.pendingOrders;
    data['total_spending'] = this.totalSpending;
    return data;
  }
}


//
// class BillingAddress {
//   String id;
//   String postcode;
//   String city;
//   String address;
//   String colonyName;
//
//   BillingAddress(
//       {this.id, this.postcode, this.city, this.address, this.colonyName});
//
//   BillingAddress.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     postcode = json['postcode'];
//     city = json['city'];
//     address = json['address'];
//     colonyName = json['colony_name'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['postcode'] = this.postcode;
//     data['city'] = this.city;
//     data['address'] = this.address;
//     data['colony_name'] = this.colonyName;
//     return data;
//   }
// }
//
//
// class DealInformation {
//   String id;
//   String title;
//   String urduTitle;
//   String shortDetails;
//   String dealAmount;
//   String dated;
//   String deletedFlag;
//   String status;
//   String updatedDate;
//   String userId;
//   String expiryDate;
//   int originalDealTotal;
//
//   DealInformation(
//       {this.id,
//         this.title,
//         this.urduTitle,
//         this.shortDetails,
//         this.dealAmount,
//         this.dated,
//         this.deletedFlag,
//         this.status,
//         this.updatedDate,
//         this.userId,
//         this.expiryDate,
//         this.originalDealTotal});
//
//   DealInformation.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     title = json['title'];
//     urduTitle = json['urdu_title'];
//     shortDetails = json['short_details'];
//     dealAmount = json['deal_amount'];
//     dated = json['dated'];
//     deletedFlag = json['deleted_flag'];
//     status = json['status'];
//     updatedDate = json['updated_date'];
//     userId = json['user_id'];
//     expiryDate = json['expiry_date'];
//     originalDealTotal = json['original_deal_total'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['title'] = this.title;
//     data['urdu_title'] = this.urduTitle;
//     data['short_details'] = this.shortDetails;
//     data['deal_amount'] = this.dealAmount;
//     data['dated'] = this.dated;
//     data['deleted_flag'] = this.deletedFlag;
//     data['status'] = this.status;
//     data['updated_date'] = this.updatedDate;
//     data['user_id'] = this.userId;
//     data['expiry_date'] = this.expiryDate;
//     data['original_deal_total'] = this.originalDealTotal;
//     return data;
//   }
// }
//
// class DealDetails {
//   String id;
//   String dealId;
//   String productId;
//   String saleAmount;
//   String saleDiscount;
//   String saleQuantity;
//   String unitId;
//   String categoryId;
//   String subCategoryId;
//   String productTitle;
//   String urduTitle;
//   String productPhoto;
//   String unitValue;
//   String categoryTitle;
//   String subCategoryTitle;
//   String unitName;
//   String discountedPrice;
//   String subTotal;
//
//   DealDetails(
//       {this.id,
//         this.dealId,
//         this.productId,
//         this.saleAmount,
//         this.saleDiscount,
//         this.saleQuantity,
//         this.unitId,
//         this.categoryId,
//         this.subCategoryId,
//         this.productTitle,
//         this.urduTitle,
//         this.productPhoto,
//         this.unitValue,
//         this.categoryTitle,
//         this.subCategoryTitle,
//         this.unitName,
//         this.discountedPrice,
//         this.subTotal});
//
//   DealDetails.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     dealId = json['deal_id'];
//     productId = json['product_id'];
//     saleAmount = json['sale_amount'];
//     saleDiscount = json['sale_discount'];
//     saleQuantity = json['sale_quantity'];
//     unitId = json['unit_id'];
//     categoryId = json['category_id'];
//     subCategoryId = json['sub_category_id'];
//     productTitle = json['product_title'];
//     urduTitle = json['urdu_title'];
//     productPhoto = json['product_photo'];
//     unitValue = json['unit_value'];
//     categoryTitle = json['category_title'];
//     subCategoryTitle = json['sub_category_title'];
//     unitName = json['unit_name'];
//     discountedPrice = json['discounted_price'];
//     subTotal = json['sub_total'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['deal_id'] = this.dealId;
//     data['product_id'] = this.productId;
//     data['sale_amount'] = this.saleAmount;
//     data['sale_discount'] = this.saleDiscount;
//     data['sale_quantity'] = this.saleQuantity;
//     data['unit_id'] = this.unitId;
//     data['category_id'] = this.categoryId;
//     data['sub_category_id'] = this.subCategoryId;
//     data['product_title'] = this.productTitle;
//     data['urdu_title'] = this.urduTitle;
//     data['product_photo'] = this.productPhoto;
//     data['unit_value'] = this.unitValue;
//     data['category_title'] = this.categoryTitle;
//     data['sub_category_title'] = this.subCategoryTitle;
//     data['unit_name'] = this.unitName;
//     data['discounted_price'] = this.discountedPrice;
//     data['sub_total'] = this.subTotal;
//     return data;
//   }
// }
