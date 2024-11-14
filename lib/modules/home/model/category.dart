class CategoryModel {
  String? title;
  String? id;
  String? image;

  CategoryModel({this.title, this.id, this.image});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    id = json['id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['id'] = id;
    data['image'] = image;
    return data;
  }
}
