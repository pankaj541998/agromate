class GapQuestion {
  int? id;
  String? gapCategory;
  int? isActive;
  int? isDelete;
  String? createdAt;
  String? updatedAt;

  GapQuestion(
      {this.id,
      this.gapCategory,
      this.isActive,
      this.isDelete,
      this.createdAt,
      this.updatedAt});

  GapQuestion.fromJson(Map<String, dynamic> json) {
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
