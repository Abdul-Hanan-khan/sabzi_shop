import 'package:get/get.dart';
import 'package:sabzishop/modal/product.dart';

import 'deal.dart';



class Cart {
  RxList<Product> products = <Product>[].obs;
  RxList<Deal> deals = <Deal>[].obs;
  Cart({this.products,this.deals});

  Cart.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products= <Product>[].obs;
      json['products'].forEach((v) {
        products.add(new Product.fromJson(v));
      });
    }
    if (json['deals'] != null) {
      deals= <Deal>[].obs;
      json['deals'].forEach((v) {
        deals.add(new Deal.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    if (this.deals != null) {
      data['deals'] = this.deals.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
