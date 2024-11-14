class CartModel {
  String? id;
  int? quantity;
  String? productId;
  String? productName;
  bool? productIsOnSale;
  String? productSalePrice;
  String? productPrice;
  String? productImage;

  CartModel(
      {this.id,
      this.quantity,
      this.productId,
      this.productName,
      this.productIsOnSale,
      this.productSalePrice,
      this.productPrice,
      this.productImage});

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    productId = json['product_id'];
    productName = json['product_name'];
    productIsOnSale = json['product_is_on_sale'];
    productSalePrice = json['product_sale_price'];
    productPrice = json['product_price'];
    productImage = json['product_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quantity'] = this.quantity;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['product_is_on_sale'] = this.productIsOnSale;
    data['product_sale_price'] = this.productSalePrice;
    data['product_price'] = this.productPrice;
    data['product_image'] = this.productImage;
    return data;
  }
}
