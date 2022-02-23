
import 'package:get/get.dart';

class OrderHistoryModal {
  RxList<Order> orders = <Order>[].obs;
  RxInt totalPages= 1.obs;

  OrderHistoryModal({this.orders, this.totalPages});

  OrderHistoryModal.fromJson(Map<String, dynamic> json) {
    if (json['orders'] != null) {
      orders = <Order>[].obs;
      json['orders'].forEach((v) {
        orders.add(new Order.fromJson(v));
      });
    }
    totalPages.value = json['total_pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orders != null) {
      data['orders'] = this.orders.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = this.totalPages.value;
    return data;
  }
}

class Order {
  String id;
  String customerType;
  String customerId;
  String addressId;

  String address;
  String manualAddress;

  String deliveryDate;
  String slotId;
  String orderNotes;
  String amount;
  String productDelivery;
  String packagingCharges;
  String isPaid;
  String paidAmount;
  String paidDate;
  BillingAddress billingAddress;
  String status;
  String createdDate;
  String verifiedDate;
  String processedDate;
  String updatedDate;
  String cancelledDate;
  String deletedFlag;
  String driverId;
  String assignedDate;
  String userId;
  String searchDate;
  String timeFrom;
  String timeTo;
  String label;
  DriverDetails driverDetails;
  List<OrderDetails> orderDetails;

  Order(
      {this.id,
        this.customerType,
        this.customerId,
        this.addressId,

        this.address,
        this.manualAddress,

        this.deliveryDate,
        this.slotId,
        this.orderNotes,
        this.amount,
        this.productDelivery,
        this.packagingCharges,
        this.isPaid,
        this.paidAmount,
        this.paidDate,
        this.billingAddress,
        this.status,
        this.createdDate,
        this.verifiedDate,
        this.processedDate,
        this.updatedDate,
        this.cancelledDate,
        this.deletedFlag,
        this.driverId,
        this.assignedDate,
        this.userId,
        this.searchDate,
        this.timeFrom,
        this.timeTo,
        this.label,
        this.driverDetails,
        this.orderDetails});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerType = json['customer_type'];
    customerId = json['customer_id'];
    addressId = json['address_id'];

    address = json['address'];
    manualAddress = json['manual_address'];

