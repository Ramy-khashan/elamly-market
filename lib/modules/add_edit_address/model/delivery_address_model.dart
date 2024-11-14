class DeliveryAddressModel {
  String? id;
  String? fullName;
  String? phone1;
  String? phone2;
  String? fullAddress;
  String? landmark;

  DeliveryAddressModel(
      {this.id,
      this.fullName,
      this.phone1,
      this.phone2,
      this.fullAddress,
      this.landmark});

  DeliveryAddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    phone1 = json['phone1'];
    phone2 = json['phone2'];
    fullAddress = json['full_address'];
    landmark = json['landmark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['phone1'] = this.phone1;
    data['phone2'] = this.phone2;
    data['full_address'] = this.fullAddress;
    data['landmark'] = this.landmark;
    return data;
  }
}
