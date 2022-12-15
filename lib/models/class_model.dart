class ClassModel {
  List<ClassData>? data;

  ClassModel({this.data});

  ClassModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ClassData>[];
      json['data'].forEach((v) {
        data!.add(ClassData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ClassData {
  int? id;
  String? iclass;
  String? classDescription;
  int? isActive;
  String? createdAt;
  String? updatedAt;

  ClassData(
      {this.id,
      this.iclass,
      this.classDescription,
      this.isActive,
      this.createdAt,
      this.updatedAt});

  ClassData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    iclass = json['iclass'];
    classDescription = json['class_description'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['iclass'] = this.iclass;
    data['class_description'] = this.classDescription;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
