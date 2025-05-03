class AdsModel {
  String? title;
  String? id;
  String? image;
  String? url;

  AdsModel({this.title, this.id, this.image, this.url});

  AdsModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    id = json['id'];
    image = json['image'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['id'] = id;
    data['image'] = image;
    data['url'] = url;
    return data;
  }
}
