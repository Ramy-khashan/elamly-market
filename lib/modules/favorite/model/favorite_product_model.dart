class FavoriteProductModel {
  String? id;
  String? productId;
  String? productName;
  String? productImageUrl;

  FavoriteProductModel(
      {this.id, this.productId, this.productName, this.productImageUrl});

  FavoriteProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    productName = json['product_name'];
    productImageUrl = json['product_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['product_image'] = this.productImageUrl;
    return data;
  }
}
