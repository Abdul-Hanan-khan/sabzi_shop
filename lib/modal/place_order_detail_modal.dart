class PlaceOrderDetailModal {
  String productId;
  String quantity;
  String type;

  PlaceOrderDetailModal({this.productId, this.quantity, this.type});

  PlaceOrderDetailModal.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    quantity = json['quantity'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    data['type'] = this.type;
    return data;
  }
}
