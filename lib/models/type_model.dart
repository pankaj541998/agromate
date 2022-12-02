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
  Inventoryclass? inventoryclass;

  TypeData(
      {this.id,
      this.classid,
      this.type,
      this.typeDescription,
      this.isActive,
      this.createdAt,
      this.updatedAt,
      this.inventoryclass});

  TypeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    classid = json['classid'];
    type = json['type'];
    typeDescription = json['type_description'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    inventoryclass = json['inventoryclass'] != null
        ? new Inventoryclass.fromJson(json['inventoryclass'])
        : null;
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
    if (this.inventoryclass != null) {
      data['inventoryclass'] = this.inventoryclass!.toJson();
    }
    return data;
  }
}

class Inventoryclass {
  int? id;
  String? iclass;
  String? classDescription;
  int? isActive;
  String? createdAt;
  String? updatedAt;

  Inventoryclass(
      {this.id,
      this.iclass,
      this.classDescription,
      this.isActive,
      this.createdAt,
      this.updatedAt});

  Inventoryclass.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    iclass = json['iclass'];
    classDescription = json['class_description'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['iclass'] = this.iclass;
    data['class_description'] = this.classDescription;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
