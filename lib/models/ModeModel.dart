class ModeModel {
  List<ModeData>? data;

  ModeModel({this.data});

  ModeModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ModeData>[];
      json['data'].forEach((v) {
        data!.add(new ModeData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ModeData {
  int? id;
  String? mode;
  String? itemDescription;
  double? applicationCost;
  int? quantity;
  int? value;
  String? createdAt;
  String? updatedAt;

  ModeData(
      {this.id,
      this.mode,
      this.itemDescription,
      this.applicationCost,
      this.quantity,
      this.value,
      this.createdAt,
      this.updatedAt});

  ModeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mode = json['mode'];
    itemDescription = json['item_description'];
    applicationCost = json['application_cost'];
    quantity = json['quantity'];
    value = json['value'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mode'] = this.mode;
    data['item_description'] = this.itemDescription;
    data['application_cost'] = this.applicationCost;
    data['quantity'] = this.quantity;
    data['value'] = this.value;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
