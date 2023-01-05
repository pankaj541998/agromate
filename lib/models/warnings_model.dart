class WarningsModel {
  List<WarningsData>? data;

  WarningsModel({this.data});

  WarningsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <WarningsData>[];
      json['data'].forEach((v) {
        data!.add(new WarningsData.fromJson(v));
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

class WarningsData {
  int? id;
  String? warningName;
  String? createdAt;
  String? updatedAt;

  WarningsData({this.id, this.warningName, this.createdAt, this.updatedAt});

  WarningsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    warningName = json['warning_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['warning_name'] = this.warningName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
