class OrdersModel {
  String? orderId;
  String? deliveryAddressId;
  bool? isCancelled;
  String? createdAt;
  List<Products>? products;
  bool? isPaid;
  String? totalPrice;
  String? userId;
  String? deliveryFees;
  String? code;
  String? cancelReason;

  OrdersModel(
      {this.deliveryAddressId,
      this.isCancelled,
      this.orderId,
      this.createdAt,
      this.cancelReason,
      this.products,
      this.isPaid,
      this.totalPrice,
      this.deliveryFees,
      this.code,
      this.userId});

  OrdersModel.fromJson(Map<String, dynamic> json) {
    deliveryAddressId = json['delivery_address_id'];
    isCancelled = json['is_cancelled'];
    cancelReason = json['cancelReason'];
    createdAt = json['c'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    isPaid = json['is_paid'];
    totalPrice = json['total_price'];
    userId = json['user_id'];
    deliveryFees = json['delivery_fees'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['delivery_address_id'] = this.deliveryAddressId;
    data['is_cancelled'] = this.isCancelled;
    data['created_at'] = this.createdAt;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    data['is_paid'] = this.isPaid;
    data['total_price'] = this.totalPrice;
    data['user_id'] = this.userId;
    data['delivery_fees'] = this.deliveryFees;
    return data;
  }
}

class Products {
  String? quantity;
  String? productId;
  bool? isOnSale;
  String? productTitle;
  String? price;
  String? otherPrice;

  Products(
      {this.quantity,
      this.productId,
      this.isOnSale,
      this.productTitle,
      this.price,
      this.otherPrice});

  Products.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    productId = json['product_id'];
    isOnSale = json['is_on_sale'];
    productTitle = json['product_title'];
    price = json['price'];
    otherPrice = json['other_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quantity'] = this.quantity;
    data['product_id'] = this.productId;
    data['is_on_sale'] = this.isOnSale;
    data['product_title'] = this.productTitle;
    data['price'] = this.price;
    data['other_price'] = this.otherPrice;
    return data;
  }
}
