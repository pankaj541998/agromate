class TypeModel {
  int? id;
  Null? classid;
  String? type;
  String? createdAt;
  String? updatedAt;

  TypeModel({this.id, this.classid, this.type, this.createdAt, this.updatedAt});

  TypeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    classid = json['classid'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['classid'] = this.classid;
    data['type'] = this.type;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