    deliveryDate = json['delivery_date'];
    slotId = json['slot_id'];
    orderNotes = json['order_notes'];
    amount = json['amount'];
    productDelivery = json['product_delivery'];
    packagingCharges = json['packaging_charges'];
    isPaid = json['is_paid'];
    paidAmount = json['paid_amount'];
    paidDate = json['paid_date'];
    billingAddress = json['billing_address'] != null
        ? new BillingAddress.fromJson(json['billing_address'])
        : null;
    status = json['status'];
    createdDate = json['created_date'];
    verifiedDate = json['verified_date'];
    processedDate = json['processed_date'];
    updatedDate = json['updated_date'];
    cancelledDate = json['cancelled_date'];
    deletedFlag = json['deleted_flag'];
    driverId = json['driver_id'];
    assignedDate = json['assigned_date'];
    userId = json['user_id'];
    searchDate = json['search_date'];
    timeFrom = json['time_from'];
    timeTo = json['time_to'];
    label = json['label'];
    driverDetails = json['driver_details'] != null
        ? new DriverDetails.fromJson(json['driver_details'])
        : null;
    if (json['order_details'] != null) {
      orderDetails = new List<OrderDetails>();
      json['order_details'].forEach((v) {
        orderDetails.add(new OrderDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_type'] = this.customerType;
    data['customer_id'] = this.customerId;
    data['address_id'] = this.addressId;

    data['address'] = this.address;
    data['manual_address'] = this.manualAddress;

    data['delivery_date'] = this.deliveryDate;
    data['slot_id'] = this.slotId;
    data['order_notes'] = this.orderNotes;
    data['amount'] = this.amount;
    data['product_delivery'] = this.productDelivery;
    data['packaging_charges'] = this.packagingCharges;
    data['is_paid'] = this.isPaid;
    data['paid_amount'] = this.paidAmount;
    data['paid_date'] = this.paidDate;
    if (this.billingAddress != null) {
      data['billing_address'] = this.billingAddress.toJson();
    }
    data['status'] = this.status;
    data['created_date'] = this.createdDate;
    data['verified_date'] = this.verifiedDate;
    data['processed_date'] = this.processedDate;
    data['updated_date'] = this.updatedDate;
    data['cancelled_date'] = this.cancelledDate;
    data['deleted_flag'] = this.deletedFlag;
    data['driver_id'] = this.driverId;
    data['assigned_date'] = this.assignedDate;
    data['user_id'] = this.userId;
    data['search_date'] = this.searchDate;
    data['time_from'] = this.timeFrom;
    data['time_to'] = this.timeTo;
    data['label'] = this.label;
    if (this.driverDetails != null) {
      data['driver_details'] = this.driverDetails.toJson();
    }
    if (this.orderDetails != null) {
      data['order_details'] = this.orderDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BillingAddress {
  String id;
  String postcode;
  String city;
  String address;
  String manualAddress;
  String colonyName;

  BillingAddress(
      {this.id, this.postcode, this.city, this.address, this.manualAddress, this.colonyName});

  BillingAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    postcode = json['postcode'];
    city = json['city'];
    address = json['address'];
    manualAddress = json['manual_address'];
    colonyName = json['colony_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['postcode'] = this.postcode;
    data['city'] = this.city;
    data['address'] = this.address;
    data['manual_address'] = this.manualAddress;
    data['colony_name'] = this.colonyName;
    return data;
  }
}

class DriverDetails {
  String name;
  String phone;

  DriverDetails({this.name, this.phone});

  DriverDetails.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    return data;
  }
}

class OrderDetails {
  String id;
  String orderId;
  String productId;
  String saleAmount;
  String saleDiscount;
  String saleQuantity;
  String type;
  String unitId;
  String categoryId;
  String subCategoryId;
  String productPhoto;
  String unitValue;
  String productTitle;
  String urduTitle;
  String categoryTitle;
  String subCategoryTitle;
  String unitName;
  String discountedPrice;
  String subTotal;

  String fullImage;
  String squareImage;

  DealInformation dealInformation;
  List<DealDetails> dealDetails;

  OrderDetails(
      {this.id,
        this.orderId,
        this.productId,
        this.saleAmount,
        this.saleDiscount,
        this.saleQuantity,
        this.type,
        this.unitId,
        this.categoryId,
        this.subCategoryId,
        this.productPhoto,
        this.unitValue,
        this.productTitle,
        this.urduTitle,
        this.categoryTitle,
        this.subCategoryTitle,
        this.unitName,
        this.discountedPrice,
        this.subTotal,

        this.fullImage,
        this.squareImage,

        this.dealInformation,
        this.dealDetails});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    productId = json['product_id'];
    saleAmount = json['sale_amount'];
    saleDiscount = json['sale_discount'];
    saleQuantity = json['sale_quantity'];
    type = json['type'];
    unitId = json['unit_id'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    productPhoto = json['product_photo'];
    unitValue = json['unit_value'];
    productTitle = json['product_title'];
    urduTitle = json['urdu_title'];
    categoryTitle = json['category_title'];
    subCategoryTitle = json['sub_category_title'];
    unitName = json['unit_name'];
    discountedPrice = json['discounted_price'];
    subTotal = json['sub_total'];

    fullImage = json['full_image'];
    squareImage = json['square_image'];

    dealInformation = json['deal_information'] != null
        ? new DealInformation.fromJson(json['deal_information'])
        : null;
    if (json['deal_details'] != null) {
      dealDetails = new List<DealDetails>();
      json['deal_details'].forEach((v) {
        dealDetails.add(new DealDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['product_id'] = this.productId;
    data['sale_amount'] = this.saleAmount;
    data['sale_discount'] = this.saleDiscount;
    data['sale_quantity'] = this.saleQuantity;
    data['type'] = this.type;
    data['unit_id'] = this.unitId;
    data['category_id'] = this.categoryId;
    data['sub_category_id'] = this.subCategoryId;
    data['product_photo'] = this.productPhoto;
    data['unit_value'] = this.unitValue;
    data['product_title'] = this.productTitle;
    data['urdu_title'] = this.urduTitle;
    data['category_title'] = this.categoryTitle;
    data['sub_category_title'] = this.subCategoryTitle;
    data['unit_name'] = this.unitName;
    data['discounted_price'] = this.discountedPrice;
    data['sub_total'] = this.subTotal;

    data['full_image'] = this.fullImage;
    data['square_image'] = this.squareImage;
    if (this.dealInformation != null) {
      data['deal_information'] = this.dealInformation.toJson();
    }
    if (this.dealDetails != null) {
      data['deal_details'] = this.dealDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DealInformation {
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
  String originalDealTotal;
  String fullImage;
  String squareImage;

  DealInformation(
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
        this.originalDealTotal,
      this.fullImage,
        this.squareImage,
      });

  DealInformation.fromJson(Map<String, dynamic> json) {
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
    originalDealTotal = json['original_deal_total'];

    fullImage = json['full_image'];
    squareImage = json['square_image'];
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
    data['original_deal_total'] = this.originalDealTotal;


    data['full_image'] = this.fullImage;
    data['square_image'] = this.squareImage;
    return data;
  }
}

class DealDetails {
  String id;
  String dealId;
  String productId;
  String saleAmount;
  String saleDiscount;
  String saleQuantity;
  String unitId;
  String categoryId;
  String subCategoryId;
  String productTitle;
  String urduTitle;
  String productPhoto;
  String unitValue;
  String categoryTitle;
  String subCategoryTitle;
  String unitName;
  String discountedPrice;
  String subTotal;

  DealDetails(
      {this.id,
        this.dealId,
        this.productId,
        this.saleAmount,
        this.saleDiscount,
        this.saleQuantity,
        this.unitId,
        this.categoryId,
        this.subCategoryId,
        this.productTitle,
        this.urduTitle,
        this.productPhoto,
        this.unitValue,
        this.categoryTitle,
        this.subCategoryTitle,
        this.unitName,
        this.discountedPrice,
        this.subTotal});

  DealDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dealId = json['deal_id'];
    productId = json['product_id'];
    saleAmount = json['sale_amount'];
    saleDiscount = json['sale_discount'];
    saleQuantity = json['sale_quantity'];
    unitId = json['unit_id'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    productTitle = json['product_title'];
    urduTitle = json['urdu_title'];
    productPhoto = json['product_photo'];
    unitValue = json['unit_value'];
    categoryTitle = json['category_title'];
    subCategoryTitle = json['sub_category_title'];
    unitName = json['unit_name'];
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
    data['unit_id'] = this.unitId;
    data['category_id'] = this.categoryId;
    data['sub_category_id'] = this.subCategoryId;
    data['product_title'] = this.productTitle;
    data['urdu_title'] = this.urduTitle;
    data['product_photo'] = this.productPhoto;
    data['unit_value'] = this.unitValue;
    data['category_title'] = this.categoryTitle;
    data['sub_category_title'] = this.subCategoryTitle;
    data['unit_name'] = this.unitName;
    data['discounted_price'] = this.discountedPrice;
    data['sub_total'] = this.subTotal;
    return data;
  }
}
