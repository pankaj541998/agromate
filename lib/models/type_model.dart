class TypeModel {
  List<TypeData>? data;

  TypeModel({this.data});

  TypeModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <TypeData>[];
      json['data'].forEach((v) {
        data!.add(new TypeData.fromJson(v));
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

class TypeData {
  int? id;
  String? classid;
  String? type;
  String? typeDescription;
  int? isActive;
  String? createdAt;
  String? updatedAt;

  TypeData(
      {this.id,
      this.classid,
      this.type,
      this.typeDescription,
      this.isActive,
      this.createdAt,
      this.updatedAt});

  TypeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    classid = json['classid'];
    type = json['type'];
    typeDescription = json['type_description'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['classid'] = this.classid;
    data['type'] = this.type;
    data['type_description'] = this.typeDescription;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
