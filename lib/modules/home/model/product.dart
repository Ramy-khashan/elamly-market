class ProductModel {
  String? id;
  String? title;
  String? description;
  String? category;
  String? categoryId;
  String? price;
  String? onSalePrice;
  bool? isOnSale;
  String? quantity;
  List<String>? images;
  String? createdAt;
  String? createdBy;

  ProductModel(
      {this.id,
      this.title,
      this.description,
      this.category,
      this.categoryId,
      this.price,
      this.onSalePrice,
      this.isOnSale,
      this.quantity,
      this.images,
      this.createdAt,
      this.createdBy});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    category = json['category'];
    categoryId = json['category_id'];
    price = json['price'];
    onSalePrice = json['on_sale_price'];
    isOnSale = json['is_on_sale'];
    quantity = json['quantity'];
    images = json['images'].cast<String>();
    createdAt = json['created_at'];
    createdBy = json['created_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['category'] = category;
    data['category_id'] = categoryId;
    data['price'] = price;
    data['on_sale_price'] = onSalePrice;
    data['is_on_sale'] = isOnSale;
    data['quantity'] = quantity;
    data['images'] = images;
    data['created_at'] = createdAt;
    data['created_by'] = createdBy;
    return data;
  }
}
