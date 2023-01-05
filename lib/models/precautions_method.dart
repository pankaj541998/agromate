class PrecautionsModel {
  List<PrecautionsData>? data;

  PrecautionsModel({this.data});

  PrecautionsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <PrecautionsData>[];
      json['data'].forEach((v) {
        data!.add(new PrecautionsData.fromJson(v));
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

class PrecautionsData {
  int? id;
  String? precautionName;
  String? createdAt;
  String? updatedAt;

  PrecautionsData(
      {this.id, this.precautionName, this.createdAt, this.updatedAt});

  PrecautionsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    precautionName = json['precaution_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['precaution_name'] = this.precautionName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
