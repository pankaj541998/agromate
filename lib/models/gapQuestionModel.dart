class GapQuestion {
  List<Data>? data;

  GapQuestion({this.data});

  GapQuestion.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  int? id;
  int? gapCategoryId;
  String? question;
  int? options;
  int? text;
  int? image;
  int? isActive;
  int? isDelete;
  String? createdAt;
  String? updatedAt;
  Gapcategory? gapcategory;

  Data(
      {this.id,
      this.gapCategoryId,
      this.question,
      this.options,
      this.text,
      this.image,
      this.isActive,
      this.isDelete,
      this.createdAt,
      this.updatedAt,
      this.gapcategory});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gapCategoryId = json['gap_category_id'];
    question = json['question'];
    options = json['options'];
    text = json['text'];
    image = json['image'];
    isActive = json['is_active'];
    isDelete = json['is_delete'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    gapcategory = json['gapcategory'] != null
        ? new Gapcategory.fromJson(json['gapcategory'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['gap_category_id'] = this.gapCategoryId;
    data['question'] = this.question;
    data['options'] = this.options;
    data['text'] = this.text;
    data['image'] = this.image;
    data['is_active'] = this.isActive;
    data['is_delete'] = this.isDelete;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.gapcategory != null) {
      data['gapcategory'] = this.gapcategory!.toJson();
    }
    return data;
  }
}

class Gapcategory {
  int? id;
  String? gapCategory;
  int? isActive;
  int? isDelete;
  String? createdAt;
  String? updatedAt;

  Gapcategory(
      {this.id,
      this.gapCategory,
      this.isActive,
      this.isDelete,
      this.createdAt,
      this.updatedAt});

  Gapcategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gapCategory = json['gap_category'];
    isActive = json['is_active'];
    isDelete = json['is_delete'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['gap_category'] = this.gapCategory;
    data['is_active'] = this.isActive;
    data['is_delete'] = this.isDelete;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
